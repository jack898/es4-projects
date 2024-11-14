library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fastcounter is
	port(
		clk : in std_logic;
		result : out std_logic_vector(22 downto 0)
	);
end fastcounter;

architecture synth of fastcounter is
signal count : unsigned(22 downto 0);
begin
	process (clk) begin
		if rising_edge(clk) then
			count <= count + 1;
		end if;
	end process;
	
	result <= std_logic_vector(count);
end;
