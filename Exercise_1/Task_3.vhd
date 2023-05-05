LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;


ENTITY Task_3 IS
PORT (
LEDR : OUT STD_LOGIC_Vector(9 DOWNTO 0);
SW : IN STD_LOGIC_Vector(9 DOWNTO 0)
);
END Task_3 ;

ARCHITECTURE behavior OF Task_3 IS
SIGNAL sw0 : STD_LOGIC;
BEGIN


LEDR(4 DOWNTO 0) <= (others => sw(0)); -- keyword others to connect 5 LED vectors to 1 button vector
LEDR(9 DOWNTO 5) <= (others => sw(1)); 


-- other solution:
-- LEDR(4 DOWNTO 0) <= (sw(1),sw(1),sw(1),sw(1),sw(1));


END behavior ;
