vlib work
vlog -timescale 1ns/1ns morseEncoder.v
vsim morseEncoder

log {/*}
add wave {/*}

force {CLOCK_50} 0 0 ns, 1 1 ns -r 2
force {KEY[0]} 0 0 ns, 1 4 ns 
force {KEY[1]} 0 0 ns, 1 8 ns
force {SW[2:0]} 010 0 ns
run 40 ns

force {SW[2:0]} 001

run 40ns

force {SW[2:0]} 010

run 40ns

force {SW[2:0]} 011

run 40ns

force {SW[2:0]} 100

run 40ns

force {SW[2:0]} 101

run 40ns

force {SW[2:0]} 110

run 40ns
