-- =====================================================
-- Author: Simon Dorrer
-- Last Modified: 07.12.2024
-- description: This .vhd file implements all constants for the N-Bit counter.
-- =====================================================

library ieee;

use ieee.std_logic_1164.all;
use ieee.math_real.all;

package constants_p is
  -- User constants
  constant CLK_FREQ			      : natural := 8e6;
  constant COUNTER_MAX			  : natural := 16;
  constant COUNTER_BITWIDTH 	: natural := natural(ceil(log2(real(COUNTER_MAX))));
  -- ====================================================================
end package constants_p;