# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns mux7to1.v

# Load simulation using mux as the top level simulation module.
vsim mux7to1

log {/*}
add wave {/*}

force {SW[9]} 0 0ns, 1 5120ns
force {SW[8]} 0 0ns, 1 2560ns -r 5120 
force {SW[7]} 0 0ns, 1 1280ns -r 2560
force {SW[6]} 0 0ns, 1 640ns -r 1280
force {SW[5]} 0 0ns, 1 320ns -r 640
force {SW[4]} 0 0ns, 1 160ns -r 320
force {SW[3]} 0 0ns, 1 80ns -r 160 
force {SW[2]} 0 0ns, 1 40ns -r 80 
force {SW[1]} 0 0ns, 1 20ns -r 40
force {SW[0]} 0 0ns, 1 10ns  -r 20

run 10240
