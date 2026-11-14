LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY mux3to1 IS
    PORT (
        Ext_S : IN SIGNED(9 DOWNTO 0);
        sel   : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        outB  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END mux3to1;

ARCHITECTURE Behavioural OF mux3to1 IS
BEGIN
    PROCESS(sel, Ext_S)
    BEGIN
        IF sel = "00" THEN 
            outB <= "01111111"; 
        ELSIF sel = "01" THEN
            outB <= "10000000"; 
        ELSE
            outB <= STD_LOGIC_VECTOR(Ext_S(7 DOWNTO 0)); 
        END IF;
    END PROCESS;
END Behavioural;
