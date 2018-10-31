vlib work
vlog -timescale 1ns/1ns datapathFSM.v
vsim datapathFSM

log {/*}
add wave {/*}

# SW[7:0] data_in

# KEY[0] synchronous reset when pressed
# KEY[1] go signal

# LEDR displays result
# HEX0 & HEX1 also displays result

force {CLOCK_50} 0 0, 1 5 -r 10
run 10ns

force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns

force {KEY[0]} 1
#Loading A
force {SW[7:0]} 00001001
force {KEY[1]} 1
run 20ns
force {KEY[1]} 0
run 20ns

#Loading B
force {SW[7:0]} 00010001
force {KEY[1]} 1
run 20ns
force {KEY[1]} 0
run 20ns

#Loading C
force {SW[7:0]} 01001001
force {KEY[1]} 1
run 20ns
force {KEY[1]} 0
run 20ns

#Loading X
force {SW[7:0]} 01000001
force {KEY[1]} 1
run 20ns
force {KEY[1]} 0
run 50ns
