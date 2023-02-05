//Don't change the module I/O
module BC_I (
input clk,
input FGI,
output [11:0] PC,
output [11:0] AR,
output [15:0] IR,
output [15:0] AC,
output [15:0] DR
);

// Instantiate your datapath and controller here, then connect them.

wire AR_load;
wire PC_load;
wire DR_load;
wire AC_load;
wire IR_load;
wire TR_load;
wire OUTR_load;
wire IEN_set;
wire IEN_reset;
wire AR_reset;
wire PC_reset;
wire DR_reset;
wire AC_reset;
wire TR_reset;
wire AR_inc;
wire PC_inc;
wire DR_inc;
wire AC_inc;
wire TR_inc;
wire M_write;
wire M_read;
wire [2:0] ALU_ops;
wire [2:0] BUS_sel;
wire ALU_CO;
wire ALU_OVF;
wire ALU_N;
wire ALU_Z;
wire IEN_out;
wire [7:0] OPCODE;
wire [11:0] IR_addr;
wire I;
wire D0;
wire D1;
wire D2;
wire D3;
wire D4;
wire D5;
wire D6;
wire D7;
wire B0;
wire B1;
wire B2;
wire B3;
wire B4;
wire B5;
wire B6;
wire B7;
wire B8;
wire B9;
wire B10;
wire B11;
wire DR_ZERO;
wire R_load;
wire R_reset;
wire R_out;

dpath DATAPATH(
    clk,
    AR_load,
    PC_load,
    DR_load,
    AC_load,
    IR_load,
    TR_load,
    OUTR_load,
    IEN_set,
    IEN_reset,
    AR_reset,
    PC_reset,
    DR_reset,
    AC_reset,
    TR_reset,
    AR_inc,
    PC_inc,
    DR_inc,
    AC_inc,
    TR_inc,
    M_write,
    M_read,
    ALU_ops,
    BUS_sel,
    ALU_CO,
    ALU_OVF,
    ALU_N,
    ALU_Z,
    IEN_out,
    OPCODE,
    IR_addr,
    I,
    D0,
    D1,
    D2,
    D3,
    D4,
    D5,
    D6,
    D7,
    B0,
    B1,
    B2,
    B3,
    B4,
    B5,
    B6,
    B7,
    B8,
    B9,
    B10,
    B11,
    DR_ZERO,
    AR,
    PC,
    DR,
    AC,
    IR,
    R_load,
    R_reset,
    R_out
);

controller CONTROLLER(
    clk,
    ALU_CO,
    ALU_OVF,
    ALU_N,
    ALU_Z,
    IEN_out,
    OPCODE,
    IR_addr,
    D0,
    D1,
    D2,
    D3,
    D4,
    D5,
    D6,
    D7,
    B0,
    B1,
    B2,
    B3,
    B4,
    B5,
    B6,
    B7,
    B8,
    B9,
    B10,
    B11,
    FGI,
    DR_ZERO,
    R_out,
    AR_load,
    PC_load,
    DR_load,
    AC_load,
    IR_load,
    TR_load,
    OUTR_load,
    IEN_set,
    IEN_reset,
    AR_reset,
    PC_reset,
    DR_reset,
    AC_reset,
    TR_reset,
    AR_inc,
    PC_inc,
    DR_inc,
    AC_inc,
    TR_inc,
    M_write,
    M_read,
    ALU_ops,
    BUS_sel,
    R_load,
    R_reset
);

initial begin
    $display("BC_I ready");
    $finish();
end
endmodule