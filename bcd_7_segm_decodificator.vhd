library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all;  

entity bcd_7_segment_decodificator is
port (cifra : in std_logic_vector(3 downto 0); 

	cod_7_segment : out std_logic_vector(6 downto 0));
end entity;	

architecture arh_bcd_7_segment_decodificator of bcd_7_segment_decodificator is 

type segment_type is array (0 to 9) of std_logic_vector(6 downto 0);

signal cod_out : segment_type := ("0000001", "1001111", "0010010", "0000110", 
"1001100", "0100100", "0100000", "0001111", "0000000", "0000100");

signal numar_integer : integer;
			
begin
	process(cifra)
	begin
		case cifra is
			when "0000" => 
			cod_7_segment <= cod_out(0); 	-- 0 
			numar_integer <= conv_integer(cifra);
			
			when "0001" =>
			cod_7_segment <= cod_out(1); 	-- 1   
			numar_integer <= conv_integer(cifra);
			
			when "0010" => 
			cod_7_segment <= cod_out(2); 	-- 2   
			numar_integer <= conv_integer(cifra);
			
			when "0011" => 
			cod_7_segment <= cod_out(3); 	-- 3 
			numar_integer <= conv_integer(cifra);
			
			when "0100" => 
			cod_7_segment <= cod_out(4); 	-- 4	
			numar_integer <= conv_integer(cifra);
			
			when "0101" => 
			cod_7_segment <= cod_out(5); 	-- 5 
			numar_integer <= conv_integer(cifra);
			
			when "0110" => 
			cod_7_segment <= cod_out(6); 	-- 6
			numar_integer <= conv_integer(cifra);
			
			when "0111" => 
			cod_7_segment <= cod_out(7); 	-- 7 
			numar_integer <= conv_integer(cifra);
			
			when "1000" =>
			cod_7_segment <= cod_out(8); 	-- 8
			numar_integer <= conv_integer(cifra);
			
			when "1001" => 
			cod_7_segment <= cod_out(9); 	-- 9   
			numar_integer <= conv_integer(cifra);
			
			when others => cod_7_segment <= "1111111";  	-- toate segmentele dezactivate
		end case; 
		
	end process;
end architecture;