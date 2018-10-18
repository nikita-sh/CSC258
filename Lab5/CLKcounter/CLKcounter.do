vlib work
vlog -timescale 1ns/1ns CLKcounter.v
vsim CLKcounter

log {/*}
add wave {/*}

force {SW[3]} 0

force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0

force {CLOCK_50} 0 0 , 1 1 -r 2

force {SW[8]} 0
force {SW[2]} 0
run 10ns
force {SW[2]} 1
force {SW[8]} 1

# Full Frequency (50MHz)
force {SW[1]} 0
force {SW[0]} 0
run 50ns
force {SW[2]} 0
run 10ns
force {SW[2]} 1
force {SW[8]} 0
run 10ns

# 1 MHz
force {SW[8]} 1
force {SW[1]} 0
force {SW[0]} 1
run 100ns
force {SW[2]} 0
run 10ns
force {SW[2]} 1
force {SW[8]} 0
run 10ns

# 0.5 MHz
force {SW[8]} 1
force {SW[1]} 1
force {SW[0]} 0
run 150ns
force {SW[2]} 0
run 10ns
force {SW[2]} 1
force {SW[8]} 0
run 10ns

# 0.25 MHz
force {SW[8]} 1
force {SW[1]} 1
force {SW[0]} 1
run 200ns
force {SW[2]} 0
run 10ns
