# Set the working dir, where all compiled Verilog goes.
vlib work2

# Compile all Verilog modules in mux7to1.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog
vlog -timescale 1ns/1ns rippleCarryTest.v

# Load simulation using mux7to1 as the top level simulation module.
vsim rippleCarryTest

log {/*}
add wave {/*}

force {SW[8]} 0

force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0 
force {SW[4]} 0

force {SW[3]} 0 
force {SW[3]} 0
force {SW[2]} 0 
force {SW[1]} 0
run 10

force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1 
force {SW[4]} 1

force {SW[3]} 0 
force {SW[2]} 1
force {SW[1]} 0 
force {SW[0]} 1
run 10
