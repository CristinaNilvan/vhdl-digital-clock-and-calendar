library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all; 

entity organigrama is
	port(clock, al_on, enable : in std_logic;
	ora_zeci : in std_logic_vector(3 downto 0);
	ora_unitati : in std_logic_vector(3 downto 0);
	minut_zeci : in std_logic_vector(3 downto 0);
	minut_unitati : in std_logic_vector(3 downto 0);
	alarma_ora_zeci : in std_logic_vector(3 downto 0);
	alarma_ora_unitati : in std_logic_vector(3 downto 0);
	alarma_minut_zeci : in std_logic_vector(3 downto 0);
	alarma_minut_unitati: in std_logic_vector(3 downto 0);
	alarma : out std_logic_vector(3 downto 0));
end entity;

architecture arh_organigrama of organigrama is 

signal final_alarma : std_logic := '0';		 	

type tip_stare is (A, B, C, D, E); 

signal stare, next_stare : tip_stare;

begin		 
	componenta_comparator_alarma : entity work.comparator port map(ora_zeci => ora_zeci,
		ora_unitati => ora_unitati,   
		minut_zeci => minut_zeci,
		minut_unitati => minut_unitati,
		alarma_ora_zeci => alarma_ora_zeci, 
		alarma_ora_unitati => alarma_ora_unitati, 
		alarma_minut_zeci => alarma_minut_zeci,
		alarma_minut_unitati => alarma_minut_unitati,
		egale => final_alarma); 	  
	
	clock_process : process(clock)
	begin
		if (clock'event and clock = '1') then
			stare <= next_stare;
		end if;
	end process;
	
	stari_process : process(al_on, enable, stare, final_alarma)
	begin
		if (stare = A) then
			if (enable = '1') then
				next_stare <= B;
			else	
				next_stare <= A;
			end if;
		end if;
		
		if (stare = B) then
			next_stare <= C;
		end if;	 
		
		if (stare = C) then
			if (al_on = '1') then
				next_stare <= D;
			else
				next_stare <= B;
			end if;	
		end if;
		
		if (stare = D) then
			if (final_alarma = '1') then
				next_stare <= E;
			else
				next_stare <= D;
			end if;
		end if;	 
		
		if (stare = E) then
			next_stare <= A;
		end if;
	end process;
	
	valori_process : process(stare, al_on, final_alarma)
	begin
		if (stare = B) then
			alarma <= "0000";
		end if;
		
		if (stare = E) then
			alarma <= "0001";
		end if;
	end process;
	
end architecture;