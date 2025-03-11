library ieee;
use ieee.std_logic_1164;
use ieee.numeric_std.all;
use work.min_max_pkg.all;

entity atividade6 is 
	
	port(
			entrada1, entrada2, entrada3, entrada4: in unsigned(5 downto 0);
			min, max: out unsigned(5 downto 0));
end;

architecture main of atividade6 is 
begin 
	min_max(entrada1, entrada2, entrada3, entrada4, min, max);
end;