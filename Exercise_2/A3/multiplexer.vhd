LIBRARY ieee;	--Required for std.logic
USE ieee.std_logic_1164.all;	--Required for tri-state?
USE ieee.std_logic_unsigned.all; --Required for Math


ENTITY multiplexer IS
PORT (
LEDR : OUT STD_LOGIC_vector(9 DOWNTO 0);
HEX0 : OUT STD_LOGIC_vector(0 TO 6);
SW : IN STD_LOGIC_Vector(9 DOWNTO 0)
);
END multiplexer ;

ARCHITECTURE behavior OF multiplexer IS

BEGIN

ledr(7 downto 0) <= sw(7 downto 0);


with sw(3 downto 0) select
	HEX0(0 to 6) <=		not("1111110") when "0000",
				not("0110000") when "0001",
				not("1101101") when "0010",
				not("1111001") when "0011",
				not("0110011") when "0100",
				not("1011011") when "0101",
				not("1011111") when "0110",
				not("1110000") when "0111",
				not("1111111") when "1000",
				not("1111011") when others;

END behavior ;
