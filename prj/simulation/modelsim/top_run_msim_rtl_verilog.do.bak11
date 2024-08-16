transcript on
if ![file isdirectory top_iputf_libs] {
	file mkdir top_iputf_libs
}

if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {d:/altera/set_up/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog -vlog01compat -work lpm_ver {d:/altera/set_up/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog -vlog01compat -work sgate_ver {d:/altera/set_up/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog -vlog01compat -work altera_mf_ver {d:/altera/set_up/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {d:/altera/set_up/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/cycloneive_ver
vmap cycloneive_ver ./verilog_libs/cycloneive_ver
vlog -vlog01compat -work cycloneive_ver {d:/altera/set_up/quartus/eda/sim_lib/cycloneive_atoms.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog "C:/Users/lonely/Desktop/test2/rtl/fir/fir_low_sim/altera_avalon_sc_fifo.v"                        
vcom "C:/Users/lonely/Desktop/test2/rtl/fir/fir_low_sim/auk_dspip_math_pkg_hpfir.vhd"                   
vcom "C:/Users/lonely/Desktop/test2/rtl/fir/fir_low_sim/auk_dspip_lib_pkg_hpfir.vhd"                    
vcom "C:/Users/lonely/Desktop/test2/rtl/fir/fir_low_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"
vcom "C:/Users/lonely/Desktop/test2/rtl/fir/fir_low_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"      
vcom "C:/Users/lonely/Desktop/test2/rtl/fir/fir_low_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"    
vcom "C:/Users/lonely/Desktop/test2/rtl/fir/fir_low_sim/auk_dspip_roundsat_hpfir.vhd"                   
vcom "C:/Users/lonely/Desktop/test2/rtl/fir/fir_low_sim/dspba_library_package.vhd"                      
vcom "C:/Users/lonely/Desktop/test2/rtl/fir/fir_low_sim/dspba_library.vhd"                              
vcom "C:/Users/lonely/Desktop/test2/rtl/fir/fir_low_sim/fir_low_rtl.vhd"                                
vcom "C:/Users/lonely/Desktop/test2/rtl/fir/fir_low_sim/fir_low_ast.vhd"                                
vcom "C:/Users/lonely/Desktop/test2/rtl/fir/fir_low_sim/fir_low.vhd"                                    
vcom "C:/Users/lonely/Desktop/test2/rtl/fir/fir_low_sim/fir_low_tb.vhd"                                 

vlog -vlog01compat -work work +incdir+C:/Users/lonely/Desktop/test2/rtl/key {C:/Users/lonely/Desktop/test2/rtl/key/Beep.v}

vlog -vlog01compat -work work +incdir+C:/Users/lonely/Desktop/test2/prj/../rtl/key {C:/Users/lonely/Desktop/test2/prj/../rtl/key/Beep_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  Beep_tb

add wave *
view structure
view signals
run -all
