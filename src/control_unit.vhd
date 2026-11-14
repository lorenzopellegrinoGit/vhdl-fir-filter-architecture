LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY control_unit IS
	PORT (  start : in std_logic;
			rst : in std_logic;
			clk : in std_logic;
			full : in std_logic;
			enable_count : out std_logic;
			CS_A, CS_B, WR, RD, rst_cnt_signal, enable_register : out std_logic; 
			done_signal : out std_logic
			);
END control_unit;

architecture behavior of control_unit is

TYPE State_type IS (done, writeA, rst_counter, readA, writeB);
signal CS: State_type := done;
signal continue: std_logic := '0';

begin	
	control_signals: process(CS)
	begin
		CS_A <= '0'; 
		CS_B <= '0'; 
		WR <= '0'; 
		RD <= '0'; 
		done_signal <= '0'; 
		enable_count <= '0'; 
		rst_cnt_signal <= '0'; 
		enable_register <= '0';

		case CS is 
			when writeA => 
				enable_count <= '1';
				CS_A <= '1';
				WR <= '1';
			when rst_counter =>
				rst_cnt_signal <= '1';
			when readA =>
				enable_register <= '1';
				CS_A <= '1';
				RD <= '1';
			when writeB =>
				enable_count <= '1';
				CS_B <= '1';
				WR <= '1';
			when done => 
				done_signal <= '1';
				rst_cnt_signal <= '1';
			when others => 
				CS_A <= '0';
				CS_B <= '0'; 
				WR <= '0';
			   RD <= '0'; 
			   done_signal <= '0';
				enable_count <= '0';
				rst_cnt_signal <= '0'; 
				enable_register <= '0';
		end case;
		
	end process;
	
	states: process(clk)
	begin
  	  if rising_edge(clk) then
    	    if start = '1' then 
            continue <= '1';
        end if;

        if rst = '1' then 
            CS <= done; 
        end if;

        case CS is 
           
				when writeA => 
				if full = '1' then 
					CS <= rst_counter; 
				else 
					CS <= writeA; 
				end if;
            when rst_counter =>
                if full = '0' then
                    CS <= readA;
                else 
                    CS <= rst_counter;
                end if;					 
            when readA => 
                CS <= writeB;					 
            when writeB => 
                if full = '1' then 
                    CS <= done;
                    continue <= '0';
                else 
                    CS <= readA; 
                end if;					 
            when done =>
                if continue = '1' then 
                    CS <= writeA;
                else 
                    CS <= done; 
                end if;
        end case;
    end if;
end process;


end behavior;
