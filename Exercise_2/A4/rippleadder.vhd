LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY rippleadder IS

PORT (
LEDR : OUT STD_LOGIC_vector(9 DOWNTO 0);
SW : IN STD_LOGIC_Vector(9 DOWNTO 0)
);

END rippleadder;

ARCHITECTURE radd OF rippleadder IS

signal cout0,Cout1,Cout2,cout3:std_logic;

component full_adder
	port (A1,B1,Cin1:in std_logic;
		sum, co1:out std_logic);
end component;

BEGIN
	H1:full_adder port map(SW(4),SW(0),SW(9),LEDR(0),cout0);
	H2:full_adder port map(SW(5),SW(1),cout0,LEDR(1),cout1);
	H3:full_adder port map(SW(6),SW(2),cout1,LEDR(2),cout2);
	H4:full_adder port map(SW(7),SW(3),cout2,LEDR(3),cout3);
	LEDR(4)<=cout3;


END radd;
