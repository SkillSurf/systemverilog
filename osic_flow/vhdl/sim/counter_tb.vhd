-- =====================================================
-- Author: Simon Dorrer
-- Last Modified: 07.12.2024
-- Description: This .vhd file implements a testbench testing the VHDL counter entity.
-- =====================================================

library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.constants_p.all;
use work.all;

entity counter_tb is

end entity counter_tb;

architecture bhv of counter_tb is

-- Inputs
signal clock 			    : std_ulogic := '0';
signal reset_n 			  : std_ulogic := '1'; -- active low reset
signal enable 			  : std_ulogic := '0';

-- Outputs
signal counter_value  : unsigned(COUNTER_BITWIDTH - 1 downto 0);

-- End of Simulation for ModelSim
signal tb_end           : std_ulogic := '0';

begin

  -- Embed DUT Counter
  dut_counter: entity counter_board(rtl)
	port map(
		clock_i 			  => clock,
		reset_n_i 			=> reset_n,
    enable_i        => enable,
    
		counter_value_o => counter_value
	);
	-- ============================================
  
  -- Simulating clock signal
	clk_proc: process
	begin
		clock <= not clock;
		wait for 1 * sec / (2 * CLK_FREQ);
	end process clk_proc;
  -- ============================================
  
  -- Stimuli Process
	stimuli: process
	begin
    -- Reset
    reset_n <= '0';	
		wait for 1 * sec / CLK_FREQ;
		reset_n <= '1';
		wait for 1 * sec / CLK_FREQ;
    
    -- Test enable
    wait for 5 * sec / CLK_FREQ;
    enable <= '1';
    wait for 10 * sec / CLK_FREQ;
    enable <= '0';
    wait for 5 * sec / CLK_FREQ;
    enable <= '1';
    wait for 10 * sec / CLK_FREQ;
    
    tb_end <= '1';
    report "End of simulation." severity error;
    wait;
	end process stimuli;
  -- ============================================
end architecture bhv;