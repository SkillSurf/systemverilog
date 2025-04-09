-- =====================================================
-- Author: Simon Dorrer
-- Last Modified: 07.12.2024
-- Description: This .vhd file implements the board wrapper of the counter entity in VHDL.
-- =====================================================

library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.constants_p.all;
use work.all;

entity counter_board is
	port(
    clock_i 	      : in std_ulogic;
		reset_n_i 	    : in std_ulogic;
    enable_i        : in std_ulogic;
    
		counter_value_o : out unsigned(COUNTER_BITWIDTH - 1 downto 0)
	);
end entity counter_board;

architecture rtl of counter_board is

-- Inverted Logic for reset input ('1' not pressed, '0' pressed)
signal reset 		: std_ulogic;

begin
	
	-- Inverting Input Logic
	reset <= not reset_n_i;
	
	-- Embed Counter
	counter_0: entity counter(rtl)
  generic map(
    COUNTER_BITWIDTH  => COUNTER_BITWIDTH,
    COUNTER_MAX       => COUNTER_MAX
	)
	port map(
		clock_i         => clock_i,
		reset_i	        => reset,
    enable_i        => enable_i,
    
		counter_value_o => counter_value_o
	);
	-- =====================================================
end architecture rtl;