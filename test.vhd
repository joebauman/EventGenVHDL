--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:55:41 09/12/2013
-- Design Name:   
-- Module Name:   C:/Xilinx/EventGenVHDL/test.vhd
-- Project Name:  EventGenVHDL
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: main
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         LED146 : OUT  std_logic;
         LED147 : OUT  std_logic;
         STATPIN : OUT  std_logic;
         ADC_CLK : IN  std_logic;
         ADC_DATA : IN  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ADC_CLK : std_logic := '0';
   signal ADC_DATA : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal LED146 : std_logic;
   signal LED147 : std_logic;
   signal STATPIN : std_logic;

   -- Clock period definitions
   constant ADC_CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          LED146 => LED146,
          LED147 => LED147,
          STATPIN => STATPIN,
          ADC_CLK => ADC_CLK,
          ADC_DATA => ADC_DATA
        );

   -- Clock process definitions
   ADC_CLK_process :process
   begin
		ADC_CLK <= '0';
		wait for ADC_CLK_period/2;
		ADC_CLK <= '1';
		wait for ADC_CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	

      wait for ADC_CLK_period*10;
      ADC_DATA <= X"FF";

      wait for ADC_CLK_period*1000;
      ADC_DATA <= X"00";

      wait;
   end process;

END;
