
## ================================================================================
## Legal Notice: Copyright (C) 1991-2009 Altera Corporation
## Any megafunction design, and related net list (encrypted or decrypted),
## support information, device programming or simulation file, and any other
## associated documentation or information provided by Altera or a partner
## under Altera's Megafunction Partnership Program may be used only to
## program PLD devices (but not masked PLD devices) from Altera.  Any other
## use of such megafunction design, net list, support information, device
## programming or simulation file, or any other related documentation or
## information is prohibited for any other purpose, including, but not
## limited to modification, reverse engineering, de-compiling, or use with
## any other silicon devices, unless such use is explicitly licensed under
## a separate agreement with Altera or a megafunction partner.  Title to
## the intellectual property, including patents, copyrights, trademarks,
## trade secrets, or maskworks, embodied in any such megafunction design,
## net list, support information, device programming or simulation file, or
## any other related documentation or information provided by Altera or a
## megafunction partner, remains with Altera, the megafunction partner, or
## their respective licensors.  No other licenses, including any licenses
## needed under any third party's intellectual property, are provided herein.
## ================================================================================
##


transcript on
write transcript fir_low_transcript

# START MEGAWIZARD INSERT VARIABLES
set top_entity fir_low
set timing_resolution "1ps"
set core_version 13.0
set device_family CYCLONEIVE
set quartus_rootdir D:/altera/set_up/quartus/
# Change to "gate_level" for gate-level sim
set sim_type "rtl"
# END MEGAWIZARD INSERT VARIABLES

set q_sim_lib [file join $quartus_rootdir eda sim_lib]

# Close existing ModelSim simulation
quit -sim

if {[file exists [file join simulation modelsim ${top_entity}.vo]] && [string match "gate_level" $sim_type]} {
    puts "Info: Gate Level ${top_entity}.vo found"
    set language_ext "vo"
    set use_ipfs 1
    set flow "gate_level"
} elseif {[file exists [file join simulation modelsim ${top_entity}.vho]] && [string match "gate_level" $sim_type]} {
    puts "Info: Gate Level ${top_entity}.vho found"
    set language_ext "vho"
    set use_ipfs 1
    set flow "gate_level"
} else {
    puts "Info: RTL simulation."
    set use_ipfs 0
    set flow "rtl"
}

if {[string match $flow "gate_level"] } {
    file copy ${top_entity}_input.txt simulation/modelsim
    cd simulation/modelsim
}

regsub {[ ]+} $device_family "" temp_device_family
regsub {[ ]+} $temp_device_family "" temp_device_family2
set device_lib_name [string tolower $temp_device_family2]

set libs [list \
    $device_lib_name \
    altera \
    work]

foreach {lib} $libs {
    if {[file exist $lib]} {
        catch {eval "file delete -force -- $lib"} fid
        puts "file delete command returned $fid\n"
    }
    if {[file exist $lib] == 0} 	{
        vlib $lib
        vmap $lib $lib
    }
}

# RTL Simulation

if {[string match $flow "rtl"] } {

    # Compile all required simulation library files
    set quartus_libs [list \
        altera_mf   {altera_mf_components altera_mf}   {altera_mf} "$q_sim_lib" \
        lpm         {220pack 220model}                 {220model}  "$q_sim_lib" \
        sgate       {sgate_pack sgate}                 {sgate}     "$q_sim_lib" ]

	foreach {lib file_vhdl_list file_verilog_list src_files_loc} $quartus_libs {
        if {[file exist $lib]} {
            catch {eval "file delete -force -- $lib"} fid
            puts "file delete command returned $fid\n"
        }
        if {[file exist $lib] == 0} 	{
            vlib $lib
            vmap $lib $lib
        }
		foreach file_item $file_vhdl_list {
		  catch {vcom -explicit -93 -work $lib [file join $src_files_loc ${file_item}.vhd]} err_msg
		  if {![string match "" $err_msg]} {return $err_msg}
		}
	}

	vcom -93 -work altera $q_sim_lib/altera_primitives_components.vhd
	vcom -93 -work altera $q_sim_lib/altera_primitives.vhd

    # Compile all FIR Compiler II RTL files
    vlog -work work altera_avalon_sc_fifo.v
    vcom -93 -work work auk_dspip_math_pkg_hpfir.vhd
    vcom -93 -work work auk_dspip_lib_pkg_hpfir.vhd
    vcom -93 -work work auk_dspip_roundsat_hpfir.vhd
    vcom -93 -work work auk_dspip_avalon_streaming_source_hpfir.vhd
    vcom -93 -work work auk_dspip_avalon_streaming_sink_hpfir.vhd
    vcom -93 -work work auk_dspip_avalon_streaming_controller_hpfir.vhd
    vcom -93 -work work dspba_library_package.vhd
    vcom -93 -work work dspba_library.vhd

    if {[file exists fir_low.vhd]} {vcom -93 -work work fir_low.vhd}
    if {[file exists fir_low.v]} {vlog -work work fir_low.v}
    vcom -93 -work work fir_low_ast.vhd
    vcom -93 -work work fir_low_rtl.vhd

    vcom -93 -work work ${top_entity}_tb.vhd

} else {

# Gate Level Simulation

    # Compile all required simulation library files and the simulation netlist file
    # If the following automatic mapping doesn't work, modify the code below to match the device chosen
    if {[string match $language_ext "vho"]} {
        vcom -93 -work altera $q_sim_lib/altera_primitives_components.vhd
	    vcom -93 -work altera $q_sim_lib/altera_primitives.vhd
 	    vcom -93 -work $device_lib_name [file join $q_sim_lib ${device_lib_name}_atoms.vhd]
		vcom -93 -work $device_lib_name [file join $q_sim_lib ${device_lib_name}_components.vhd]
        vcom -93 -work work ${top_entity}.vho
    } else {
	    vlog -work altera $q_sim_lib/altera_primitives.v
		vlog -work $device_lib_name [file join $q_sim_lib ${device_lib_name}_atoms.v]
	    vlog -work work ${top_entity}.vo
    }

    vcom -93 -work work ../../${top_entity}_tb.vhd
}

# Prepare simulation command

set vsim_cmd vsim

if {[string match $flow "rtl"]} {
    lappend vsim_cmd "-L" "$device_lib_name" "-L" "altera_mf" "-L" "lpm" "-L" "Sgate" "-L" "altera" "-L" "work"
} else {
    lappend vsim_cmd "-L" "$device_lib_name" "-L" "altera" "-L" "work"
    if {[string match $language_ext "vho"]} {
	    if {[file exists ${top_entity}_vhd.sdo]} {
	        lappend vsim_cmd "-sdftyp" "/${top_entity}_tb/DUT=${top_entity}_vhd.sdo"}
    }
    if {[string match $language_ext "vo"]} {
	    if {[file exists ${top_entity}_v.sdo]} {
	        lappend vsim_cmd "-sdftyp" "/${top_entity}_tb/DUT=${top_entity}_v.sdo"}
    }
}

lappend vsim_cmd "work.${top_entity}_tb" "-t" "$timing_resolution"

catch {	eval $vsim_cmd } vsim_msg
puts $vsim_msg

if {[file exists "wave.do"]} {
    do wave.do
} else {
    add wave sim:/${top_entity}_tb/*
}

# Start simulation silently

set StdArithNoWarnings 1
run 0 ns
set StdArithNoWarnings 0
catch {run -all} run_msg
puts $run_msg