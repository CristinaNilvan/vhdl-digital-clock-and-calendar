library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all;

entity temperatura is
	port(clock, reset : in std_logic;
	temperatura_zeci, temperatura_unitati : out std_logic_vector(3 downto 0));
end entity;

architecture arh_temperatura of temperatura is

signal temperatura_in : std_logic_vector(3 downto 0) := "0000";
signal start_tempertura_zeci : std_logic;

begin
	aflare_temperatura_unitati : entity work.numarator_0_la_9 port map(clock => clock, 
		reset => reset, 
		load => '0',  
		numar_in => temperatura_in,
		numar_out => temperatura_unitati,
		carry => start_tempertura_zeci);
		
	aflare_temperatura_zeci : entity work.numarator_0_la_3 port map(clock => start_tempertura_zeci, 
		reset => reset,
		load => '0',
		numar_in => temperatura_in, 
		numar_out => temperatura_zeci); 
end architecture;