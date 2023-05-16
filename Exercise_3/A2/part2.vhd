-- A gated D latch
LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part2 IS
PORT ( SW : IN STD_LOGIC_Vector(9 DOWNTO 0);
	LEDR : OUT STD_LOGIC_vector(9 DOWNTO 0));
END part2;
ARCHITECTURE Structural OF part2 IS
SIGNAL R_g, S_g, Qa, Qb, clk, D, Q : STD_LOGIC ;
ATTRIBUTE KEEP : BOOLEAN;
ATTRIBUTE KEEP OF R_g, S_g, Qa, Qb : SIGNAL IS TRUE;
BEGIN
	-- get Input from Switches
	D <= SW(0);
	clk <= SW(1);

	R_g <= Clk NAND (NOT D);
	S_g <= D NAND Clk;
	Qa <= S_g NAND Qb;
	Qb <= R_g NAND Qa;
	Q <= Qa;
	
	-- write Output to LED
	LEDR(0) <= Q;
	
END Structural;
