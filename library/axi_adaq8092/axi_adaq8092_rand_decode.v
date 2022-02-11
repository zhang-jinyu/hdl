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
// ADC DIGITAL OUTPUT RANDOMIZE DECODE 

`timescale 1ns/100ps


module axi_adaq8092_rand_decode(
  input [13:0] adc_data,
  input adc_clk,
  input adc_rand_enb,
  output [13:0] adc_data_decoded);
  
  integer i;
  reg [13:0] adc_data_decoded_s;
  
  assign adc_data_decoded = adc_data_decoded_s;
  
  always @(posedge adc_clk) begin 
  
    for (i = 1; i <= 13; i = i + 1) begin
      if(adc_rand_enb == 1) begin
        adc_data_decoded_s[i]= adc_data[i] ^ adc_data[0];
      end else begin 
        adc_data_decoded_s[i]=adc_data[i];
	  end
      adc_data_decoded_s[i] =adc_data[0];  
    end
 end
     
endmodule
