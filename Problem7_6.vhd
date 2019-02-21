library IEEE;
use IEEE.std_logic_1164.all;
-----------------------------Mux Entity---------------------------
architecture my_mux of mux2_1 is
begin
    with sel select
    mux_out <= D2 when '0',
               D1 when '1',
               "00000000" when others;
end my_mux;
-----------------------------Register Entity------------------------
library IEEE;
use IEEE.std_logic_1164.all;
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
-------------------Decoder Entity---------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity decoder1t2 is
port(in_1: in std_logic;
     D0, D1: out std_logic);
end decoder1t2; 
architecture my_decoder of decoder1t2 is
begin
    D0 <= not in_1;
    D1 <= in_1;
end my_decoder;
--------------------------------Top Level---------------------------
library IEEE;
use IEEE.std_logic_1164.all;
entity Problem7_6 is
port(SEL1, SEL2, CLK: in std_logic;
     A, B, C: in std_logic_vector(7 downto 0);
     RAP, RBP: out std_logic_vector(7 downto 0));
end Problem7_6;

architecture ckt6 of Problem7_6 is 

signal mux_result: std_logic_vector(7 downto 0);
signal loadA, loadB: std_logic;
--------------------------Mux Compenent-----------------------------
component mux2_1 is 
    port(D1, D2 : in std_logic_vector(7 downto 0);
         sel : in std_logic;
         mux_out: out std_logic_vector(7 downto 0));
end component;
-------------------------Register Compoenent------------------------
component reg8 is 
port(a: in std_logic_vector(7 downto 0);
     clock, LD: in std_logic;
     reg_out: out std_logic_vector(7 downto 0));
end component;
--------------------------Decoder component------------------------
component decoder1t2 is
port(in_1: in std_logic;
     D0, D1: out std_logic);
end component;

begin
    m1: mux2_1
    port map(D1 => A,
             D2 => B,
             sel => SEL1,
             mux_out => mux_result);
    decoder: decoder1t2
    port map(in_1 => SEL2,
             D1 => loadA,
             D0 => loadB);
             
    REGA: reg8
    port map(a => mux_result,
             clock => CLK,
             LD => loadA,
             reg_out => RAP);
             
    REGB: reg8
    port map(a => C,
             clock =>CLK,
             LD => loadB,
             reg_out => RBP);
end ckt6;