-------------------------------------- pacotes
library ieee;								
use ieee . std_logic_1164 . all ;
-------------------------------------- entidade
entity atividade_1 is     						-- entidade, nome do projeto
port (									-- portas
	a , b: in bit ;							-- entradas tipo bit (0/1)
	z, y, w,t, u, v, s, r: out bit		                        -- saida tipo bit
	);
end entity ;								-- fim da entidade
-------------------------------------- arquitetura
architecture atividade_1 of atividade_1 is				-- arquitetura
begin									--começo, pode declarar coisas antes do begin
	z <= a and b;							-- z recebe um and entre a e b
	y <= a or b;							-- y recebe um or entre a e b
	w <= not a;							-- w recebe not de a
	r <= not b;							-- r recebe not de b
	t <= a xor b;							-- t recebe xor entre a e b
	u <= a xnor b;							-- u recebe xnor entre a e b
	v <= a nand b;							-- v recebe nand entre a e b
	s <= a nor b;							-- s recebe nor entre a e b
end architecture ;							-- fim da arquitetura
--------------------------------------
