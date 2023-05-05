LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;


ENTITY Task_2 IS
PORT (
LEDR : OUT STD_LOGIC_Vector(9 DOWNTO 0);
SW : IN STD_LOGIC_Vector(9 DOWNTO 0)
);
END Task_2 ;

-- The LEDs 0-9 should now be connected directly to the buttons 0-9

ARCHITECTURE behavior OF Task_2 IS
BEGIN

LEDR <= SW ; -- simply connect vectors using a "wire"

END behavior ;
