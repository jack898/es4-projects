library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
	port (
		input_num : in unsigned(5 downto 0);
		current_display : out std_logic_vector(6 downto 0);
		LED_0 : out std_logic;
		LED_1 : out std_logic
	);
end top;

architecture synth of top is
component HSOSC is
generic (
	CLKHF_DIV : String := "0b00");
port (
	CLKHFPU : in std_logic := 'X';
	CLKHFEN : in std_logic := 'X';
	CLKHF : out std_logic := 'X');
end component;

component counter is
	port(
		clk : in std_logic;
		result : out std_logic_vector(25 downto 0)
	);
end component;

component dddd is
	port (
		count : in unsigned(5 downto 0);
		digit0 : out std_logic_vector(6 downto 0);
		digit1 : out std_logic_vector(6 downto 0)	
	);
end component;
signal clk : std_logic;
signal int : std_logic_vector(25 downto 0);
signal display_pins0 : std_logic_vector(6 downto 0);
signal display_pins1 : std_logic_vector(6 downto 0);
begin
	osc : HSOSC generic map ( CLKHF_DIV => "0b00") -- mapping oscillator to clock
	port map (CLKHFPU => '1',
	CLKHFEN => '1',
	CLKHF => clk);
	
	dut : counter port map (clk, int); -- mapping counter to LEDs
	-- Logic to blink LEDs rapidly
	LED_0 <= not int(18);
	LED_1 <= int(18);
	
	dual_display : dddd port map (input_num, digit0 => display_pins0, digit1 => display_pins1); -- mapping dddd to top
	
	process (LED_0, LED_1, display_pins0, display_pins1) is
	begin
		if LED_0 = '1' then
            current_display <= display_pins0; -- Show digit0
        elsif LED_1 = '1' then
            current_display <= display_pins1; -- Show digit1
        else
            current_display <= display_pins0; -- other case
        end if;
	end process;
end;


