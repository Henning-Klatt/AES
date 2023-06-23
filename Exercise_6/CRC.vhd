LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;
use ieee.numeric_std.all;

ENTITY CRC IS
	PORT (
	clock : IN STD_LOGIC;
	signal_write : IN STD_LOGIC ;
	signal_reset : IN STD_LOGIC ;
	signal_adr : IN STD_LOGIC ;
	readdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	--writedata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	writedata_register_0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	writedata_register_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	checksum_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) -- 7 bit checksum output
	);
END CRC;

ARCHITECTURE behavior OF CRC IS

	SIGNAL register_0 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	SIGNAL register_1 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";

BEGIN

	--Sending readdata
	with signal_adr select
		readdata(31 downto 0) <= register_0(31 downto 0) when '0',
										 register_1(31 downto 0) when others;
									 
process (register_1, clock,signal_reset, signal_write, signal_adr, register_0)

variable counter : integer := 0;
begin
		--if (signal_reset = '1') THEN counter := 0; end if;
		if (signal_reset = '1') THEN			
			register_0 <= "00000000000000000000000000000000";	--reset fall
			register_1 <= "00000000000000000000000000000000";
		
		elsif (signal_write = '1')THEN --write fall
			if (signal_adr = '0') THEN
				register_0 <= writedata_register_0; 		
				else
				register_1 <= writedata_register_1;
			end if;
			
		elsif (clock'event and clock ='1' and register_1(31) = '1') THEN	--CRC fall
			counter := counter +1;
			--enable <= '1';
			if register_0(31) = '1' THEN
				--register_0(31 DOWNTO 0) := register_0(30 DOWNTO 0) & '0'; -- Leftshift, 1 bit
		
				-- k-1 = 7 obersten bits XOR mit dem Generator und leftshift
				--shiftregister (31 DOWNTO 24) <= (register_1(6 DOWNTO 0) XOR register_0 (31 DOWNTO 25)) & '0';
				register_0 (31 DOWNTO 0) <= ((register_1(6 DOWNTO 0) XOR register_0 (30 DOWNTO 24)) & register_0(23 downto 0)) & '0';
				
			else 
				register_0(31 downto 0) <= register_0(30 downto 0) & '0'; -- Leftshift, 1 bit
			end if;

			if (counter = 32) THEN			--or (register_0(31 downto 25) < register_1(6 downto 0))
				register_1(31) <= '0';	
				counter := 0;
			end if;
			if (signal_reset = '1') THEN counter := 0; end if;
		

	end if;
end process;

	--writing cheksum_out (optional)
	checksum_out <= register_0(31 downto 25);


END behavior ;