LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity memory is
    port (	clk : in std_logic;
			wr, cs, rd : in std_logic;
			address : in std_logic_vector(9 downto 0); 
			Din : in std_logic_vector(7 downto 0); 
			Dout : out std_logic_vector(7 downto 0)                      
			);
end memory;

architecture behavioural of memory is
    type memory_array is array (0 to 1023) of std_logic_vector(7 downto 0);
    signal mem : memory_array := (others => (others => '0'));
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if (wr = '1' and cs = '1') then
                mem(to_integer(unsigned(address))) <= Din;
            end if;
		end if;
	end process;
	
	process(address, rd, cs)
	begin
		if (rd = '1' and cs = '1') then
			Dout <= mem(to_integer(unsigned(address)));
		else
            		Dout <= (others => 'X');
		end if;
    end process;
end behavioural;