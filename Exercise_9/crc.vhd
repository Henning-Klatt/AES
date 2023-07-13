LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;
use ieee.numeric_std.all;

ENTITY crc IS
	PORT (
	clock : IN STD_LOGIC;
	wrt : IN STD_LOGIC ;
	signal_reset : IN STD_LOGIC ;
	signal_adr : IN STD_LOGIC ;
	readdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	writedata : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END crc;

ARCHITECTURE behavior OF crc IS

	SIGNAL register_0 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	SIGNAL register_1 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";

BEGIN


									 
process (register_1, clock,signal_reset, wrt, signal_adr, register_0)

variable counter : integer := 0;
begin
		if (signal_reset = '0') THEN			
			register_0 <= "00000000000000000000000000000000";	--reset fall
			register_1 <= "00000000000000000000000000000000";
			
		elsif( clock'EVENT AND clock = '1') Then 
				
				if (wrt = '1' and register_1(31) = '0')THEN --write fall
				if (signal_adr = '0') THEN
					register_0 <= writedata; 		
					else
					register_1 <= writedata;
				end if;
				
			elsif (register_1(31) = '1' and wrt = '0') THEN	--CRC fall
				counter := counter +1;
				if register_0(31) = '1' THEN
					register_0 (31 DOWNTO 0) <= ((register_1(6 DOWNTO 0) XOR register_0 (30 DOWNTO 24)) & register_0(23 downto 0)) & '0';
				else 
					register_0(31 downto 0) <= register_0(30 downto 0) & '0'; -- Leftshift, 1 bit
				end if;

				if (counter = 32) THEN
					register_1(31) <= '0';	
					counter := 0;
				end if;
				if (signal_reset = '0') THEN counter := 0; end if;
		
			end if;
	end if;
	
	--Sending readdata
	if (signal_adr = '0') THEN
				readdata <= register_0; 		
				else
				readdata <= register_1;
	end if;
	
	
end process;
END behavior ;
