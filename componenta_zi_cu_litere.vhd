library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all;

entity zi_cu_litere is
	port(clock, reset, load: in std_logic;
	numarul_zilei_din_sapt : in std_logic_vector(3 downto 0);
	zi_lit_unu : out std_logic_vector(6 downto 0);
	zi_lit_doi : out std_logic_vector(6 downto 0));
end	entity;

architecture arh_zi_cu_litere of zi_cu_litere is

signal numarul_zilei_din_sapt_aux_1 : std_logic_vector(3 downto 0) := "0000";	 
signal numarul_zilei_din_sapt_aux_2 : std_logic_vector(3 downto 0) := "0000";

begin
	numarator_ziua_din_sapt_1 : entity work.numarator_0_la_6 port map(clock => clock, 
		reset => reset,
		load => load,
		numar_in => numarul_zilei_din_sapt, 
		numar_out => numarul_zilei_din_sapt_aux_2);
		
	numarator_ziua_din_sapt_2 : entity work.numarator_0_la_6 port map(clock => clock, 
		reset => reset,
		load => load,
		numar_in => numarul_zilei_din_sapt, 
		numar_out => numarul_zilei_din_sapt_aux_1);
	
	ziua_cu_litere_1 : entity work.bcd_zi_unu_decodificator port map(cifra => numarul_zilei_din_sapt_aux_1,
		cod_7_segment => zi_lit_unu);
	
	ziua_cu_litere_2 : entity work.bcd_zi_doi_decodificator port map(cifra => numarul_zilei_din_sapt_aux_2,
		cod_7_segment => zi_lit_doi);
end architecture;
	
		 
	