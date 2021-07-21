library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all;  

entity bcd_zi_unu_decodificator is
port (cifra : in std_logic_vector(3 downto 0); 

	cod_7_segment : out std_logic_vector(6 downto 0));
end entity;	

architecture arh_bcd_zi_unu_decodificator of bcd_zi_unu_decodificator is 
			
begin
	process(cifra)
	begin
		case cifra is
			when "0000" => cod_7_segment <= "1110001"; 	-- L
			
			when "0001" => cod_7_segment <= "0101011"; 	-- M   
			
			when "0010" => cod_7_segment <= "0101011"; 	-- M   
			
			when "0011" => cod_7_segment <= "1000011"; 	-- J
			
			when "0100" => cod_7_segment <= "1100011"; 	-- v	
			
			when "0101" => cod_7_segment <= "0100100"; 	-- S 
			
			when "0110" => cod_7_segment <= "1000010"; 	-- d
			
			when others => cod_7_segment <= "1111111";  -- toate segmentele dezactivate
		end case; 
		
	end process;
end architecture;