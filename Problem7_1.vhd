--Library Declaration
library IEEE;
use IEEE.std_logic_1164.all;
---------------------2:1 Mux---------------------------
entity mux2_1 is 
    port(D1, D2 : in std_logic_vector(7 downto 0);
         sel : in std_logic;
         mux_out: out std_logic_vector(7 downto 0));
end mux2_1;
architecture my_mux of mux2_1 is
begin
    with sel select
    mux_out <= D1 when '0',
               D2 when '1',
               "00000000" when others;
end my_mux;

library IEEE;
use IEEE.std_logic_1164.all;
---------------------Register---------------------------
entity reg8 is 
port(a: in std_logic_vector(7 downto 0);
     clock, LD: in std_logic;
     reg_out: out std_logic_vector(7 downto 0));
end reg8;

architecture my_reg of reg8 is 
begin
    process(clock)
    begin
        if(rising_edge(clock)) then
            reg_out <= a;
        end if;
    end process;
end my_reg;
--------------------Top Level------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
entity Problem7_1 is
port(A, B: in std_logic_vector(7 downto 0);
     LDA, SEL, CLK: in std_logic;
     F: out std_logic_vector(7 downto 0));
end Problem7_1;          

architecture ckt1 of Problem7_1 is
------------------mux component-----------------------------
    component mux2_1
        port(D1, D2 : in std_logic_vector(7 downto 0);
             sel : in std_logic;
             mux_out: out std_logic_vector(7 downto 0));
    end component;
---------------------register component-----------------------
component reg8  
    port(a: in std_logic_vector(7 downto 0);
     clock, LD: in std_logic;
     reg_out: out std_logic_vector(7 downto 0));
end component;

    signal mux_result: std_logic_vector(7 downto 0);
begin
    m1: mux2_1
    port map(D1 => A,
             D2 => B,
             SEL => SEL,
             mux_out => mux_result); 
    REG_A: reg8
    port map(a => mux_result,
             clock => CLK,
             LD => LDA,
             reg_out => F);
end ckt1;