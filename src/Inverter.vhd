LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY inverter IS
    PORT (
        A : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        Y : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END inverter;

ARCHITECTURE Behavioural OF inverter IS
BEGIN
    PROCESS(A)
        VARIABLE temp : UNSIGNED(7 DOWNTO 0);
    BEGIN
        -- two's complement operation
        temp := NOT unsigned(A) + 1;
        Y <= STD_LOGIC_VECTOR(temp);
    END PROCESS;
END Behavioural;
