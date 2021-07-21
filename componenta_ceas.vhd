library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ceas is
port (clock, reset, load : in std_logic;
	ora_in_1 : in std_logic_vector(3 downto 0); 
	ora_in_0 : in std_logic_vector(3 downto 0);
	minut_in_1 : in std_logic_vector(3 downto 0); 
	minut_in_0 : in std_logic_vector(3 downto 0);  
	ora_out_1 : out std_logic_vector(3 downto 0); 
	ora_out_0 : out std_logic_vector(3 downto 0);
	minut_out_1 : out std_logic_vector(3 downto 0); 
	minut_out_0 : out std_logic_vector(3 downto 0);
	semnal_pentru_zi : out std_logic);
end entity;	   

architecture arh_ceas of ceas is  

signal secunda_unit_aux : std_logic_vector(3 downto 0) := "0000"; 	 
signal secunda_zeci_aux : std_logic_vector(3 downto 0) := "0000"; 	
signal minut_unit_aux : std_logic_vector(3 downto 0) := "0000";
signal minut_zeci_aux : std_logic_vector(3 downto 0) := "0000";		 
signal ora_unit_aux : std_logic_vector(3 downto 0) := "0000";
signal ora_zeci_aux : std_logic_vector(3 downto 0) := "0000";

signal start_secunda_zeci, start_minut_unitati, start_minut_zeci, start_ora_unitati, start_ora_zeci, resetare_zi : std_logic;

begin
	secunde_unitati : entity work.numarator_0_la_9 port map(clock => clock, 
		reset => reset,
		load => '0',
		numar_in => secunda_unit_aux, 
		numar_out => secunda_unit_aux,
		carry => start_secunda_zeci); 	  
		
	secunda_zeci : entity work.numarator_0_la_5 port map(clock => start_secunda_zeci, 
		reset => reset, 
		load => '0',
		numar_in => secunda_zeci_aux, 
		numar_out => secunda_zeci_aux,
		carry => start_minut_unitati);  
		
	minut_unitati : entity work.numarator_0_la_9 port map(clock => start_minut_unitati, 
		reset => reset,
		load => load,
		numar_in => minut_in_0, 
		numar_out => minut_unit_aux,
		carry => start_minut_zeci);	
		
	minut_zeci : entity work.numarator_0_la_5 port map(clock => start_minut_zeci, 
		reset => reset,
		load => load,
		numar_in => minut_in_1, 
		numar_out => minut_zeci_aux,
		carry => start_ora_unitati); 	
		
	ora_unitati : entity work.numarator_0_la_9 port map(clock => start_ora_unitati, 
		reset => resetare_zi,
		load => load,
		numar_in => ora_in_0, 
		numar_out => ora_unit_aux,
		carry => start_ora_zeci);
	
	ora_zeci : entity work.numarator_0_la_2 port map(clock => start_ora_zeci, 
		reset => resetare_zi,
		load => load,
		numar_in => ora_in_1, 
		numar_out => ora_zeci_aux);	 
		
	compara_ora_24 : entity	work.comparator_ora_24 port map(ora_zeci => ora_zeci_aux,
		ora_unitati => ora_unit_aux,
		minut_zeci => minut_zeci_aux,
		minut_unitati => minut_unit_aux,
		ora_24 => resetare_zi);
	
	minut_out_0 <= minut_unit_aux;
	minut_out_1 <= minut_zeci_aux; 
	ora_out_0 <= ora_unit_aux;
	ora_out_1 <= ora_zeci_aux;
	
	semnal_pentru_zi <= resetare_zi;
	
end architecture;