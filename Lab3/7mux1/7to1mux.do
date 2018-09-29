# Set the working dir, where all compiled Verilog goes.
vlib 7to1muxWork

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns 7to1mux.v

# Load simulation using mux as the top level simulation module.
vsim 7to1mux

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*} 
