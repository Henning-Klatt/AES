LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY part3 IS

	PORT (
	LEDR : OUT STD_LOGIC_vector(9 DOWNTO 0);
	SW : IN STD_LOGIC_Vector(9 DOWNTO 0)
	);

END part3;

ARCHITECTURE Structural OF part3 IS

signal Qm:std_logic;

component gatedDLatch
port (
D,clk:in std_logic;
Q:out std_logic);
end component;

BEGIN
-- master: D: SW(0); clk: NOT SW(1); Q: Qm
D1:gatedDLatch port map(SW(0), NOT(SW(1)), Qm);
-- slave: D: Qm; clk: SW(1); Q: LEDR(0)
D2:gatedDLatch port map(Qm, SW(1), LEDR(0));

end Structural;
