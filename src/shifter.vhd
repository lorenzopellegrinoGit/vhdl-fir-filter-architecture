LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY shifter IS
    PORT (
        Input: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        n: IN STD_LOGIC;
        verso: IN STD_LOGIC;
        Shifted: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END shifter;

ARCHITECTURE Behavioural OF shifter IS
BEGIN
    PROCESS (Input, n, verso)
        VARIABLE temp: STD_LOGIC_VECTOR(7 DOWNTO 0);
    BEGIN
        temp := Input;
         CASE n IS
        WHEN '1' =>
            IF verso = '0' THEN
                temp := temp(6 DOWNTO 0) & '0';
            ELSE
                temp := '0' & temp(7 DOWNTO 1);
            END IF;
        WHEN OTHERS =>
            FOR i IN 1 TO 2 LOOP
                IF verso = '0' THEN
                    temp := temp(6 DOWNTO 0) & '0';
                ELSE
                    temp := '0' & temp(7 DOWNTO 1);
                END IF;
            END LOOP;
    END CASE;

        Shifted <= temp;
    END PROCESS;
END Behavioural;
