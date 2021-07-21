library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity comparator_ora_24 is
	port(ora_zeci : in std_logic_vector(3 downto 0);
	ora_unitati : in std_logic_vector(3 downto 0);
	minut_zeci : in std_logic_vector(3 downto 0);
	minut_unitati : in std_logic_vector(3 downto 0);
	ora_24 : out std_logic);
end entity;	  

architecture arh_comparator_ora_24 of comparator_ora_24 is	 

signal semnal_1, semnal_2 : std_logic;	 
signal doi : std_logic_vector(3 downto 0) := "0010";
signal trei : std_logic_vector(3 downto 0) := "0011"; 
signal cinci : std_logic_vector(3 downto 0) := "0101";
signal noua : std_logic_vector(3 downto 0) := "1001";

begin
	ora_24 <= '1' when (ora_zeci = doi) and (ora_unitati = trei) and (minut_zeci = cinci) and (minut_unitati = noua)
	else '0';
	
end architecture;