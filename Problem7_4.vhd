library IEEE;
use IEEE.std_logic_1164.all;
--------------------------2:1 Mux---------------------------
entity mux2_1 is 
    port(D1, D2 : in std_logic_vector(7 downto 0);
         sel : in std_logic;
         mux_out: out std_logic_vector(7 downto 0));
end mux2_1;
architecture my_mux of mux2_1 is
begin
    with sel select
    mux_out <= D2 when '0',
               D1 when '1',
               "00000000" when others;
end my_mux;

library IEEE;
use IEEE.std_logic_1164.all;

------------------------Register---------------------------
entity reg8 is 
port(a: in std_logic_vector(7 downto 0);
     clock, LD: in std_logic;
     reg_out: out std_logic_vector(7 downto 0));
end reg8;

architecture my_reg of reg8 is 
begin
    process(clock)
    begin
        if(falling_edge(clock)) then
            reg_out <= a;
        end if;
    end process;
end my_reg;

library IEEE;
use IEEE.std_logic_1164.all;
----------------------Top Level-------------------
entity Problem7_4 is 
port(X, Y: std_logic_vector(7 downto 0);
     LDB, LDA, S1, S0, RD, CLK: in std_logic;
     RA: out std_logic_vector(7 downto 0);
     RB: inout std_logic_vector(7 downto 0));
end Problem7_4;

architecture ckt4 of Problem7_4 is
signal mux0_result, mux1_result: std_logic_vector(7 downto 0);
signal LDB_and_RD, LDA_and_RD: std_logic;
------------------Mux Component-----------------------------
component mux2_1 
    port(D1, D2 : in std_logic_vector(7 downto 0);
         sel : in std_logic;
         mux_out: out std_logic_vector(7 downto 0));
end component;
----------------------Register Component-------------------------
component reg8  
port(a: in std_logic_vector(7 downto 0);
     clock, LD: in std_logic;
     reg_out: out std_logic_vector(7 downto 0));
end component;

begin
LDB_and_RD <= LDB and not RD;
LDA_and_RD <= LDA and RD;

    m1: mux2_1
    port map(D1 => X,
             D2 => Y,
             sel => S1,
             mux_out => mux1_result);
             
    m0: mux2_1
    port map(D1 => RB,
             D2 => Y,
             sel => S0,
             mux_out => mux0_result);
     
     REGA: reg8
     port map(a => mux0_result,
              clock => CLK,
              LD => LDA_and_RD,
              reg_out => RA);
              
     REGB: reg8
     port map(a => mux1_result,
              clock => CLK,
              LD => LDB_and_RD,
              reg_out => RB);
              
end ckt4;

