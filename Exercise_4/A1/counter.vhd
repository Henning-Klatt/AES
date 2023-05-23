LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;

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

	SIGNAL clk : STD_LOGIC; -- Clock (1 Hz?)
	SIGNAL count : STD_LOGIC_VECTOR (24 DOWNTO 0); --tabsizeCounter
	SIGNAL signal_number : STD_LOGIC_VECTOR (3 DOWNTO 0); --tabsizeOutput number in hex
	SIGNAL output : STD_LOGIC_VECTOR (6 DOWNTO 0); --tabsizeOutput for the hex display
BEGIN
-- Connect the signals here
-- ...

	Digit0 : htb PORT MAP (signal_number, output);
	
	-- Make 1 Hz clock
	PROCESS ( clk )
	BEGIN
		IF RISING_EDGE(CLOCK_50) THEN -- Syncronize with the clock
		
		-- First of all an implementation for " counting " 1 second is needed
		-- Think about overflow
		END IF;
	END PROCESS;

	-- Increment the number at each clock cycle
	PROCESS (clk)
		VARIABLE number : INTEGER RANGE 0 TO 9;
	BEGIN
		IF RISING_EDGE(clk) THEN -- Syncronize with the clock
			IF number = 9 THEN -- Trigger the action to count
				number := 0; -- reset it
			ELSE
				number := number + 1; -- increase it
			END IF;
		END IF;
		signal_number <= conv_std_logic_vector(number, 4); -- 4 bit
	END PROCESS;
END behavior;


