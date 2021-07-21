library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity calendar is
   port(clock, reset, load : in std_logic;	 
	 zi_in_1 : in std_logic_vector(3 downto 0); 
	 zi_in_0 : in std_logic_vector(3 downto 0);
	 luna_in_1 : in std_logic_vector(3 downto 0); 
	 luna_in_0 : in std_logic_vector(3 downto 0);
	 an_in_1 : in std_logic_vector(3 downto 0); 
	 an_in_0 : in std_logic_vector(3 downto 0);
	 zi_out_1 : out std_logic_vector(3 downto 0); 
	 zi_out_0 : out std_logic_vector(3 downto 0);
	 luna_out_1 : out std_logic_vector(3 downto 0); 
	 luna_out_0 : out std_logic_vector(3 downto 0);
	 an_out_1 : out std_logic_vector(3 downto 0); 
	 an_out_0 : out std_logic_vector(3 downto 0));
end entity;	 

architecture arh_calendar of calendar is

signal an : std_logic_vector(15 downto 0) := "0010000000000000"; --2000
signal bisect : std_logic;

signal numar_zile_zeci_aux : std_logic_vector(3 downto 0) := "0000";	
signal numar_zile_unit_aux : std_logic_vector(3 downto 0) := "0000";

signal zi_zeci_aux : std_logic_vector(3 downto 0) := "0000";	
signal zi_unit_aux : std_logic_vector(3 downto 0) := "0001";  
signal luna_zeci_aux : std_logic_vector(3 downto 0) := "0000";	 
signal luna_unit_aux : std_logic_vector(3 downto 0) := "0001";	  

signal final_luna, start_zi_zeci, start_luna_zeci, final_an, start_an_unitati, start_an_zeci : std_logic;

begin  
	an(7 downto 4) <= an_in_1;
	an(3 downto 0) <= an_in_0;
	stabileste_an_bisect : entity work.an_bisect port map(an => an,
		bisect => bisect);
		
	stabileste_numar_zile : entity work.numar_zile_din_luna port map(luna_zeci => luna_zeci_aux,
		luna_unitati => luna_unit_aux,
		bisect => bisect,
		zi_zeci => numar_zile_zeci_aux,
		zi_unitati => numar_zile_unit_aux);	  
		
		
	compara_final_luna : entity	work.comparator_numar_zile port map(zi_zeci => zi_zeci_aux,
		numar_zile_zeci => numar_zile_zeci_aux,
		zi_unitati => zi_unit_aux,
		numar_zile_unitati => numar_zile_unit_aux,
		egale => final_luna);
		
	zile_unitati : entity work.numarator_0_la_9 port map(clock => clock, 
		reset => final_luna,
		load => load,
		numar_in => zi_in_0, 
		numar_out => zi_unit_aux,
		carry => start_zi_zeci); 
		
	zile_zeci : entity work.numarator_0_la_3 port map(clock => start_zi_zeci, 
		reset => final_luna, 
		load => load,
		numar_in => zi_in_1, 
		numar_out => zi_zeci_aux);
	
	luna_unitati : entity work.numarator_0_la_9 port map(clock => final_luna, 
		reset => final_an,
		load => load,
		numar_in => luna_in_0, 
		numar_out => luna_unit_aux,
		carry => start_luna_zeci);	
		
	luna_zeci : entity work.numarator_0_la_1 port map(clock => start_luna_zeci, 
		reset => reset,
		load => load,
		numar_in => luna_in_1, 
		numar_out => luna_zeci_aux,
		carry => start_an_unitati); 
		
	compara_final_an : entity work.comparator_final_an port map(luna_zeci => luna_zeci_aux,
		luna_unitati =>	luna_unit_aux,
		final_an => final_an);	 
		
	an_unitati : entity	work.numarator_0_la_9 port map(clock => final_an, 
		reset => reset,
		load => load,
		numar_in => an_in_0, 
		numar_out => an_out_0,
		carry => start_an_zeci);	
		
	an_zeci : entity work.numarator_0_la_9 port map(clock => start_an_zeci, 
		reset => reset,
		load => load,
		numar_in => an_in_1, 
		numar_out => an_out_1);
		
	 zi_out_1 <= zi_zeci_aux;
	 zi_out_0 <= zi_unit_aux;
	 luna_out_1 <= luna_zeci_aux;
	 luna_out_0 <= luna_unit_aux;
		
end architecture;

	