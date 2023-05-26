LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY counter IS
	PORT (
		CLOCK_50 : IN STD_LOGIC;
		HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END counter;

ARCHITECTURE behavior OF counter IS
	COMPONENT htb -- Hex to binary decoder
		PORT (
			input : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			output : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL clk : STD_LOGIC; -- Clock
	SIGNAL count : STD_LOGIC_VECTOR (24 DOWNTO 0); --tabsizeCounter
	SIGNAL number : STD_LOGIC_VECTOR (3 DOWNTO 0); --tabsizeOutput number in hex
	SIGNAL output : STD_LOGIC_VECTOR (6 DOWNTO 0); --tabsizeOutput for the hex display
BEGIN

	clk <= CLOCK_50;
	hex0 <= output;

	Digit0 : htb PORT MAP (number, output);
	
	-- 1 Hz clock
	PROCESS (clk)
		-- VARIABLE count : INTEGER RANGE 0 TO 25000000;
	BEGIN
		IF RISING_EDGE(CLOCK_50) THEN -- Syncronize with the clock
			count <= count + 1;
		END IF;
	END PROCESS;

	-- Increment the number at each clock cycle
	PROCESS (clk)
	BEGIN
		IF RISING_EDGE(clk) THEN -- Syncronize with the clock
			IF count = 25000000 THEN -- 25000000 / 50 MHz = 0,5s
				IF number = 9 THEN
					number <= "0000"; -- reset it to 0
				ELSE
					number <= number + 1; -- increase it
				END IF;
			END IF;
		END IF;
		--signal_number <= conv_std_logic_vector(number, 4); -- 4 bit
	END PROCESS;
END behavior;


