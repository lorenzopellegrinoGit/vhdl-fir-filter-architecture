LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY regn IS
	GENERIC (N : integer := 8);
	PORT (
		R : IN std_logic_vector(N-1 DOWNTO 0);
		Clock, Resetn,E : IN STD_LOGIC;
		Q : OUT std_logic_vector(N-1 DOWNTO 0)
	);
END regn;

ARCHITECTURE Behavior OF regn IS
BEGIN
	PROCESS (Clock)
	BEGIN
		if (rising_edge(Clock)) then
			if Resetn = '1' then
			Q <= (others => '0');
		elsif (E = '1' and rising_edge(Clock)) then 
			Q <= R;
		end if;
	end if;

	END PROCESS;
END Behavior;
