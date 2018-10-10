vlib work
vlog -timescale 1ns/1ns shifter.v
vsim shifter

log {/*}
add wave {/*}

# case question 1
force {SW[9]} 1
force {KEY[0]} 0 0, 1 20 -r 40
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

run 40ns
