library ieee;
use ieee.std_logic_1164.all;

entity atividade4 is
    GENERIC (
        N : INTEGER := 2;    -- numero de bits 
        M : INTEGER := 2     -- tamanho das entradas
    );
    PORT (
        -- Selecao
        sel      : in INTEGER range 0 to 2**N-1; 
        -- Saida
        saida    : out STD_LOGIC_VECTOR(M-1 DOWNTO 0);  
        -- Entradas
        sw : in STD_LOGIC_VECTOR(((2**N) * M) - 1 DOWNTO 0) 
    );
end entity;

architecture atividade4 of atividade4 is
begin
    gen: for i in saida'range generate
        saida(i) <= sw((sel * M) + i);  
    end generate;
end architecture;