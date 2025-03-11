library ieee;
use ieee.std_logic_1164.all;

entity atividade_5 is
    generic (
        f_clk: integer := 50_000_000 -- Frequencia do clock (Hz)
    ); 
    port (
        clk: in std_logic;
        leds: buffer std_logic_vector(9 DOWNTO 0);
        enable, reset: in std_logic;
		  -- Velocidades
        set_velocidade1, set_velocidade2: in std_logic 
    );
end entity;

architecture atividade_5 of atividade_5 is
    constant tempo_piscar: INTEGER := f_clk / 2; -- Meio segundo
begin
    process(clk, enable, reset)
        variable contador_clock: integer range 0 to f_clk'high := 0;
        variable led_index: integer range 0 to 9 := 0; -- led ativo
        variable velocidade: integer range 1 to 20 := 2;
		  -- sentido que os leds "andam"
		  -- 1 = Esquerda, -1 = Direita
        variable sentido: integer := 1; 
    begin
        -- Resetar o circuito
        if reset = '0' then
            contador_clock := 0;
            led_index := 0;
            leds <= (others => '0');
            sentido := 1;
        
        -- Controle principal
        elsif rising_edge(clk) then
            if enable = '1' then
                -- Incrementar o contador do clock
                if contador_clock < (tempo_piscar / velocidade) then
                    contador_clock := contador_clock + 1;
                else
                    -- Reseta contador do clock e altera LEDs
                    contador_clock := 0;
                    leds <= (others => '0'); -- Apaga todos os LEDs
                    leds(led_index) <= '1'; 	-- Acende o LED atual
                    
                    -- Atualiza indice e sentido
                    led_index := led_index + sentido;
                    if led_index = 9 then
                        sentido := -1; -- Mudar sentido
                    elsif led_index = 0 then
                        sentido := 1; -- Mudar sentido
                    end if;
                end if;
                
                -- Ajuste de velocidade
                -- Define a velocidade com base nos switches
                if set_velocidade1 = '1' then 
                    velocidade := 4;
                elsif set_velocidade2 = '1' then 
                    velocidade := 8;
                else 
                    velocidade := 2;
                end if;		
            else
                -- Se o enable estiver desativado
                leds <= (others => '0');
                contador_clock := 0;
                led_index := 0;
                sentido := 1;
            end if;
        end if;
    end process;
end architecture;