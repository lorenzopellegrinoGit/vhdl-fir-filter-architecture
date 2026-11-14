LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY comparator is
    PORT ( Ext_S: in signed(9 DOWNTO 0);
           sel: OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END comparator;

ARCHITECTURE Behavioural of comparator is
	BEGIN
	PROCESS(Ext_S)
	BEGIN
    if Ext_S > to_signed(127, 10) then
        sel <= "00";
    elsif Ext_S < to_signed(-128, 10) then
        sel <= "01";
    else
        sel <= "10";
    end if;
END PROCESS;

END Behavioural;