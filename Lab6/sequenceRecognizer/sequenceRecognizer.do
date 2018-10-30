vlib work
vlog -timescale 1ns/1ns sequenceRecognizer.v
vsim sequenceRecognizer

log {/*}
add wave {/*}

# SW[0]: reset signal
# SW[1]: input signal
# KEY[0]: clock

# LEDR[2:0]: current state
# LEDR[9]: output

force {KEY[0]} 1 0, 0 5 -r 10
run 5ns
force {SW[0]} 0 0, 1 2
run 5ns

# 4 ones
force {SW[1]} 1
run 50 ns

# zeroes
force {SW[0]} 0
run 10ns

force {SW[0]} 1
run 10ns

force {SW[1]} 0
run 50ns

# 1101
force {SW[0]} 0
force {SW[1]} 0
run 20ns

force {SW[0]} 1
force {SW[1]} 1
run 40ns

force {SW[1]} 0
run 10ns

force {SW[1]} 1 
run 20ns

force {SW[0]} 0
run 20ns


