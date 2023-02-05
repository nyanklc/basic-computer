module dpath (
    clock,
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
    AR_out,
    PC_out,
    DR_out,
    AC_out,
    IR_out,
    R_load,
    R_reset,
    R_out
);

wire ZERO = 0;
wire ONE = 1;

// INPUTS
input clock;
// load
input AR_load;
input PC_load;
input DR_load;
input AC_load;
input IR_load;
input TR_load;
input OUTR_load;
// set
input IEN_set;
input IEN_reset;
// reset
input AR_reset;
input PC_reset;
input DR_reset;
input AC_reset;
input TR_reset;
// increment
input AR_inc;
input PC_inc;
input DR_inc;
input AC_inc;
input TR_inc;
// memory, ALU, BUS
input M_write;
input M_read;
input [2:0] ALU_ops;
input [2:0] BUS_sel;

// OUTPUTS
output wire ALU_CO;
output wire ALU_OVF;
output wire ALU_N;
output wire ALU_Z;
output wire IEN_out;
output wire [7:0] OPCODE;
output wire [11:0] IR_addr;
output wire I;
output wire D0;
output wire D1;
output wire D2;
output wire D3;
output wire D4;
output wire D5;
output wire D6;
output wire D7;
output wire B0;
output wire B1;
output wire B2;
output wire B3;
output wire B4;
output wire B5;
output wire B6;
output wire B7;
output wire B8;
output wire B9;
output wire B10;
output wire B11;
output wire DR_ZERO;
assign DR_ZERO = ~(|DR_out);

assign B0 = IR_out[0];
assign B1 = IR_out[1];
assign B2 = IR_out[2];
assign B3 = IR_out[3];
assign B4 = IR_out[4];
assign B5 = IR_out[5];
assign B6 = IR_out[6];
assign B7 = IR_out[7];
assign B8 = IR_out[8];
assign B9 = IR_out[9];
assign B10 = IR_out[10];
assign B11 = IR_out[11];

wire [15:0] ALU_out;
wire E_out;
wire [15:0] BUS_out;
output wire [11:0] AR_out;
output wire [11:0] PC_out;
output wire [15:0] DR_out;
output wire [15:0] AC_out;
output wire [15:0] IR_out;
wire [15:0] TR_out;
wire [15:0] M_out;

input wire R_load, R_reset;
output wire R_out;

opcode_decoder opc_d(IR_out[14:12], D0, D1, D2, D3, D4, D5, D6, D7);
assign I = IR_out[15];
assign IR_addr = IR_out[11:0];

// MODULES
// ALU (E)
regist E(clock, ONE, ZERO, ZERO, ALU_CO, E_out);
defparam E.width = 1;
alu ALU(AC_out, DR_out, E_out, ALU_ops, ALU_out, ALU_CO, ALU_OVF, ALU_N, ALU_Z);

// BUS
multiplex BUS({16'h0000}, {4'b000, AR_out}, {4'b000, PC_out}, DR_out, AC_out, IR_out, TR_out, M_out, BUS_sel, BUS_out);

// M
mem M(clock, M_write, M_read, BUS_out, AR_out, M_out);

// AR
regist AR(clock, AR_load, AR_reset, AR_inc, BUS_out[11:0], AR_out);
defparam AR.width = 12;

// PC
regist PC(clock, PC_load, PC_reset, PC_inc, BUS_out[11:0], PC_out);
defparam PC.width = 12;
defparam PC.load_value = 1000;

// DR
regist DR(clock, DR_load, DR_reset, DR_inc, BUS_out, DR_out);

// AC
regist AC(clock, AC_load, AC_reset, AC_inc, ALU_out, AC_out);

// IR
regist IR(clock, IR_load, ZERO, ZERO, BUS_out, IR_out);

// TR
regist TR(clock, TR_load, TR_reset, TR_inc, BUS_out, TR_out);

// IEN
regist IEN(clock, IEN_set, IEN_reset, ZERO, ONE, IEN_out);
defparam IEN.width = 1;

// R
regist R(clock, R_load, R_reset, ZERO, ONE, R_out);
defparam R.width = 1;
endmodule
