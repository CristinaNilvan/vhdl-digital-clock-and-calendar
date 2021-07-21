library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all;  

entity bcd_zi_doi_decodificator is
port (cifra : in std_logic_vector(3 downto 0); 

	cod_7_segment : out std_logic_vector(6 downto 0));
end entity;	

architecture arh_bcd_zi_doi_decodificator of bcd_zi_doi_decodificator is 
			
begin
	process(cifra)
	begin
		case cifra is
			when "0000" => cod_7_segment <= "1000001"; 	-- U
	
			when "0001" => cod_7_segment <= "0001000"; 	-- A   
			
			when "0010" => cod_7_segment <= "1001111"; 	-- I   
			
			when "0011" => cod_7_segment <= "1100010"; 	-- o
			
			when "0100" => cod_7_segment <= "1001111"; 	-- I	
			
			when "0101" => cod_7_segment <= "0001000"; 	-- A 
			
			when "0110" => cod_7_segment <= "1000001"; 	-- U
			
			when others => cod_7_segment <= "1111111";  -- toate segmentele dezactivate
		end case; 
		
	end process;
end architecture;