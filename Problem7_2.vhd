
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-----------------------2:1 Mux---------------------------
entity mux4t1 is 
    port(D0, D1, D2, D3 : in std_logic_vector(7 downto 0);
         sel : in std_logic_vector(1 downto 0);
         mux_out: out std_logic_vector(7 downto 0));
end mux4t1;
architecture my_mux of mux4t1 is
begin
    with sel select
    mux_out <= D0 when "00",
               D1 when "01",
               D2 when "10",
               D3 when "11",
               "00000000" when others;
end my_mux;
------------------------Register---------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
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

----------------------Decoder---------------------------
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
----------------Top Level----------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Problem7_2 is
Port(X, Y, Z: in std_logic_vector(7 downto 0);
     DS, CLK, LDA, LDB: in std_logic;
     MS: in std_logic_vector(1 downto 0);
     RB_out, RA_out: inout std_logic_vector(7 downto 0));
end Problem7_2;

architecture ckt2 of Problem7_2 is
--Decoder component
component decoder1t2
port(in_1: in std_logic;
     D0, D1: out std_logic);
end component;

--Register component
component reg8 
port(a: in std_logic_vector(7 downto 0);
     clock, LD: in std_logic;
     reg_out: out std_logic_vector(7 downto 0));
end component;

--Mux Component
component mux4t1 
    port(D0, D1, D2, D3 : in std_logic_vector(7 downto 0);
         sel : in std_logic_vector(1 downto 0);
         mux_out: out std_logic_vector(7 downto 0));
end component;

signal mux_result: std_logic_vector(7 downto 0);
signal dout0, dout1 : std_logic;
begin
    DECODER: decoder1t2
    port map(in_1 => DS,
             D0 => dout0,
             D1 => dout1);
             
    RA: reg8
    port map(LD => dout0,
             reg_out => RA_out,
             clock => CLK,
             a => mux_result);
    RB: reg8
    port map(LD => dout1,
             clock => CLK,
             a => RA_out,
             reg_out => RB_out);
    
    m1: mux4t1
    port map(D0 => RB_out,
             D1 => Z,
             D2 => Y,
             D3 => X,
             SEL => MS);
end ckt2;
