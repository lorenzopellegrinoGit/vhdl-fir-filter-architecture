library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath is
	PORT (clk,rst, count_enable,rst_counter, Ereg: in std_logic;
	Din: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	done: OUT STD_LOGIC;
	Dout: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	count: OUT STD_LOGIC_VECTOR(9 downto 0)
          );
end datapath;

ARCHITECTURE structural of datapath IS

	component counter_10bit is
    	port (clk: in std_logic;
			reset: in std_logic;
			enable: in std_logic;
			count: out std_logic_vector(9 downto 0);
			flag_finish: out std_logic
			);
	end component;
	
	component adder is
	port ( a, b, c, d : in signed(7 downto 0);
           S: out signed(9 downto 0) 
	);
	end component;

	component regn
    	GENERIC (N : integer := 8);
    	port (
     	   R: IN std_logic_vector(N-1 DOWNTO 0);
     	   Clock, Resetn,E : IN STD_LOGIC;
     	   Q: OUT std_logic_vector(N-1 DOWNTO 0)
   	 );
	end component; 

	component mux3to1 is
	port ( Ext_S: IN SIGNED(9 DOWNTO 0);
           sel: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	   outB: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
	end component;

	component shifter is 
	PORT (
        	 Input: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
       		 n: IN STD_LOGIC;
       		 verso: IN STD_LOGIC; -- 0 towards sx 1 towards dx
       		 Shifted: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    	);
	end component;
	
	component inverter is
	 PORT (
      		 A: IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
       		 Y: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
   	 );
	end component;

	component comparator is
	port(
	Ext_S: in signed(9 DOWNTO 0);
           sel: OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
	end component;

	signal data_in,DO0, DO1,DO2,DO3, shifted0, shifted1, temp0,temp1,temp2,temp3, inB: STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal Stot: SIGNED(9 DOWNTO 0);
	signal S0,S1,S2,S3: signed(7 downto 0);
	signal sel: STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal flag_finish: std_logic;
	constant constshift1: std_logic := '1';
	constant constshift2: std_logic := '0';
	constant versodx: std_logic := '1';
	constant versosx: std_logic := '0';

	begin
	data_in<=Din;
	r0: regn
	GENERIC MAP (
            N => 8
        )
        port map(
            R=> data_in,
            Clock=> clk,
            Resetn=> rst,
	    E => Ereg,
            Q=> DO0
        );

	r1: regn
	GENERIC MAP (
            N => 8
        )
        port map(
            R=> DO0,
            Clock=> clk,
            Resetn=> rst,
	    E => Ereg,
            Q=> DO1
        );

	r2: regn
	GENERIC MAP (
            N => 8
        )
        port map(
            R=> DO1,
            Clock=> clk,
            Resetn=> rst,
	    E => Ereg,
            Q=> DO2
        );

	r3: regn
	GENERIC MAP (
  	  N => 8
	)
	port map(
  	  R => DO2,
  	  Clock => clk,
   	 Resetn => rst,
	 E => Ereg,
   	 Q => DO3
	);


	count0: counter_10bit port map(clk,rst_counter,count_enable,count,flag_finish);
	shift0: shifter port map(DO0,constshift1,versodx, shifted0);
	inverter0: inverter port map(shifted0, temp0);
	shift1: shifter port map(DO1,constshift1,versosx, shifted1);
	inverter1: inverter port map(shifted1, temp1);
	shift2: shifter port map(DO2,constshift2,versosx, temp2);
	shift3: shifter port map(DO3,constshift2,versodx, temp3);
	S0<=signed(temp0);
	S1<=signed(temp1);
	S2<=signed(temp2);
	S3<=signed(temp3);
	adder_behav: adder port map(S0,S1,S2,S3,Stot);
	comp: comparator port map(Stot,sel);
	mux0: mux3to1 port map(Stot, sel, inB);
	done <= flag_finish;
	Dout <= inB;
end structural;
