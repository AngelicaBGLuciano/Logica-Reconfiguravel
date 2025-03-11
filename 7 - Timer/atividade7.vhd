library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.ssd.all; -- USO DO ARQUIVO ssd
use work.bcd.all; -- USO DO ARQUIVO bcd

entity atividade7 is 
    generic(f_clk: integer := 50_000_000); -- Clock de 50 MHz
    port(
        -- Switches para velocidade
        sw2, sw1, sw0: in std_logic;
        -- Botão de pausa e reset
        pause, reset: in std_logic;
        -- Clock
        clk: in std_logic;
        -- SSDs
        ssd1, ssd2, ssd3, ssd4: out std_logic_vector(6 downto 0);
        -- LED 0
        led0: out std_logic
    );
end atividade7;

architecture main of atividade7 is 
    signal segundos: integer range 0 to 9999 := 1000; -- Inicia com 1000 segundos
    signal contador: integer range 0 to f_clk-1 := 0;
    signal segundos_aux: integer range 0 to 9999 := 1000; 
    signal tempo_intervalo: integer range 1 to f_clk := f_clk; -- Intervalo de contagem
    signal pausado: std_logic := '0';

    -- Debounce do botão pause
    signal pause_antigo: std_logic := '0';

begin 
    -- Processo para contagem
    process(clk, reset)
        variable switch_vector: std_logic_vector(2 downto 0);
    begin
        if reset = '0' then
            segundos <= segundos_aux;
            contador <= 0;
            pausado <= '0';
            led0 <= '0'; -- Garante que o LED começa apagado
        elsif rising_edge(clk) then
            -- Conversão correta dos switches para um vetor
            switch_vector := sw2 & sw1 & sw0;

            -- Controle de velocidade pelos switches
            case switch_vector is
                when "001" => tempo_intervalo <= f_clk;     -- Normal (1s por contagem)
                when "010" => tempo_intervalo <= f_clk / 2; -- 2x mais rápido (0,5s por contagem)
                when "100" => tempo_intervalo <= f_clk / 4; -- 4x mais rápido (0,25s por contagem)
                when others => tempo_intervalo <= f_clk;    -- Padrão: Normal (segurança)
            end case;
            
            -- Controle de pausa com debounce
            if pause = '1' and pause_antigo = '0' then
                pausado <= not pausado;
            end if;
            pause_antigo <= pause; -- Armazena estado anterior do botão

            -- Se não estiver pausado, faz a contagem regressiva
            if pausado = '0' then
                if contador >= tempo_intervalo and segundos > 0 then
                    segundos <= segundos - 1;
                    contador <= 0;
                    led0 <= '0'; -- LED apagado enquanto conta
                else
                    contador <= contador + 1;
                end if;
            end if;

            -- LED 0 acende quando o tempo chega a 0
            if segundos = 0 then
                led0 <= '1'; -- Acende LED 0
            end if;
        end if;
    end process;

    -- Conversor de segundos para SSDs
    process(segundos)
    begin
        ssd_numbers_int(segundos, ssd1, ssd2, ssd3, ssd4);
    end process;

end main;