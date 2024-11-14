library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
  port(
	  a : in unsigned(3 downto 0);
	  b : in unsigned(3 downto 0);
	  s : in std_logic_vector(1 downto 0);
	  y : out std_logic_vector(6 downto 0)
  );
end top;


architecture synth of top is
component sevenseg is
	port (
	  S : in unsigned(3 downto 0);
	  segments : out std_logic_vector(6 downto 0)
	);
end component;

component alu is
	port(
	  a : in unsigned(3 downto 0);
	  b : in unsigned(3 downto 0);
	  s : in std_logic_vector(1 downto 0);
	  y : out unsigned(3 downto 0)
	);
end component;

signal inter : unsigned(3 downto 0);
begin
  alu_1 : alu port map (a, b, s, inter);
  
  seven_seg : sevenseg port map (inter, y);
	   
	  
end;

