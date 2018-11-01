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

force {CLOCK_50} 0 0, 1 1 -r 2
run 10ns

force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns

# 4(2)^2 + 2(2) + 5 = 25

force {KEY[0]} 1
#Loading A = 4
force {SW[7:0]} 00000100
force {KEY[1]} 0
run 20ns
force {KEY[1]} 1
run 20ns

#Loading B = 2
force {SW[7:0]} 00000010
force {KEY[1]} 0
run 20ns
force {KEY[1]} 1
run 20ns

#Loading C = 5
force {SW[7:0]} 00000101
force {KEY[1]} 0
run 20ns
force {KEY[1]} 1
run 20ns

#Loading X = 2
force {SW[7:0]} 00000010
force {KEY[1]} 0
run 20ns
force {KEY[1]} 1
run 50ns

force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns

# 4(1)^2 + 2(1) + 5 = 11

force {KEY[0]} 1
#Loading A = 4
force {SW[7:0]} 00000100
force {KEY[1]} 0
run 20ns
force {KEY[1]} 1
run 20ns

#Loading B = 2
force {SW[7:0]} 00000010
force {KEY[1]} 0
run 20ns
force {KEY[1]} 1
run 20ns

#Loading C = 5
force {SW[7:0]} 00000101
force {KEY[1]} 0
run 20ns
force {KEY[1]} 1
run 20ns

#Loading X = 1
force {SW[7:0]} 00000001
force {KEY[1]} 0
run 20ns
force {KEY[1]} 1
run 50ns

force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns

# 1(2)^2 + 1(2) + 1 = 7

force {KEY[0]} 1
#Loading A = 1
force {SW[7:0]} 00000001
force {KEY[1]} 0
run 20ns
force {KEY[1]} 1
run 20ns

#Loading B = 1
force {SW[7:0]} 00000001
force {KEY[1]} 0
run 20ns
force {KEY[1]} 1
run 20ns

#Loading C = 1
force {SW[7:0]} 00000001
force {KEY[1]} 0
run 20ns
force {KEY[1]} 1
run 20ns

#Loading X = 2
force {SW[7:0]} 00000010
force {KEY[1]} 0
run 20ns
force {KEY[1]} 1
run 50ns


