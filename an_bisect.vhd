library	ieee;
use ieee.std_logic_1164.all;

entity componenta is
	port(bcd : in std_logic_vector(2 downto 0);
	z : out std_logic);
end entity;

architecture arh_componenta of componenta is

signal ales : std_logic_vector(1 downto 0);
signal rezultat : std_logic_vector(1 downto 0);
signal cin : std_logic_vector(2 downto 0);

begin
	process(bcd)
	begin
		if (bcd(2) = '0') then ales <= "00";
		elsif (bcd(2) = '1') then ales <= "10";
		else ales <= "XX";
		end if;
	end process;
	
	cin(0) <= '0';	
	
	et_1 : for i in 0 to 1 generate
		rezultat(i) <= ales(i) xor bcd(i) xor cin(i);
		cin(i + 1) <= (ales(i) and bcd(i)) or (bcd(i) and cin(i)) or (cin(i) and ales(i));
	end generate et_1;
	
	z <= not(rezultat(0) or rezultat(1));
	
end architecture;


library	ieee;
use ieee.std_logic_1164.all;

entity an_bisect is
	port(an : in std_logic_vector(15 downto 0);
	bisect : out std_logic);
end entity;		

architecture arh_an_bisect of an_bisect is   

component componenta 
	port(bcd : in std_logic_vector(2 downto 0);
	z : out std_logic);
end component;

signal x : std_logic_vector(2 downto 0);
signal y : std_logic_vector(2 downto 0);
signal rezultat : std_logic_vector(1 downto 0);

begin
	x(1 downto 0) <= an(1 downto 0);
	x(2) <= an(4);	
	
	y(1 downto 0) <= an(9 downto 8);
	y(2) <= an(12);			   
	
	et_1 : componenta port map(x, rezultat(0));
	et_2 : componenta port map(y, rezultat(1));	
	
	process(rezultat)
	begin
		if (an(15 downto 0) = "0000000000000000") then
			bisect <= '0';
		elsif (an(7 downto 0) = "00000000") then
			bisect <= rezultat(1);
		else 
			bisect <= rezultat(0);
		end if;
	end process;
end architecture;