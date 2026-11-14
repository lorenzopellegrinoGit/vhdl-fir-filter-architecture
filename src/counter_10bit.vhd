library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_10bit is
    port (	clk: in std_logic;
			reset: in std_logic;
			enable: in std_logic;
			count: out std_logic_vector(9 downto 0);
			flag_finish: out std_logic
	);
end counter_10bit;

architecture behavioural of counter_10bit is
    signal temp : unsigned(9 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            temp <= (others => '0');
            flag_finish <= '0';
        elsif rising_edge(clk) then
            if enable = '1' then
                if temp = 1023 then
                    flag_finish <= '1';
                else
                    flag_finish <= '0';
                    temp <= temp + 1;
                end if;
            end if;
        end if;
    end process;

    count <= std_logic_vector(temp);

end behavioural;