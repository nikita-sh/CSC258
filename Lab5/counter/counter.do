vlib work
vlog -timescale 1ns/1ns counter.v
vsim counter

log {/*}
add wave {/*}

force {KEY[0]} 0 0, 1 10 -r 20
force {SW[0]} 0 

run 20ns

force {SW[1]} 1
force {SW[0]} 1

run 20ns

force {SW[0]} 0

run 10ns

force {SW[0]} 1

run 200ns


