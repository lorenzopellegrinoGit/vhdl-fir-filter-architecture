library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity digital_filter_tb is
end digital_filter_tb;

architecture test of digital_filter_tb is

    component filter is
        port (
            clk      : in std_logic;
            rst    : in std_logic;
            start    : in std_logic;
            Din  : in std_logic_vector(7 downto 0);
            done     : out std_logic
        );
    end component;

    signal clk     : std_logic := '0';
    signal reset   : std_logic := '1';
    signal start   : std_logic := '0';
    signal data_in : std_logic_vector(7 downto 0) := (others => '0');
    signal done    : std_logic;

   begin
	process
	begin
	
		start <= '0';
		reset <= '1';
		clk <= '0';
		data_in <= "00000000";
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns; 
		reset <= '0';
		for i in 1 to 5 loop
				clk <= '0'; 
				wait for 10 ns; 
				clk <= '1'; 
				wait for 10 ns; 
		end loop;
		
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1';
		wait for 10 ns; 		
		clk <= '0'; 
		start <= '1';
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns;
		start <= '0';
	

		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns; 
		data_in <= "00000001";
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns;
		data_in <= "00000100";
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns; 
		data_in <= "00000001";
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns; 
		data_in <= "00000001";
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns; 
		data_in <= "00010000";
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns; 
		data_in <= "00011100";
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns; 
		data_in <= "00110100";
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns; 
		data_in <= "01000111";
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns; 
		data_in <= "01100100";
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns; 
		data_in <= "00111100";
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns; 
		data_in <= "11111100";
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns; 
		data_in <= "00000101";
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns; 
		data_in <= "00111100";
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns; 
		data_in <= "11010110";
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns; 
		data_in <= "01100100";
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns; 
		data_in <= "00010110";
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns; 
		data_in <= "00000000";
		clk <= '0'; 
		wait for 10 ns; 
		clk <= '1'; 
		wait for 10 ns; 	
		for i in 1 to 50 loop
				clk <= '0'; 
				wait for 10 ns; 
				clk <= '1'; 
				wait for 10 ns; 
		end loop; 
	wait;
	
	
	
		
	end process;

    -- UUT instantiation
    uut: filter
        port map (
            clk     => clk,
            rst   => reset,
            start   => start,
            Din => data_in,
            done    => done
        );

end test;

