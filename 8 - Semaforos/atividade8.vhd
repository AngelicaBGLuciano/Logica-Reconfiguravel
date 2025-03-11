library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity atividade8 is
    port(
        clk      : in std_logic;        -- Clock do sistema
        rst      : in std_logic;        -- Reset
        standby  : in std_logic;        -- Sinal para o modo de standby
        teste    : in std_logic;        -- Sinal para o modo de teste
        led1     : out std_logic_vector(2 downto 0);  -- Semaforo 1 (3 LEDs)
        led2     : out std_logic_vector(2 downto 0)   -- Semaforo 2 (3 LEDs)
    );
end atividade8;

architecture atividade8 of atividade8 is
    -- Definicao dos estados dos semaforos
    type state_type is (verde, amarelo, vermelho);
    signal led1_state, led2_state : state_type; -- Estados dos semaforos 1 e 2
    signal next_led1_state, next_led2_state : state_type; -- Proximos estados
    signal timer : integer range 0 to 250000000;  -- Contador de tempo
    signal blink_timer : integer range 0 to 250000000 := 0;  -- Contador para o piscar dos LEDs
    signal blink_state : std_logic := '0';  -- Estado do piscar

    -- Definição dos tempos dos semáforos
    constant T_GREEN   : integer := 100000000; -- Tempo de verde
    constant T_YELLOW  : integer := 50000000;  -- Tempo de amarelo
    constant T_RED     : integer := 150000000; -- Tempo de vermelho
    constant T_TEST    : integer := 5000000;   -- Tempo reduzido para teste
    constant T_BLINK   : integer := 25000000;  -- Tempo para piscar os amarelos no standby

begin
    -- Processo para controle do timer dos semaforos
    process(clk, rst)
    begin
        if rst = '0' then
            timer <= 0;
        elsif rising_edge(clk) then
            if standby = '0' then
                if timer = 0 then
                    timer <= T_GREEN - 1;
                else
                    timer <= timer - 1;
                end if;
            else
                timer <= 0;
            end if;
        end if;
    end process;

    -- Processo para controle do piscar dos LEDs amarelos no standby
    process(clk, rst)
    begin
        if rst = '0' then
            blink_timer <= 0;
            blink_state <= '0';
        elsif rising_edge(clk) then
            if standby = '1' then
                if blink_timer = T_BLINK - 1 then
                    blink_timer <= 0;
                    blink_state <= not blink_state;  -- Alterna entre 0 e 1
                else
                    blink_timer <= blink_timer + 1;
                end if;
            else
                blink_timer <= 0;
                blink_state <= '0';
            end if;
        end if;
    end process;

    -- Processo da maquina de estados
    process(clk, rst)
    begin
        if rst = '0' then
            led1_state <= verde;  
            led2_state <= vermelho;  
        elsif rising_edge(clk) then
            if standby = '0' then
                led1_state <= next_led1_state;
                led2_state <= next_led2_state;
            end if;
        end if;
    end process;

    -- Logica das transicoes de estado para os semaforos
    process(led1_state, led2_state, timer, teste, standby, blink_state)
    begin
        if standby = '1' then
            -- LEDs amarelos piscam no modo standby
            if blink_state = '1' then
                led1 <= "010";
                led2 <= "010";
            else
                led1 <= "000";
                led2 <= "000";
            end if;
        else
            -- Estado do semaforo 1
            case led1_state is
                when verde =>
                    led1 <= "100";  
                    if (teste = '1' and timer = T_TEST - 1) or (teste = '0' and timer = T_GREEN - 1) then
                        next_led1_state <= amarelo;
                    else
                        next_led1_state <= verde;
                    end if;

                when amarelo =>
                    led1 <= "010";  
                    if (teste = '1' and timer = T_TEST - 1) or (teste = '0' and timer = T_YELLOW - 1) then
                        next_led1_state <= vermelho;
                    else
                        next_led1_state <= amarelo;
                    end if;

                when vermelho =>
                    led1 <= "001";  
                    if (teste = '1' and timer = T_TEST - 1) or (teste = '0' and timer = T_RED - 1) then
                        next_led1_state <= verde;
                    else
                        next_led1_state <= vermelho;
                    end if;
            end case;

            -- Estado do semaforo 2 (oposto ao semáforo 1)
            case led2_state is
                when verde =>
                    led2 <= "100";  
                    if (teste = '1' and timer = T_TEST - 1) or (teste = '0' and timer = T_GREEN - 1) then
                        next_led2_state <= amarelo;
                    else
                        next_led2_state <= verde;
                    end if;

                when amarelo =>
                    led2 <= "010";  
                    if (teste = '1' and timer = T_TEST - 1) or (teste = '0' and timer = T_YELLOW - 1) then
                        next_led2_state <= vermelho;
                    else
                        next_led2_state <= amarelo;
                    end if;

                when vermelho =>
                    led2 <= "001";  
                    if (teste = '1' and timer = T_TEST - 1) or (teste = '0' and timer = T_RED - 1) then
                        next_led2_state <= verde;
                    else
                        next_led2_state <= vermelho;
                    end if;
            end case;
        end if;
    end process;

end atividade8;