library IEEE;
use IEEE.std_logic_1164.all;
-------------------------2:1 Mux---------------------------
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

----------------------------Register---------------------------
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

library IEEE;
use IEEE.std_logic_1164.all;
--------------------------Top Level----------------------
entity Problem7_3 is
port(LDA, LDB, CLK: in std_logic;
     S1: in std_logic;
     S0: in std_logic;
     RA_out, RB_out: inout std_logic_vector(7 downto 0);
     X, Y: in std_logic_vector(7 downto 0));
end Problem7_3;

architecture ckt3 of Problem7_3 is

signal mux0_result, mux1_result: std_logic_vector(7 downto 0);

---------------------Register component------------------------
component reg8 is 
port(a: in std_logic_vector(7 downto 0);
     clock, LD: in std_logic;
     reg_out: out std_logic_vector(7 downto 0));
end component;

--------------------------------Mux Component---------------------
component mux2_1 is 
    port(D1, D2 : in std_logic_vector(7 downto 0);
         sel : in std_logic;
         mux_out: out std_logic_vector(7 downto 0));
end component;

begin
    m1: mux2_1
    port map(D1 => X,
             D2 => RB_out,
             mux_out => mux1_result,
             sel => S1);
    m0: mux2_1
    port map(D1 => RA_out,
             D2 => Y,
             sel => S0,
             mux_out => mux0_result);
    
    REGA: reg8
    port map(a => mux1_result,
             clock => CLK,
             LD => LDA,
             reg_out => RA_out);
    
    REGB: reg8
    port map(a => mux0_result,
             clock => CLK,
             LD => LDB,
             reg_out => RB_out);          
end ckt3;