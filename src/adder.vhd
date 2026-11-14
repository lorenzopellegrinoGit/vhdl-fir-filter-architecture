LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity adder is
    PORT ( a, b, c, d : in signed(7 downto 0);
           S: out signed(9 downto 0) 
	);
end adder;

ARCHITECTURE Behavioural of adder is
    signal Ext_a, Ext_b, Ext_c, Ext_d: signed(9 downto 0);
    signal Ext_S: signed(9 downto 0);
	BEGIN
		Ext_a <= "00" & a when a(7) = '0' else
				 "11" & a;
		Ext_b <= "00" & b when b(7) = '0' else
				 "11" & b;
		Ext_c <= "00" & c when c(7) = '0' else
				 "11" & c;
		Ext_d <= "00" & d when d(7) = '0' else
				 "11" & d;
		Ext_S <= Ext_a + Ext_b + Ext_c + Ext_d;
		
		S <= Ext_S;
end Behavioural;

