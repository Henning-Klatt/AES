-- A gated D latch
LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY gatedDLatch IS
PORT ( Clk, D : IN STD_LOGIC;
	Q : OUT STD_LOGIC);
END gatedDLatch;
ARCHITECTURE Structural OF gatedDLatch IS
SIGNAL R_g, S_g, Qa, Qb : STD_LOGIC ;
ATTRIBUTE KEEP : BOOLEAN;
ATTRIBUTE KEEP OF R_g, S_g, Qa, Qb : SIGNAL IS TRUE;
BEGIN
	R_g <= Clk NAND (NOT D);
	S_g <= D NAND Clk;
	Qa <= S_g NAND Qb;
	Qb <= R_g NAND Qa;
	Q <= Qa;
END Structural;
