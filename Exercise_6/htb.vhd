LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY htb IS
-- Define ports
	PORT (
	input : IN STD_LOGIC_VECTOR (3 DOWNTO 0) ;
	output : OUT STD_LOGIC_VECTOR (0 TO 6)
	);
END htb ;
ARCHITECTURE behavior OF htb IS
BEGIN
-- Behavior of the hex to binary converter
-- You can copy it from your 7 - segment display project
with input(3 downto 0) select
	output(0 to 6) <=		not("1111110") when "0000",
								not("0110000") when "0001",
								not("1101101") when "0010",
								not("1111001") when "0011",
								not("0110011") when "0100",
								not("1011011") when "0101",
								not("1011111") when "0110",
								not("1110000") when "0111",
								not("1111111") when "1000",
								not("1111011") when "1001",
								not("1110111") when "1010",
								not("0011111") when "1011",
								not("1001110") when "1100",
								not("0111101") when "1101",
								not("1001111") when "1110",
								not("1000111") when others;

END behavior ;
