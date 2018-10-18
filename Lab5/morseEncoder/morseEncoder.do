vlib work
vlog -timescale 1ns/1ns morseEncoder.v
vsim morseEncoder

log {/*}
add wave {/*}

force {SW[2:0]} 000

force {CLOCK_50} 0 0 ns, 1 10 ns -r 20
force {KEY[0]} 0  
force {KEY[1]} 0
run 10ns
force {KEY[0]} 1
run 10ns
force {KEY[1:0]} 01
force {SW[2:0]} 010 0 ns
run 100 ns

force {SW[2:0]} 001

run 100ns

force {SW[2:0]} 010

run 100ns

force {SW[2:0]} 011

run 100ns

force {SW[2:0]} 100

run 100ns

force {SW[2:0]} 101

run 100ns

force {SW[2:0]} 110

run 100ns
