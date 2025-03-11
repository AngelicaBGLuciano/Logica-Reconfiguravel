library ieee;
use ieee.std_logic_1164.all;
use work.bcd.all; -- Usando o pacote BCD

package ssd is
    procedure ssd_numbers_int(segundos: in integer; signal out1, out2, out3, out4: out std_logic_vector(6 downto 0));
end package;

package body ssd is
    procedure ssd_numbers_int(segundos: in integer; signal out1, out2, out3, out4: out std_logic_vector(6 downto 0)) is
        variable temp: integer range 0 to 9999;
        variable milhar, centena, dezena, unidade: integer range 0 to 9;
    begin
        -- Extrai os digitos das casas decimais
        temp := segundos;
        milhar := temp / 1000;
        temp := temp mod 1000;
        centena := temp / 100;
        temp := temp mod 100;
        dezena := temp / 10;
        temp := temp mod 10;
        unidade := temp;

        -- Converte cada digito para BCD
        conversor(unidade, out1);
        conversor(dezena, out2);
        conversor(centena, out3);
        conversor(milhar, out4);
    end procedure;
end package body ssd;