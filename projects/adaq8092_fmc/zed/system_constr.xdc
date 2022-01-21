# adaq8092

set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVDS_25 DIFF_TERM 1} [get_ports adc_clk_in_p]
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVDS_25 DIFF_TERM 1} [get_ports adc_clk_in_n]

set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS25} [get_ports {adc_data_in1[0]}]
set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS25} [get_ports {adc_data_in1[1]}]
set_property -dict {PACKAGE_PIN N22 IOSTANDARD LVCMOS25} [get_ports {adc_data_in1[2]}]
set_property -dict {PACKAGE_PIN P22 IOSTANDARD LVCMOS25} [get_ports {adc_data_in1[3]}]
set_property -dict {PACKAGE_PIN M21 IOSTANDARD LVCMOS25} [get_ports {adc_data_in1[4]}]
set_property -dict {PACKAGE_PIN M22 IOSTANDARD LVCMOS25} [get_ports {adc_data_in1[5]}]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS25} [get_ports {adc_data_in1[6]}]
set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS25} [get_ports {adc_data_in1[7]}]
set_property -dict {PACKAGE_PIN L21 IOSTANDARD LVCMOS25} [get_ports {adc_data_in1[8]}]
set_property -dict {PACKAGE_PIN L22 IOSTANDARD LVCMOS25} [get_ports {adc_data_in1[9]}]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS25} [get_ports {adc_data_in1[10]}]
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS25} [get_ports {adc_data_in1[11]}]
set_property -dict {PACKAGE_PIN J21 IOSTANDARD LVCMOS25} [get_ports {adc_data_in1[12]}]
set_property -dict {PACKAGE_PIN J22 IOSTANDARD LVCMOS25} [get_ports {adc_data_in1[13]}]

set_property -dict {PACKAGE_PIN R20 IOSTANDARD LVCMOS25} [get_ports {adc_data_in2[0]}]
set_property -dict {PACKAGE_PIN R21 IOSTANDARD LVCMOS25} [get_ports {adc_data_in2[1]}]
set_property -dict {PACKAGE_PIN R19 IOSTANDARD LVCMOS25} [get_ports {adc_data_in2[2]}]
set_property -dict {PACKAGE_PIN T19 IOSTANDARD LVCMOS25} [get_ports {adc_data_in2[3]}]
set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS25} [get_ports {adc_data_in2[4]}]
set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS25} [get_ports {adc_data_in2[5]}]
set_property -dict {PACKAGE_PIN P20 IOSTANDARD LVCMOS25} [get_ports {adc_data_in2[6]}]
set_property -dict {PACKAGE_PIN P21 IOSTANDARD LVCMOS25} [get_ports {adc_data_in2[7]}]
set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVCMOS25} [get_ports {adc_data_in2[8]}]
set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVCMOS25} [get_ports {adc_data_in2[9]}]
set_property -dict {PACKAGE_PIN K19 IOSTANDARD LVCMOS25} [get_ports {adc_data_in2[10]}]
set_property -dict {PACKAGE_PIN K20 IOSTANDARD LVCMOS25} [get_ports {adc_data_in2[11]}]
set_property -dict {PACKAGE_PIN J16 IOSTANDARD LVCMOS25} [get_ports {adc_data_in2[12]}]
set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS25} [get_ports {adc_data_in2[13]}]

set_property -dict {PACKAGE_PIN J20 IOSTANDARD LVCMOS25} [get_ports adc_data_or_1]
set_property -dict {PACKAGE_PIN K21 IOSTANDARD LVCMOS25} [get_ports adc_data_or_2]

# spi

set_property -dict {PACKAGE_PIN B20 IOSTANDARD LVCMOS25} [get_ports spi_csn_adc]
set_property -dict {PACKAGE_PIN D20 IOSTANDARD LVCMOS25} [get_ports spi_clk]
set_property -dict {PACKAGE_PIN B19 IOSTANDARD LVCMOS25} [get_ports spi_sdi]
set_property -dict {PACKAGE_PIN C20 IOSTANDARD LVCMOS25} [get_ports spi_sdo]

# other

set_property -dict {PACKAGE_PIN G20 IOSTANDARD LVCMOS25} [get_ports adc_par_ser]
set_property -dict {PACKAGE_PIN G15 IOSTANDARD LVCMOS25} [get_ports adc_pd1]
set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS25} [get_ports adc_pd2]

# clocks



create_clock -period 9.523 -name adc_clk_adaq [get_ports adc_clk_in_p]

# Input Delay Constraint


set rise_min    8.923  ;
set rise_max    9.623  ; 

#channel 1

set_input_delay -clock adc_clk_adaq -max $rise_max [get_ports {adc_data_in1[*]}]
set_input_delay -clock adc_clk_adaq -min $rise_min [get_ports {adc_data_in1[*]}]





#channel 2

set_input_delay -clock adc_clk_adaq -max $rise_max [get_ports {adc_data_in2[*]}]
set_input_delay -clock adc_clk_adaq -min $rise_min [get_ports {adc_data_in2[*]}]

# adc_or

set_input_delay -clock adc_clk_adaq -max $rise_max [get_ports {adc_data_or_*}]
set_input_delay -clock adc_clk_adaq -min $rise_min [get_ports {adc_data_or_*}]


