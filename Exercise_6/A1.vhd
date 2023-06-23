LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;
use ieee.numeric_std.all;

ENTITY A1 IS
	PORT (
	HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
	HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6);
	HEX2 : OUT STD_LOGIC_VECTOR(0 TO 6);
	HEX3 : OUT STD_LOGIC_VECTOR(0 TO 6);
	HEX4 : OUT STD_LOGIC_VECTOR(0 TO 6);
	HEX5 : OUT STD_LOGIC_VECTOR(0 TO 6);
	CLOCK_50 : IN STD_LOGIC;
	LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
	SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0)		--NOTE: Keys are inverted
	);
END A1;

 -- 32 bit inkl CRC Summe
 -- egal wie lang message/ polynom sind
 -- techn. Implementierung: message allein 32 bit
 -- polynom 8 bit
 -- CRC Checksumme hat 7 bit -> LEDs als Ausgabe

ARCHITECTURE behavior OF A1 IS

	SIGNAL generator_in : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL message_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL CRC_display : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL CRC_out : STD_LOGIC_VECTOR (6 DOWNTO 0);
	
	--Für Aufgabe 6
	SIGNAL signal_write : STD_LOGIC;
	SIGNAL signal_reset : STD_LOGIC;
	SIGNAL signal_adr	  : STD_LOGIC;
	
	SIGNAL signal_selected_adr	  : STD_LOGIC;
	
	SIGNAL readdata : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	--SIGNAL writedata : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	SIGNAL register_0 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	SIGNAL register_1 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	
	--SIGNAL message : STD_LOGIC_VECTOR(31 DOWNTO 0); --temporary signal for writedata
	SIGNAL key3test : STD_LOGIC; --just for testing key bounce
	SIGNAL registerselected : STD_LOGIC := '0'; --just for testing
	

	COMPONENT CRC
			PORT (
				--generator : IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
				clock : IN STD_LOGIC;
				signal_write : IN STD_LOGIC;
				signal_reset : IN STD_LOGIC;
				signal_adr	 : IN STD_LOGIC;
				--enable : IN STD_LOGIC :='0';
				readdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				--writedata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				writedata_register_0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				writedata_register_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				--message : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
				checksum_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
				--done_out : OUT STD_LOGIC
			);
		END COMPONENT;
		
	COMPONENT htb -- Hex to binary decoder
		PORT (
			input : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			output : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
		);
	END COMPONENT;


BEGIN
	
	--CRC component
	HWCRC : CRC PORT MAP (CLOCK_50, signal_write, signal_reset, signal_adr, readdata, register_0, register_1, CRC_out);

	--read the input keys
	signal_reset 	<= not key(0);
	signal_write	<= not key(1);
	process(key(2))
		begin 
			if falling_edge(key(2)) THEN
				signal_adr <= not signal_adr;
			end if;			
	end process;
	
	
	
	--assembling the message to write into register_0. Note that we can only change 8 bit at a time.
		process(key(1), key(0))
		begin 
			--if (falling_edge(key(0))) THEN	--writing to register 0
			if (key(0) = '0') THEN	--writing to register 0
					register_0 <= "00000000000000000000000000000000";
			elsif (falling_edge(key(1)) and signal_adr = '0') THEN	--writing to register 0
				case sw (9 downto 8) IS
					when "00" => register_0(7 downto 0)			<= sw(7 downto 0) ;
					when "01" => register_0(15 downto 8)		<= sw(7 downto 0) ;
					when "10" => register_0(23 downto 16)		<= sw(7 downto 0) ;
					when "11" => register_0(31 downto 24)		<= sw(7 downto 0) ;
				end case;		
			end if;			
	end process;
	
		--assembling the message to write into register_1. Note that we can only change 8 bit at a time.
		process(key(1), key(0))
		begin 
			if (key(0) = '0') THEN	--writing to register 0
					register_1 <= "00000000000000000000000000000000";
			elsif (falling_edge(key(1)) and signal_adr = '1') THEN	--writing to register 0
				case sw (9 downto 8) IS
					when "00" => register_1(7 downto 0)			<= sw(7 downto 0) ;
					when "01" => register_1(15 downto 8)		<= sw(7 downto 0) ;
					when "10" => register_1(23 downto 16)		<= sw(7 downto 0) ;
					when "11" => register_1(31 downto 24)		<= sw(7 downto 0) ;
				end case;		
			end if;			
	end process;
	
	

	--show the content of readdata
	with sw(9 downto 8) select
		LEDR(7 downto 0) <=  readdata(7 downto 0) when "00",
									readdata(15 downto 8) when "01",
									readdata(23 downto 16) when "10",
									readdata(31 downto 24) when "11";
	
	--test to see if the switches are working	
	LEDR(9 downto 8) <= sw(9 downto 8);								
	
	--To show the CRC code as Hexadecimal on 7-segment display
	CRC_display(6 downto 0) <= CRC_out(6 downto 0); --Das fehlende Bit wird (hoffentlich) mit 0 gefüllt.
	first_eight:  htb PORT MAP ("000" & signal_adr, HEX0);
	second_eight: htb PORT MAP ("0000", HEX1);
	third_eight:  htb PORT MAP ("0000", HEX2);
	fourth_eight: htb PORT MAP ("0000", HEX3);
	fifth_eight:  htb PORT MAP (CRC_display(3 downto 0), HEX4);
	sixth_eight:  htb PORT MAP (CRC_display(7 downto 4), HEX5);
	

END behavior ;