library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity numarator_0_la_1 is
	port(clock, reset, load : in std_logic; 
	numar_in : in std_logic_vector(3 downto 0);
	numar_out : out std_logic_vector(3 downto 0);
	carry : out std_logic);
end entity;

architecture arh_numarator_0_la_1 of numarator_0_la_1 is

signal numar : std_logic_vector(3 downto 0) := "0000";

begin
	process (clock, reset)
	begin
			if (reset = '1') then
				numar <= "0000";
			
			elsif (load = '1') then
				numar <= numar_in;
			
			elsif (clock = '1' and clock'event) then
				if (numar = "0001") then
					numar <= "0000"; 
				elsif (numar = "0000") then
					numar <= "0001";
				end if;
			end if;	
			
			if (numar = "0001") then
				carry <= '1';
			else 
				carry <= '0';
			end if;
		
		numar_out <= numar;	
		
	end process;  
end architecture;