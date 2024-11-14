library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
	port (
		read_write : in std_logic; -- pin 2
		write_value : in std_logic_vector(1 downto 0); -- pins 3 and 4
		read_value : out std_logic_vector(1 downto 0) -- pins 28 and 38
	);
end top;

architecture synth of top is
component ramdp is
  generic (
    WORD_SIZE : natural := 2; -- Bits per word (read/write block size)
    N_WORDS : natural := 64; -- Number of words in the memory
    ADDR_WIDTH : natural := 6 -- This should be log2 of N_WORDS; see the Big Guide to Memory for a way to eliminate this manual calculation
   );
  port (
    clk : in std_logic;
    r_addr : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
    r_data : out std_logic_vector(WORD_SIZE - 1 downto 0);
    w_addr : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
    w_data : in std_logic_vector(WORD_SIZE - 1 downto 0);
    w_enable : in std_logic
  );
end component;

component HSOSC is
generic (
	CLKHF_DIV : String := "0b00");
port (
	CLKHFPU : in std_logic := 'X';
	CLKHFEN : in std_logic := 'X';
	CLKHF : out std_logic := 'X'
	);
end component;

component fastcounter is
	port(
		clk : in std_logic;
		result : out std_logic_vector(22 downto 0)
	);
end component;

signal clk : std_logic;
signal sample_counter : unsigned(5 downto 0) := 6d"0";
signal intermediate_counter : std_logic_vector(22 downto 0);
signal read_write_prev : std_logic;
signal sample_counter_saved : unsigned(5 downto 0);
begin
	osc : HSOSC generic map ( CLKHF_DIV => "0b00") 
	port map (CLKHFPU => '1',
	CLKHFEN => '1',
	CLKHF => clk);
	
	fc : fastcounter port map (clk, intermediate_counter);
	ram : ramdp port map (clk, w_enable => read_write, w_data => write_value, r_addr => std_logic_vector(sample_counter), w_addr => std_logic_vector(sample_counter), r_data => read_value);
	
	process(clk) is
	begin
		if rising_edge(clk) then
			if intermediate_counter  = 23d"0" then -- Counter just rolled over
				sample_counter <= sample_counter + 1;
			end if;
			
			
			-- L6: If record button is pressed or released, reset sample_counter (for immediate replay)
			if (not read_write and read_write_prev) or (read_write and not read_write_prev) then
				sample_counter <= 6d"0";
			end if;
			read_write_prev <= read_write;
			
			-- L7: Looping over recorded portion, not entire memory
			if (read_write and not read_write_prev) then -- control button released
				sample_counter_saved <= sample_counter;
				
				if sample_counter = 6d"0" then
					sample_counter <= sample_counter_saved;
				end if;
			end if;	
		end if;
	end process;
end;


