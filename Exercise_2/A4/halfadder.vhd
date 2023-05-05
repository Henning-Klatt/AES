LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY multiplexer IS
PORT (A, B : IN std_logic;
Sum, Cout : OUT std_logic);

END multiplexer;

ARCHITECTURE myadd OF multiplexer IS
BEGIN

Sum <= A xor B;
Cout <= A and B;
END myadd;

