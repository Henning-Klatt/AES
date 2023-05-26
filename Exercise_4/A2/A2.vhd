LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

ENTITY A2 IS
	PORT (
		CLOCK_50 : IN STD_LOGIC;
		HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END A2;

ARCHITECTURE behavior OF A2 IS
	COMPONENT htb -- Hex to binary decoder
		PORT (
			input : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			output : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL clk		: STD_LOGIC; -- Clock (1 Hz?)
	SIGNAL count	: STD_LOGIC_VECTOR(24 DOWNTO 0);
	SIGNAL number0	: STD_LOGIC_VECTOR(3 DOWNTO 0);	-- counter number for hex0
	SIGNAL number1	: STD_LOGIC_VECTOR(3 DOWNTO 0); 	-- counter number for hex1
	SIGNAL number2	: STD_LOGIC_VECTOR(3 DOWNTO 0);  -- counter number for hex2
	SIGNAL output0	: STD_LOGIC_VECTOR(6 DOWNTO 0);	-- output for hex0
	SIGNAL output1	: STD_LOGIC_VECTOR(6 DOWNTO 0);	-- output for hex1
	SIGNAL output2	: STD_LOGIC_VECTOR(6 DOWNTO 0);	-- output for hex2
	
BEGIN

	clk <= CLOCK_50;
	HEX0 <= output0;
	HEX1 <= output1;
	HEX2 <= output2;

	Digit0 : htb PORT MAP (number0, output0);
	Digit1 : htb PORT MAP (number1, output1);
	Digit2 : htb PORT MAP (number2, output2);
	
	-- 10 Hz clock
	PROCESS (clk)
		BEGIN
			IF(rising_edge(clk)) THEN
				-- count <= std_logic_vector(unsigned(count) + 1);
				count <= count + 1;
				IF(count = std_logic_vector(to_unsigned(5000000, 25))) THEN -- 50MHz / 5000000 = 10 Hz
					count <= (others => '0'); -- reset counter
					IF(number0 = "1001") THEN 	-- check if number0 = 9
						number0 <= "0000";	-- set number0 to 0
						IF(number1 = "1001") THEN	-- check if number1 = 9
							number1 <= "0000"; 	-- set number1 to 0
							IF(number2 = "1001") THEN	-- check if number2 = 9
								number2 <= "0000";	-- set number2 to 0
							ELSE
								number2 <= number2 + 1; --increase number2
							END IF;
						ELSE
							number1 <= number1 + 1; -- increase number1
						END IF;
					ELSE
						number0 <= number0 + 1; -- increase number0
					END IF;
				END IF;
			END IF;
	
	END PROCESS;
END behavior;

