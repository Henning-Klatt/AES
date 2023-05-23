LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY htb IS
	PORT (
		INPUT : IN std_logic_vector(3 DOWNTO 0);
		OUTPUT : OUT std_logic_vector(0 TO 6)
	);
END htb;

ARCHITECTURE behavior OF htb IS
BEGIN
	-- Behavior of the hex to binary converter
	-- You can copy it from your 7 - segment display project
	with INPUT select
		OUTPUT <=	not("1111110") when "0000",
						not("0110000") when "0001",
						not("1101101") when "0010",
						not("1111001") when "0011",
						not("0110011") when "0100",
						not("1011011") when "0101",
						not("1011111") when "0110",
						not("1110000") when "0111",
						not("1111111") when "1000",
						not("1111011") when others;
END behavior;