LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity filter is 
	PORT ( clk: in std_logic;
			 rst: in std_logic;
			 start: in std_logic;
			 done: out std_logic;
			 Din: in std_logic_vector (7 downto 0)
	);
end filter;

architecture structural of filter is

	component memory is
		PORT     (clk : in std_logic;
					wr, cs, rd : in std_logic;
					address : in std_logic_vector(9 downto 0); 
					Din : in std_logic_vector(7 downto 0); 
					Dout : out std_logic_vector(7 downto 0)                      
					);
	end component;
	
	component datapath is
		PORT 	(clk,rst, count_enable,rst_counter, Ereg: in std_logic;
				 Din: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
				 done: OUT STD_LOGIC;
				 Dout: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
				 count: OUT STD_LOGIC_VECTOR(9 downto 0)
				);
	end component;
	
	component control_unit is
		PORT   (start : in std_logic;
				 rst : in std_logic;
				 clk : in std_logic;
				 full : in std_logic;
				 enable_count : out std_logic;
				 CS_A, CS_B, WR, RD, rst_cnt_signal, enable_register : out std_logic; 
				 done_signal : out std_logic
				 );
	end component;
	
	
	signal CS_A, CS_B, wr, cs, rd, count_enable, count_finish, rst_counter, enable_register : std_logic;
	signal count : std_logic_vector(9 DOWNTO 0);
	signal x, y, Dout_B  : std_logic_vector(7 DOWNTO 0);
	
	begin

	mem_A : memory port map (	clk => clk,
										wr => wr,
										cs => CS_A,
										rd => rd,
										address => count,
										Din => Din,
										Dout => x
									);
									
	mem_B : memory port map (	clk => clk,
										wr => wr,
										cs => CS_B,
										rd => rd,
										address => count,
										Din => y,
										Dout => Dout_B
									);
								
	DP : datapath port map (count_enable => count_enable,
											rst_counter => rst_counter,
											rst => rst_counter,
											Ereg => enable_register,
											clk => clk,
											count => count,
											done => count_finish,
											Din => x,
											Dout => y
										  );
	
	CU : control_unit port map (	start => start,
														rst => rst,
														clk => clk,
														full => count_finish,
														enable_count => count_enable,
														CS_A => CS_A,
														CS_B => CS_B,
														WR => wr,
														RD => rd,
														enable_register => enable_register,
														rst_cnt_signal => rst_counter,
														done_signal => done
													 );

end structural;							

	
	

