library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity stabilire_numar_luna is
	port(luna_zeci, luna_unitati : in std_logic_vector(3 downto 0);
	numar_luna : out std_logic_vector(3 downto 0));
end entity;

architecture arh_stabilire_numar_luna of stabilire_numar_luna is 

begin 
	process(luna_zeci, luna_unitati)
	begin		
		case luna_zeci is
			when "0000" =>
				case luna_unitati is 
					when "0001" => numar_luna <= "0001";
					when "0010" => numar_luna <= "0010";
					when "0011" => numar_luna <= "0011";
					when "0100" => numar_luna <= "0100";
					when "0101" => numar_luna <= "0101";
					when "0110" => numar_luna <= "0110";
					when "0111" => numar_luna <= "0111";
					when "1000" => numar_luna <= "1000";
					when "1001" => numar_luna <= "1001";
					when others => numar_luna <= "0000";
				end case;
				
			when "0001" =>
				case luna_unitati is 
					when "0000" => numar_luna <= "1010";
					when "0001" => numar_luna <= "1011";
					when "0010" => numar_luna <= "1100"; 
					when others => numar_luna <= "0000";
				end case;
			when others => numar_luna <= "0000";
			end case;
	end process;

end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity stabilire_zi_unitati is
	port(numar_luna : in std_logic_vector(3 downto 0);
	bisect : in std_logic;
	zi_unitati : out std_logic_vector(3 downto 0));
end entity;	  

architecture arh_stabilire_zi_unitati of stabilire_zi_unitati is

begin
	process(numar_luna, bisect)
	begin
		case numar_luna is
			when "0001" => zi_unitati <= "0001" ;	 
			
			when "0010" => 
				if (bisect = '1') then
					zi_unitati <= "1001";
				else 
					zi_unitati <= "1000";
				end if;	  
				
			when "0011" => zi_unitati <= "0001"; 
			
			when "0100" => zi_unitati <= "0000";
			
			when "0101" => zi_unitati <= "0001";
			
			when "0110" => zi_unitati <= "0000"; 
			
			when "0111" => zi_unitati <= "0001";	
			
			when "1000" => zi_unitati <= "0001";
			
			when "1001" => zi_unitati <= "0000";
			
			when "1010" => zi_unitati <= "0001";
			
			when "1011" => zi_unitati <= "0000"; 
			
			when "1100"	=> zi_unitati <= "0001";
			
			when others => zi_unitati <= "0000";
		end case;							
	end process;
end architecture; 


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity stabilire_zi_zeci is
	port(numar_luna : in std_logic_vector(3 downto 0);
	zi_zeci : out std_logic_vector(3 downto 0));
end entity;	  

architecture arh_stabilire_zi_zeci of stabilire_zi_zeci is

begin
	process(numar_luna)
	begin
		case numar_luna is
			when "0001" => zi_zeci <= "0011" ;	 
			
			when "0010" => zi_zeci <= "0010"; 
				
			when "0011" => zi_zeci <= "0011";
			
			when "0100" => zi_zeci <= "0011";
			
			when "0101" => zi_zeci <= "0011";
			
			when "0110" => zi_zeci <= "0011";
			
			when "0111" => zi_zeci <= "0011";	
			
			when "1000" => zi_zeci <= "0011";
			
			when "1001" => zi_zeci <= "0011";
			
			when "1010" => zi_zeci <= "0011";
			
			when "1011" => zi_zeci <= "0011";
			
			when "1100"	=> zi_zeci <= "0011";
			
			when others => zi_zeci <= "0011";
		end case;							
	end process;
end architecture;  


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity numar_zile_din_luna is
	port(luna_zeci, luna_unitati : std_logic_vector(3 downto 0);
	bisect : in std_logic;
	zi_zeci, zi_unitati : out std_logic_vector(3 downto 0));
end entity;		

architecture arh_numar_zile_din_luna of numar_zile_din_luna is

component stabilire_numar_luna 
	port(luna_zeci, luna_unitati : in std_logic_vector(3 downto 0);
	numar_luna : out std_logic_vector(3 downto 0));
end component;

component stabilire_zi_unitati
	port(numar_luna : in std_logic_vector(3 downto 0);
	bisect : in std_logic;
	zi_unitati : out std_logic_vector(3 downto 0));
end component;	

component stabilire_zi_zeci
	port(numar_luna : in std_logic_vector(3 downto 0);
	zi_zeci : out std_logic_vector(3 downto 0));
end component;	

signal numar_luna : std_logic_vector(3 downto 0);

begin  
	stabilire_luna : stabilire_numar_luna port map(luna_zeci, luna_unitati, numar_luna);
	stabilire_zile_zeci : stabilire_zi_zeci port map(numar_luna, zi_zeci);	
	stabilire_zile_unitati : stabilire_zi_unitati port map(numar_luna, bisect, zi_unitati);
end architecture;