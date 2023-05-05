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

LEDR(9) <= (SW(0) and SW(9)) OR (sw(1) and (not sw(9)));

END behavior ;
