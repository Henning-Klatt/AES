LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;
use ieee.numeric_std.all;

ENTITY CRC IS
	PORT (
	generator : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	clock : IN STD_LOGIC;
	enable : IN STD_LOGIC ;
	message : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	checksum_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); -- 7 bit checksum output
	done_out : OUT STD_LOGIC := '0'
	);
END CRC;

ARCHITECTURE behavior OF CRC IS

	SIGNAL shiftregister : unsigned (31 DOWNTO 0);
	SIGNAL checksum_out_signal : STD_LOGIC_VECTOR (6 DOWNTO 0);
	SIGNAL fertig : STD_LOGIC :='0';

BEGIN

process (enable)

variable done : std_logic:='0';
variable shift_variable : std_logic_vector(31 DOWNTO 0);
variable message_variable : std_logic_vector (31 DOWNTO 0):= message;
variable generator_variable : std_logic_vector (7 DOWNTO 0):= generator;

BEGIN

	if (rising_edge(enable)) THEN	
	
		shift_variable(31 DOWNTO 0) := message_variable(31 DOWNTO 0);	--Fülle untere 32 Bit des Shiftregisters mit der Message.
		for i in 0 to 31 loop	
					
					if shift_variable(31) = '1' THEN		
						shift_variable(31 DOWNTO 0) := shift_variable(30 DOWNTO 0) & '0'; -- Leftshift, 1 bit
			
						-- k-1 = 7 obersten bits XOR mit dem Generator
						shift_variable (31 DOWNTO 25) := (generator_variable(6 DOWNTO 0) XOR shift_variable (31 DOWNTO 25));		
					else 
						shift_variable(31 DOWNTO 0) := shift_variable(30 DOWNTO 0) & '0'; -- Leftshift, 1 bit
					end if; 
					
		end loop;

	done := '1';			
	end if;

--writing variables back to signals
done_out <= done;
checksum_out <= STD_LOGIC_VECTOR(shift_variable(31 DOWNTO 25)); -- 7 bit checksum output

END process;

END behavior ;
