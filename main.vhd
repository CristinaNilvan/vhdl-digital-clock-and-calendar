library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all;

entity agenda_programabila is
	port(clock, reset, enable, load : in std_logic;
	ora_zeci : in std_logic_vector(3 downto 0);
	ora_unit : in std_logic_vector(3 downto 0);	 
	min_zeci : in std_logic_vector(3 downto 0);	 
	min_unit : in std_logic_vector(3 downto 0);	
	zi_zeci : in std_logic_vector(3 downto 0);	 
	zi_unit : in std_logic_vector(3 downto 0);	
	luna_zeci : in std_logic_vector(3 downto 0);   
	luna_unit : in std_logic_vector(3 downto 0);	
	an_1 : in std_logic_vector(3 downto 0);	 
	an_2 : in std_logic_vector(3 downto 0);	  
	ziua_din_saptamana : in std_logic_vector(3 downto 0); 
	al_ora_zeci : in std_logic_vector(3 downto 0);
	al_ora_unit : in std_logic_vector(3 downto 0);	 
	al_min_zeci : in std_logic_vector(3 downto 0);	 
	al_min_unit : in std_logic_vector(3 downto 0);	 
	al_on : in std_logic;
	
	ora_zeci_out : out std_logic_vector(6 downto 0);
	ora_unit_out : out std_logic_vector(6 downto 0); 
	min_zeci_out : out std_logic_vector(6 downto 0);	 
	min_unit_out : out std_logic_vector(6 downto 0);	
	zi_zeci_out : out std_logic_vector(6 downto 0);	 
	zi_unit_out : out std_logic_vector(6 downto 0);	
	luna_zeci_out : out std_logic_vector(6 downto 0);   
	luna_unit_out : out std_logic_vector(6 downto 0);	
	an_1_out : out std_logic_vector(6 downto 0);	 
	an_2_out : out std_logic_vector(6 downto 0);  
	zi_lit_1 : out std_logic_vector(6 downto 0); 
	zi_lit_2 : out std_logic_vector(6 downto 0);
	alarma : out std_logic_vector(6 downto 0);
	temp_1_out : out std_logic_vector(6 downto 0);
	temp_2_out : out std_logic_vector(6 downto 0));			 
end entity;	 

architecture arh_agenda_programabila of agenda_programabila is

signal semnal_pentru_zi : std_logic; 
signal ora_zeci_aux, ora_unit_aux, min_zeci_aux, min_unit_aux : std_logic_vector(3 downto 0);
signal zi_zeci_aux, zi_unit_aux, luna_zeci_aux, luna_unit_aux, an_1_aux, an_2_aux : std_logic_vector(3 downto 0); 
signal temp_1_aux, temp_2_aux : std_logic_vector(3 downto 0); 
signal alarma_aux : std_logic_vector(3 downto 0);

begin  

	ceas_componenta : entity work.ceas port map(clock => clock,
		reset => reset, 
		load => load,
		ora_in_1 => ora_zeci,
		ora_in_0 => ora_unit, 
		minut_in_1 => min_zeci, 
		minut_in_0 => min_unit,  
		ora_out_1 => ora_zeci_aux,
		ora_out_0 => ora_unit_aux,
		minut_out_1 => min_zeci_aux, 
		minut_out_0 => min_unit_aux,
		semnal_pentru_zi => semnal_pentru_zi); 		
		
	calendar_componenta : entity work.calendar port map(clock => semnal_pentru_zi,
		reset => reset, 
		load => load, 
		zi_in_1 => zi_zeci,
	 	zi_in_0 => zi_unit,
		luna_in_1 => luna_zeci,
	 	luna_in_0 => luna_unit,
	 	an_in_1 => an_1,
	 	an_in_0 => an_2,
	 	zi_out_1 => zi_zeci_aux,
	 	zi_out_0 =>	zi_unit_aux,
	 	luna_out_1 => luna_zeci_aux,
	 	luna_out_0 => luna_unit_aux,
	 	an_out_1 => an_1_aux,
	 	an_out_0 => an_2_aux);
		
	zi_cu_litere_componenta : entity work.zi_cu_litere port map(clock => semnal_pentru_zi,
		reset => reset, 
		load => load, 
		numarul_zilei_din_sapt => ziua_din_saptamana,
		zi_lit_unu => zi_lit_1,
		zi_lit_doi => zi_lit_2);	
		
	temperatura_componnta : entity work.temperatura port map(clock => semnal_pentru_zi,
		reset => reset, 
		temperatura_zeci => temp_1_aux,
		temperatura_unitati => temp_2_aux);	  
		
	organigrama_uc : entity work.organigrama port map(clock => clock, 
		al_on => al_on, 
		enable => enable,
		ora_zeci => ora_zeci_aux,
		ora_unitati => ora_unit_aux,
		minut_zeci => min_zeci_aux,
		minut_unitati => min_unit_aux,
		alarma_ora_zeci => al_ora_zeci,
		alarma_ora_unitati => al_ora_unit, 
		alarma_minut_zeci => al_min_zeci,
		alarma_minut_unitati => al_min_unit,
		alarma => alarma_aux);	 
		
	-- Afisare pe 7 segmente
	
	cod_ora_zeci_out : entity work.bcd_7_segment_decodificator port map(cifra => ora_zeci_aux, cod_7_segment => ora_zeci_out);
	cod_ora_unit_out : entity work.bcd_7_segment_decodificator port map(cifra => ora_unit_aux, cod_7_segment => ora_unit_out);
	cod_min_zeci_out : entity work.bcd_7_segment_decodificator port map(cifra => min_zeci_aux, cod_7_segment => min_zeci_out);	 
	cod_min_unit_out : entity work.bcd_7_segment_decodificator port map(cifra => min_unit_aux, cod_7_segment => min_unit_out);
		
	cod_zi_zeci_out : entity work.bcd_7_segment_decodificator port map(cifra => zi_zeci_aux, cod_7_segment => zi_zeci_out); 
	cod_zi_unit_out : entity work.bcd_7_segment_decodificator port map(cifra => zi_unit_aux, cod_7_segment => zi_unit_out);
	cod_luna_zeci_out : entity work.bcd_7_segment_decodificator port map(cifra => luna_zeci_aux, cod_7_segment => luna_zeci_out);   
	cod_luna_unit_out : entity work.bcd_7_segment_decodificator port map(cifra => luna_unit_aux, cod_7_segment => luna_unit_out);	
	cod_an_1_out : entity work.bcd_7_segment_decodificator port map(cifra => an_1_aux, cod_7_segment => an_1_out); 
	cod_an_2_out : entity work.bcd_7_segment_decodificator port map(cifra => an_2_aux, cod_7_segment => an_2_out); 	
		
	cod_alarma : entity work.bcd_7_segment_decodificator port map(cifra => alarma_aux, cod_7_segment => alarma);	 
		
	cod_temp_1_out : entity work.bcd_7_segment_decodificator port map(cifra => temp_1_aux, cod_7_segment => temp_1_out);
	cod_temp_2_out : entity work.bcd_7_segment_decodificator port map(cifra => temp_2_aux, cod_7_segment => temp_2_out);
	
	
end	architecture;