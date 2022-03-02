#adaq8092

 create_bd_port -dir I adc_clk_in_p
 create_bd_port -dir I adc_clk_in_n

 create_bd_port -dir I adc_data_or_p
 create_bd_port -dir I adc_data_or_n

 create_bd_port -dir I -from 6 -to 0 adc_data_in1_p
 create_bd_port -dir I -from 6 -to 0 adc_data_in1_n
 
 create_bd_port -dir I -from 6 -to 0 adc_data_in2_p
 create_bd_port -dir I -from 6 -to 0 adc_data_in2_n

 # adc peripheral

ad_ip_instance util_cpack2 axi_adaq8092_cpack [list \
                                             NUM_OF_CHANNELS 2 \
                                             SAMPLES_PER_CHANNEL 1 \
                                             SAMPLE_DATA_WIDTH 16 \
]

 ad_ip_instance axi_adaq8092 axi_adaq8092

 ad_ip_instance axi_dmac axi_adaq8092_dma
 ad_ip_parameter axi_adaq8092_dma CONFIG.DMA_TYPE_SRC 2
 ad_ip_parameter axi_adaq8092_dma CONFIG.DMA_TYPE_DEST 0
 ad_ip_parameter axi_adaq8092_dma CONFIG.CYCLIC 0
 ad_ip_parameter axi_adaq8092_dma CONFIG.SYNC_TRANSFER_START 0
 ad_ip_parameter axi_adaq8092_dma CONFIG.AXI_SLICE_SRC 0
 ad_ip_parameter axi_adaq8092_dma CONFIG.AXI_SLICE_DEST 0
 ad_ip_parameter axi_adaq8092_dma CONFIG.DMA_2D_TRANSFER 0
 ad_ip_parameter axi_adaq8092_dma CONFIG.DMA_DATA_WIDTH_SRC 32
 ad_ip_parameter axi_adaq8092_dma CONFIG.DMA_DATA_WIDTH_DEST 64
 ad_ip_parameter axi_adaq8092_dma CONFIG.AXI_SLICE_DEST 1

 # connections

 ad_connect    adc_clk_in_p     axi_adaq8092/adc_clk_in_p
 ad_connect    adc_clk_in_n     axi_adaq8092/adc_clk_in_n


            
ad_connect    adc_data_in1_p  axi_adaq8092/adc_data_in1_p
ad_connect    adc_data_in1_n  axi_adaq8092/adc_data_in1_n

ad_connect    adc_data_in2_p  axi_adaq8092/adc_data_in2_p
ad_connect    adc_data_in2_n  axi_adaq8092/adc_data_in2_n


 ad_connect    adc_data_or_p    axi_adaq8092/adc_or_in_p
 ad_connect    adc_data_or_n    axi_adaq8092/adc_or_in_n

 ad_connect adaq8092_clk axi_adaq8092/adc_clk

 # connections upack

#ad_connect  util_ad6676_xcvr/rx_out_clk_0 axi_ad6676_core/link_clk
#ad_connect  util_ad6676_xcvr/rx_out_clk_0 rx_core_clk
#ad_connect  axi_ad6676_jesd/rx_sof axi_ad6676_core/link_sof
#ad_connect  axi_ad6676_jesd/rx_data_tdata axi_ad6676_core/link_data
#ad_connect  axi_ad6676_jesd/rx_data_tvalid axi_ad6676_core/link_valid
#ad_connect  util_ad6676_xcvr/rx_out_clk_0 axi_ad6676_cpack/clk


ad_connect  sys_rstgen/peripheral_reset axi_adaq8092_cpack/reset

#channels connection 
for {set i 0} {$i < 2} {incr i} {

  ad_connect  axi_adaq8092/adc_enable_${i} axi_adaq8092_cpack/enable_${i}
  ad_connect  axi_adaq8092/adc_data_channel${i} axi_adaq8092_cpack/fifo_wr_data_${i} 
}
 ad_connect  axi_adaq8092_dma/fifo_wr_din axi_adaq8092_cpack/packed_fifo_wr
 ad_connect axi_adaq8092/adc_clk axi_adaq8092_dma/fifo_wr_clk
 ad_connect $sys_iodelay_clk     axi_adaq8092/delay_clk 

 ad_connect  axi_adaq8092/adc_valid axi_adaq8092_cpack/fifo_wr_en
 ad_connect  axi_adaq8092/adc_dovf axi_adaq8092_cpack/fifo_wr_overflow

 # address mapping

 ad_cpu_interconnect 0x44A00000 axi_adaq8092
 ad_cpu_interconnect 0x44A30000 axi_adaq8092_dma

 # interconnect (adc)

 ad_mem_hp2_interconnect $sys_cpu_clk sys_ps7/S_AXI_HP2
 ad_mem_hp2_interconnect $sys_cpu_clk axi_adaq8092_dma/m_dest_axi
 ad_connect  $sys_cpu_resetn axi_adaq8092_dma/m_dest_axi_aresetn

 # interrupts

 ad_cpu_interrupt ps-13 mb-13 axi_adaq8092_dma/irq
 
