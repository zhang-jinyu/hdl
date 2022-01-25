// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2017 (c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************
// This is the LVDS/DDR interface, note that overrange is independent of data path,
// software will not be able to relate overrange to a specific sample!

`timescale 1ns/100ps

module axi_adaq8092_if #(
  parameter   FPGA_TECHNOLOGY = 0,
  parameter   IO_DELAY_GROUP = "adc_if_delay_group",
  parameter   DELAY_REFCLK_FREQUENCY = 200) (

  // adc interface (clk, data, over-range)
  // nominal clock 125 MHz, up to 300 MHz

  input                   adc_clk_in_p,
  input                   adc_clk_in_n,
  input       [27:0]      adc_data_in,
  input                   adc_or_in_1,
  input                   adc_or_in_2,

  // interface outputs

  output                  adc_clk,
  output  reg [27:0]      adc_data, 
  output  reg             adc_or,
  output  reg             adc_status,

  // delay control signals

  input                   up_clk,
  input       [29:0]      up_dld,
  input       [149:0]     up_dwdata,
  output      [149:0]     up_drdata,
  input                   delay_clk,
  input                   delay_rst,
  output                  delay_locked);




  // internal signals

  wire    [ 27:0]  adc_data_s;
 
  wire            adc_or_s_1;
  wire            adc_or_s_2;

  genvar          l_inst;

  always @(posedge adc_clk)
  begin
    adc_status <= 1'b1;
    adc_or <= adc_or_s_1 | adc_or_s_1;
          // SDR CMOS INTERFACE
    adc_data <= adc_data_s;
   
  
  end

  // data interface
  
   generate
   
                                    

      for (l_inst = 0; l_inst <= 27; l_inst = l_inst + 1) begin : cmos_sdr_adc_if  // SDR CMOS INTERFACE 
      
// IF IBUF -> IDELAY -> IDDR IS NOT NECESSARY IN ORDER TO INSTANTIATE ad_data_in YOU SHOULD USE:  
//       IBUF i_rx_data_ibuf (
//          .I (adc_data_in[l_inst]),
//          .O (adc_data_s[l_inst]));

        ad_data_in #(
          .SINGLE_ENDED(1),
          .FPGA_TECHNOLOGY (FPGA_TECHNOLOGY),
          .IODELAY_CTRL (0),
          .IODELAY_GROUP (IO_DELAY_GROUP),
          .REFCLK_FREQUENCY (DELAY_REFCLK_FREQUENCY))
        i_adc_data (
          .rx_clk (adc_clk),
          .rx_data_in_p (adc_data_in[l_inst]),
          .rx_data_in_n (1'b0),
          .rx_data_p (adc_data_s[l_inst]),
          .up_clk (up_clk),
          .up_dld (up_dld[l_inst]),
          .up_dwdata (up_dwdata[((l_inst*5)+4):(l_inst*5)]),
          .up_drdata (up_drdata[((l_inst*5)+4):(l_inst*5)]),
          .delay_clk (delay_clk),
          .delay_rst (delay_rst),
          .delay_locked ());
          
       end
          
  endgenerate

  // over-range interface
  
     ad_data_in #(
    .SINGLE_ENDED(1),
    .FPGA_TECHNOLOGY (FPGA_TECHNOLOGY),
    .IODELAY_CTRL (1),
    .IODELAY_GROUP (IO_DELAY_GROUP),
    .REFCLK_FREQUENCY (DELAY_REFCLK_FREQUENCY))
  i_adc_or_1 (
    .rx_clk (adc_clk),
    .rx_data_in_p (adc_or_in_1),
    .rx_data_in_n (1'b0),
    .rx_data_p (adc_or_s_1),
    .up_clk (up_clk),
    .up_dld (up_dld[28]),
    .up_dwdata (up_dwdata[144:140]),
    .up_drdata (up_drdata[144:140]),
    .delay_clk (delay_clk),
    .delay_rst (delay_rst),
    .delay_locked ());
    
    
     ad_data_in #(
    .SINGLE_ENDED(1),
    .FPGA_TECHNOLOGY (FPGA_TECHNOLOGY),
    .IODELAY_CTRL (1),
    .IODELAY_GROUP (IO_DELAY_GROUP),
    .REFCLK_FREQUENCY (DELAY_REFCLK_FREQUENCY))
  i_adc_or_2 (
    .rx_clk (adc_clk),
    .rx_data_in_p (adc_or_in_2),
    .rx_data_in_n (),
    .rx_data_p (adc_or_s_2),
    .up_clk (up_clk),
    .up_dld (up_dld[29]),
    .up_dwdata (up_dwdata[149:145]),
    .up_drdata (up_drdata[149:145]),
    .delay_clk (delay_clk),
    .delay_rst (delay_rst),
    .delay_locked ());
          
  
  // clock

  ad_data_clk
  i_adc_clk (
    .rst (1'b0),
    .locked (),
    .clk_in_p (adc_clk_in_p),
    .clk_in_n (adc_clk_in_n),
    .clk (adc_clk));

endmodule

// ***************************************************************************
// ***************************************************************************
