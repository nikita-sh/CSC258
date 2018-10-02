vlib ALUwork2
vlog -timescale 1ns/1ns alu.v
vsim alu

log {/*}
add wave {/*}

# A + 1
# func
force {KEY[2]} 0
force {KEY[1]} 0
force {KEY[0]} 0

#A
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0

#B
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

run 10ns

#A
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 1

#B
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0

run 10ns

#A
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1

#B
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

run 10ns

# A + B
# func
force {KEY[2]} 0
force {KEY[1]} 0
force {KEY[0]} 1

#A
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0

#B
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

run 10ns

#A
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 1

#B
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0

run 10ns

#A
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1

#B
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

run 10ns
