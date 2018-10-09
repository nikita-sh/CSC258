vlib work
vlog -timescale 1ns/1ns registerALU.v
vsim registerALU

log {/*}
add wave {/*}

force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {SW[9]} 0
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {KEY[0]} 0


# A+1

# A+B

# A+B using verilog

# A XOR B in lower 4 bits, A OR B in higher 4

# A and B reduction OR

# Left shift B by A bits

# Right shift B by A bits

# A X B using Verilog *
