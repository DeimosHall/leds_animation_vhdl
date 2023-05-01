library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity leds_animation is
    port (
        clk : in std_logic;
        leds : out std_logic_vector(2 downto 0)
    );
end entity leds_animation;

architecture main of leds_animation is
    signal counter : unsigned(32 downto 0) := (others => '0');
    signal one_second : unsigned(32 downto 0) := to_unsigned(50000000, 33);
    signal current_state : std_logic_vector(2 downto 0) := "001"; --- Animation: 001 -> 010 -> 100 -> 001 -> ...
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if counter = one_second then
                counter <= (others => '0');
                -- Set the animation to the leds
                leds <= current_state;

                -- Change the state of the animation
                current_state <= std_logic_vector(unsigned(current_state) rol 1); -- rol = rotate left
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
end architecture main;