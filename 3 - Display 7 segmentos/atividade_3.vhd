---------------------------------------
library ieee ;
use ieee . std_logic_1164 . all ;
-- ------------------------------------
entity atividade_3 is
port (
		num1, num2: in std_logic_vector (3 downto 0) ; 		-- cada numero vai ser formado por 4 entradas
		SSD0, SSD1: out std_logic_vector (7 downto 0) 		-- 7 valores para acender o display
		);
end entity ;
architecture atividade_3 of atividade_3 is
begin
	SSD0 <=  "11000000" when num1 = "0000" else
				"11111001" when num1 = "0001" else
				"10100100" when num1 = "0010" else
				"10110000" when num1 = "0011" else
				"10011001" when num1 = "0100" else
				"10010010" when num1 = "0101" else
				"10000010" when num1 = "0110" else
				"11111000" when num1 = "0111" else
				"10000000" when num1 = "1000" else
				"10011000" when num1 = "1001" else
				"10000110";
	SSD1 <=  "11000000" when num2 = "0000" else
				"11111001" when num2 = "0001" else
				"10100100" when num2 = "0010" else
				"10110000" when num2 = "0011" else
				"10011001" when num2 = "0100" else 
				"10010010" when num2 = "0101" else 
				"10000010" when num2 = "0110" else
				"11111000" when num2 = "0111" else
				"10000000" when num2 = "1000" else 
				"10011000" when num2 = "1001" else
				"10000110";		
end architecture ;
 -- ------------------------------------
