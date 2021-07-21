library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;	

entity comparator_4_biti is
	port(numar_1, numar_2 : in std_logic_vector(3 downto 0);
	egale : out std_logic);
end entity;

architecture arh_comparator_4_biti of comparator_4_biti is

begin
	egale <= '1' when (numar_1 = numar_2) 
				else '0';
end architecture;	  


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity si_2 is
	port(x, y : in std_logic;
	q : out std_logic);
end entity;

architecture arh_si_2 of si_2 is
begin
	q <= x and y;
end;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity comparator_59 is
	port(zeci : in std_logic_vector(3 downto 0);
	unitati : in std_logic_vector(3 downto 0);
	e_60 : out std_logic);
end entity;	  

architecture arh_comparator_59 of comparator_59 is	 

component comparator_4_biti
	port(numar_1, numar_2 : in std_logic_vector(3 downto 0);
	egale : out std_logic);
end component;

component si_2 
	port(x, y : in std_logic;
	q : out std_logic);
end component;	

signal semnal_1, semnal_2 : std_logic;
signal noua : std_logic_vector(3 downto 0) := "1001";
signal cinci : std_logic_vector(3 downto 0) := "0101";

begin
	compara_zeci : comparator_4_biti port map(zeci, cinci, semnal_1);	 
	compara_unitati : comparator_4_biti port map(unitati, noua, semnal_2);
	verifica_conditii : si_2 port map(semnal_1, semnal_2, e_60);
end architecture;