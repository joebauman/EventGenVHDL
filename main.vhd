----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:08:11 08/16/2013 
-- Design Name: 
-- Module Name:    main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( --CLK : in STD_LOGIC;
           LED146 : out STD_LOGIC;
           LED147 : out STD_LOGIC;
           STATPIN : out STD_LOGIC;
           ADC_CLK : in STD_LOGIC;
           ADC_DATA : in STD_LOGIC_VECTOR( 7 downto 0 ) );
end main;

architecture Behavioral of main is
    constant MIN_SPAN : unsigned ( 15 downto 0 ) := X"0258"; -- 600 -> 10us

    signal eventSpan : unsigned ( 15 downto 0 ) := X"0000";
    signal eventPeak : unsigned ( 7 downto 0 ) := X"00";

    signal count : unsigned ( 27 downto 0 ) := X"0000000";
    signal inEvent : boolean := true;
begin

    countUp : process( ADC_CLK )
    begin
        if( rising_edge( ADC_CLK ) ) then
            count <= count + 1;

            if ( count > X"3FFFFFF" ) then
                LED147 <= '1';
            else
                LED147 <= '0';
            end if;
        end if;
    end process countUp;

    checkADC : process( ADC_CLK )
    begin
        if rising_edge( ADC_CLK ) then
            if inEvent = false then -- Look for start of event

                if ADC_DATA( 7 ) = '1' then -- Event start
                    LED146 <= '1';
                    inEvent <= true;

                    eventSpan <= X"0000";
                    eventPeak <= unsigned( ADC_DATA );
                end if;

            else -- In the middle of an event

                eventSpan <= eventSpan + 1;

                if eventSpan > MIN_SPAN then
                    STATPIN <= '1';
                end if;

                if ADC_DATA( 7 ) = '0' then -- Event end
                    LED146 <= '0';
                    STATPIN <= '0';
                    inEvent <= false;
                end if;

            end if; -- inEvent
        end if; -- rising_edge( ADC_CLK )
    end process checkADC;

end Behavioral;

