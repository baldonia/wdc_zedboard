#set_property DIFF_TERM TRUE [get_ports DIG0_CLKOUT_P]
#set_property DIFF_TERM TRUE [get_ports DIG0_CLKOUT_N]
set_property IOSTANDARD LVDS_25 [get_ports DIG0_CLKOUT_N]
set_property PACKAGE_PIN B20 [get_ports DIG0_CLKOUT_N]

set_property IOSTANDARD LVDS_25 [get_ports DIG1_CLKOUT_N]
set_property PACKAGE_PIN M20 [get_ports DIG1_CLKOUT_N]

set_property IOSTANDARD LVDS_25 [get_ports DIG1_CLKOUT_P]
set_property PACKAGE_PIN M19 [get_ports DIG1_CLKOUT_P]

# output clocks
set_property IOSTANDARD LVDS_25 [get_ports DIG0_CLK_P]
set_property PACKAGE_PIN D20 [get_ports DIG0_CLK_P]

set_property IOSTANDARD LVDS_25 [get_ports DIG0_CLK_N]
set_property PACKAGE_PIN C20 [get_ports DIG0_CLK_N]

set_property IOSTANDARD LVDS_25 [get_ports DIG1_CLK_P]
set_property PACKAGE_PIN N19 [get_ports DIG1_CLK_P]

set_property IOSTANDARD LVDS_25 [get_ports DIG1_CLK_N]
set_property PACKAGE_PIN N20 [get_ports DIG1_CLK_N]

# OE
set_property IOSTANDARD LVCMOS25 [get_ports DIG_OE]
set_property PACKAGE_PIN K19 [get_ports DIG_OE]
