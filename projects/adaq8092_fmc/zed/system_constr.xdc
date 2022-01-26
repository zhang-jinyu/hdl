# adaq8092

set_property -dict {PACKAGE_PIN M19    IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports adc_clk_in_p]        ; #G06   FMC_LPC_LA00_P 
set_property -dict {PACKAGE_PIN M20    IOSTANDARD LVDS_25 DIFF_TERM TRUE} [get_ports adc_clk_in_n]        ; #G07   FMC_LPC_LA00_N 

set_property -dict {PACKAGE_PIN P18    IOSTANDARD LVCMOS25              } [get_ports adc_data_in1[0]]     ; #H08   FMC_LPC_LA02_N D1_2 
set_property -dict {PACKAGE_PIN P22    IOSTANDARD LVCMOS25              } [get_ports adc_data_in1[1]]     ; #G10  FMC_LPC_LA03_N D1_4
set_property -dict {PACKAGE_PIN M22    IOSTANDARD LVCMOS25              } [get_ports adc_data_in1[2]]     ; #H11  FMC_LPC_LA04_N D1_6
set_property -dict {PACKAGE_PIN K18    IOSTANDARD LVCMOS25              } [get_ports adc_data_in1[3]]     ; #D12  FMC_LPC_LA05_N D1_8
set_property -dict {PACKAGE_PIN L22    IOSTANDARD LVCMOS25              } [get_ports adc_data_in1[4]]     ; #C11  FMC_LPC_LA06_N D1_10
set_property -dict {PACKAGE_PIN T17    IOSTANDARD LVCMOS25              } [get_ports adc_data_in1[5]]     ; #H14  FMC_LPC_LA07_N D1_12
set_property -dict {PACKAGE_PIN J22    IOSTANDARD LVCMOS25              } [get_ports adc_data_in1[6]]     ; #G13  FMC_LPC_LA08_N D1_14
  

set_property -dict {PACKAGE_PIN R21    IOSTANDARD LVCMOS25              } [get_ports adc_data_in2[0]]     ; #D15  FMC_LPC_LA09_N D2_2 
set_property -dict {PACKAGE_PIN T19    IOSTANDARD LVCMOS25              } [get_ports adc_data_in2[1]]     ; #C15  FMC_LPC_LA10_N D2_4
set_property -dict {PACKAGE_PIN N18    IOSTANDARD LVCMOS25              } [get_ports adc_data_in2[2]]     ; #H17  FMC_LPC_LA11_N D2_6
set_property -dict {PACKAGE_PIN P21    IOSTANDARD LVCMOS25              } [get_ports adc_data_in2[3]]     ; #G16  FMC_LPC_LA12_N D2_8
set_property -dict {PACKAGE_PIN M17    IOSTANDARD LVCMOS25              } [get_ports adc_data_in2[4]]     ; #D18  FMC_LPC_LA13_N D2_10
set_property -dict {PACKAGE_PIN K20    IOSTANDARD LVCMOS25              } [get_ports adc_data_in2[5]]     ; #C19  FMC_LPC_LA14_N D2_12
set_property -dict {PACKAGE_PIN J17    IOSTANDARD LVCMOS25              } [get_ports adc_data_in2[6]]     ; #H20  FMC_LPC_LA15_N D2_14

  
set_property -dict {PACKAGE_PIN J20    IOSTANDARD LVCMOS25              } [get_ports adc_data_or]       ; #G18  FMC_LPC_LA16_P

  
# spi  
  
set_property -dict {PACKAGE_PIN B20    IOSTANDARD LVCMOS25} [get_ports spi_csn_adc]                       ; #D21  FMC_LPC_LA17_N
set_property -dict {PACKAGE_PIN D20    IOSTANDARD LVCMOS25} [get_ports spi_clk]                           ; #C22  FMC_LPC_LA18_P
set_property -dict {PACKAGE_PIN B19    IOSTANDARD LVCMOS25} [get_ports spi_sdi]                           ; #D20  FMC_LPC_LA17_P
set_property -dict {PACKAGE_PIN C20    IOSTANDARD LVCMOS25} [get_ports spi_sdo]                           ; #C23  FMC_LPC_LA18_N
  
# other  
  
set_property -dict {PACKAGE_PIN G20    IOSTANDARD LVCMOS25} [get_ports adc_par_ser]                       ; #G21  FMC_LPC_LA20_P
set_property -dict {PACKAGE_PIN G15    IOSTANDARD LVCMOS25} [get_ports adc_pd1]                           ; #H22  FMC_LPC_LA19_P
set_property -dict {PACKAGE_PIN G16    IOSTANDARD LVCMOS25} [get_ports adc_pd2]                           ; #H23  FMC_LPC_LA19_N

# clocks
create_clock -name adc_clk_adaq      -period 9.523 [get_ports adc_clk_in_p]

# Input Delay Constraint

set rise_min            4.761;       # period/2 - skew_bre(=0)       
set rise_max            5.261;       # period/2 + skew_are       

set fall_min            4.761;       # period/2 - skew_bfe(=0)        
set fall_max            5.261;       # period/2 + skew_afe         

#channel 1 

set_input_delay -clock adc_clk_adaq -max  $rise_max  [get_ports adc_data_in1[*]];
set_input_delay -clock adc_clk_adaq -min  $rise_min  [get_ports adc_data_in1[*]];
set_input_delay -clock adc_clk_adaq -max  $fall_max  [get_ports adc_data_in1[*]] -clock_fall -add_delay;
set_input_delay -clock adc_clk_adaq -min  $fall_min  [get_ports adc_data_in1[*]] -clock_fall -add_delay;
		   				   
#channel 2             
					   
set_input_delay -clock adc_clk_adaq -max  $rise_max  [get_ports adc_data_in2[*]];
set_input_delay -clock adc_clk_adaq -min  $rise_min  [get_ports adc_data_in2[*]];
set_input_delay -clock adc_clk_adaq -max  $fall_max  [get_ports adc_data_in2[*]] -clock_fall -add_delay;
set_input_delay -clock adc_clk_adaq -min  $fall_min  [get_ports adc_data_in2[*]] -clock_fall -add_delay;

#or

set_input_delay -clock adc_clk_adaq -max  $rise_max  [get_ports adc_data_or];                       
set_input_delay -clock adc_clk_adaq -min  $rise_min  [get_ports adc_data_or];                       
set_input_delay -clock adc_clk_adaq -max  $fall_max  [get_ports adc_data_or] -clock_fall -add_delay;
set_input_delay -clock adc_clk_adaq -min  $fall_min  [get_ports adc_data_or] -clock_fall -add_delay;                    


#set_property IDELAY_VALUE 0 [get_cells i_system_wrapper/system_i/axi_adaq8092/inst/i_if/cmos_ddr_adc_if[*].i_adc_data/i_rx_data_idelay]