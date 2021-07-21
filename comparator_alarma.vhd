library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;	

entity comparator is
	port(ora_zeci : in std_logic_vector(3 downto 0);
	ora_unitati : in std_logic_vector(3 downto 0);
	minut_zeci : in std_logic_vector(3 downto 0);
	minut_unitati : in std_logic_vector(3 downto 0);
	alarma_ora_zeci : in std_logic_vector(3 downto 0);
	alarma_ora_unitati : in std_logic_vector(3 downto 0);
	alarma_minut_zeci : in std_logic_vector(3 downto 0);
	alarma_minut_unitati: in std_logic_vector(3 downto 0);
	egale : out std_logic);
end entity;

architecture arh_comparator of comparator is

begin
	egale <= '1' when (ora_zeci = alarma_ora_zeci) and (ora_unitati = alarma_ora_unitati) 
		and (minut_zeci = alarma_minut_zeci) and (minut_unitati = alarma_minut_unitati)
				else '0';
end architecture;