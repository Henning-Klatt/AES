library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity A3 is
	port (
		CLOCK_50 : in STD_LOGIC;
		HEX0 		: out STD_LOGIC_VECTOR (6 downto 0);
		HEX1 		: out STD_LOGIC_VECTOR (6 downto 0);
		HEX2 		: out STD_LOGIC_VECTOR (6 downto 0);
		HEX3 		: out STD_LOGIC_VECTOR (6 downto 0);
		HEX4 		: out STD_LOGIC_VECTOR (6 downto 0);
		HEX5 		: out STD_LOGIC_VECTOR (6 downto 0)
);
end A3;

architecture behavior of A3 is
	component htb -- Hex to binary decoder
		port (
			digit  : in STD_LOGIC_VECTOR (3 downto 0);
			output : out STD_LOGIC_VECTOR (6 downto 0)
		);
	end component;

	signal clk : STD_LOGIC; -- Clock
	signal count : STD_LOGIC_VECTOR (25 downto 0); -- Counter
	signal number : STD_LOGIC_VECTOR (18 downto 0); -- output number in hex
	
	signal dig0 : STD_LOGIC_VECTOR(3 downto 0);
	signal dig1 : STD_LOGIC_VECTOR(3 downto 0);
	signal dig2 : STD_LOGIC_VECTOR(3 downto 0);
	signal dig3 : STD_LOGIC_VECTOR(3 downto 0);
	signal dig4 : STD_LOGIC_VECTOR(3 downto 0);
	signal dig5 : STD_LOGIC_VECTOR(3 downto 0);
	
	signal count_overflow: STD_LOGIC;
	signal number_overflow: STD_LOGIC;
begin
	-- Connect the signals here
	-- ...
	Digit0 : htb port map (dig0, HEX0);
	Digit1 : htb port map (dig1, HEX1);
	Digit2 : htb port map (dig2, HEX2);
	Digit3 : htb port map (dig3, HEX3);
	Digit4 : htb port map (dig4, HEX4);
	Digit5 : htb port map (dig5, HEX5);

	process (clk)
	begin
		if rising_edge(CLOCK_50) then -- Syncronize with the clock
			if unsigned(count) = 50000 then -- Trigger the action to count
				count <= "00000000000000000000000000";

				if unsigned(number) >= 999999 then -- is the number greater then 999?
					number <= "00000000000000000000";
				else
					number <= std_logic_vector(unsigned(number) + 1);
				end if;
				
				dig0 <= std_logic_vector(unsigned(number) mod 10)(3 downto 0);
				dig1 <= std_logic_vector((unsigned(number) / 10) mod 10)(3 downto 0);
				dig2 <= std_logic_vector((unsigned(number) / 100) mod 10)(3 downto 0);
				dig3 <= std_logic_vector((unsigned(number) / 1000) mod 10)(3 downto 0);
				dig4 <= std_logic_vector((unsigned(number) / 10000) mod 10)(3 downto 0);
				dig5 <= std_logic_vector((unsigned(number) / 100000) mod 10)(3 downto 0);
			else
				count <= std_logic_vector(unsigned(count) + 1);
			end if;
		end if;
	end process;
end behavior;


library ieee;
use ieee.std_logic_1164.all;

entity htb is
	port (
		digit:  in  std_logic_vector(3 downto 0);
		output: out std_logic_vector(6 downto 0)
	);
end htb;

architecture segment_display of htb is
begin
    process(digit)
    begin
        case digit is
            when "0000" => output <= "1000000";
            when "0001" => output <= "1111001";
            when "0010" => output <= "0100100";
            when "0011" => output <= "0110000";
            when "0100" => output <= "0011001";
            when "0101" => output <= "0010010";
            when "0110" => output <= "0000010";
            when "0111" => output <= "1111000";
            when "1000" => output <= "0000000";
            when "1001" => output <= "0011000";
            when others => output <= "1111111";
        end case;
    end process;
end segment_display;


library ieee;
use ieee.std_logic_1164.all;

-- 1 bit full adder
entity full_adder is
    port (
        a, b, cIn: in std_logic;
        s, cOut: out std_logic
    );
end full_adder;

architecture behavior of full_adder is
begin
    s <= a xor b xor cIn;
    cOut <= (a and b) or (a and cIn) or (b and cIn);
end behavior;