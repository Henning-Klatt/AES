LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY full_adder IS
PORT (A1, B1, Cin1 : IN std_logic;
	Sum, Co1 : OUT std_logic);
END full_adder;

ARCHITECTURE myfulladd OF full_adder IS
signal Sum1,Cout1,Cout2:std_logic;
Component multiplexer
port (A,B:in std_logic;
	Sum, Cout:out std_logic);
end component;

BEGIN
H1:multiplexer port map(A1,Cin1,Sum1,Cout1);
H2:multiplexer port map(Sum1,B1,Sum,Cout2);
Co1 <= Cout1 or Cout2;
END myfulladd;

