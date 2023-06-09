LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;
use ieee.numeric_std.all;

ENTITY A1 IS
	PORT (
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
	

	COMPONENT CRC
			PORT (
				generator : IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
				clock : IN STD_LOGIC;
				enable : IN STD_LOGIC :='0';
				message : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
				checksum_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				done_out : OUT STD_LOGIC
			);
		END COMPONENT;


BEGIN

	HWCRC : CRC PORT MAP (generator_in, CLOCK_50, NOT KEY(0), message_in, LEDR(6 DOWNTO 0), LEDR(9));


	generator_in <= "10101011"; -- 8 bit Polynom
	message_in(31 DOWNTO 22) <= SW(9 DOWNTO 0); -- höchsten (ersten) 10 bit vom schalter (evtl ersetzen duch message (INPUT))
	message_in(21 DOWNTO 0) <= "1011010011001001001001"; -- tiefsten (letzen) 22 Bit sind statisch => 32 bit message länge

END behavior ;
