library ieee;
use ieee.std_logic_1164.all;   
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

use ieee.std_logic_unsigned.all;	

entity comparator_numar_zile is
	port(zi_zeci, numar_zile_zeci, zi_unitati, numar_zile_unitati : in std_logic_vector(3 downto 0);
	egale : out std_logic);
end entity;

architecture arh_comparator_numar_zile of comparator_numar_zile is

begin
	egale <= '1' when (zi_zeci = numar_zile_zeci) and (zi_unitati = numar_zile_unitati) --+ "0001") 
				else '0';
end architecture;
