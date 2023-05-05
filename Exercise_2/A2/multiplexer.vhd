LIBRARY ieee;	--Required for std.logic
USE ieee.std_logic_1164.all;	--Required for tri-state?
USE ieee.std_logic_unsigned.all; --Required for Math


ENTITY multiplexer IS
PORT (
LEDR : OUT STD_LOGIC_vector(9 DOWNTO 0);
SW : IN STD_LOGIC_Vector(9 DOWNTO 0)
);
END multiplexer ;

ARCHITECTURE behavior OF multiplexer IS

BEGIN

ledr(7 downto 0) <= sw(7 downto 0);


with sw(9 downto 8) select
	LEDR(9 downto 8) <=	SW(7 downto 6) when "00",
				SW(5 downto 4) when "01",
				SW(3 downto 2) when "10",
				SW(1 downto 0) when "11";

END behavior ;
