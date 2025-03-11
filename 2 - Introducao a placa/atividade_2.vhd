----------------------------------------------- pacotes
library ieee;								
use ieee . std_logic_1164 . all ;
----------------------------------------------- entidade
entity atividade_2 is     			-- entidade, nome do projeto
port (						-- portas
	a , b, c, d: in bit ;			-- entradas tipo bit (0/1)
	z: out bit		                -- saida tipo bit
	);
end entity ;					-- fim da entidade
----------------------------------------------- arquitetura
architecture atividade_2 of atividade_2 is 	
signal y, t, u, v, w : bit;			-- sinais para usar como auxiliar
begin						-- começo
	y <= ((not c) and (not d) );		-- c * d
	t <= ((not a) and (not b));		-- a * b
	u <= ((not a) and (not c));		-- a * c
	v <= ((not b) and (not d));		-- b * d
	w <= ((not b) and (not c));		-- b * c
	
	z <= y or t or u or v or w;		-- saida z = y + t + u + v + w 
end architecture ;				-- fim da arquitetura
-----------------------------------------------
