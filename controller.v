module controller (
    clock,
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

parameter bus_none = 0;
parameter bus_ar = 1;
parameter bus_pc = 2;
parameter bus_dr = 3;
parameter bus_ac = 4;
parameter bus_ir = 5;
parameter bus_tr = 6;
parameter bus_m = 7;

input clock;
input ALU_CO;
input ALU_OVF;
input ALU_N;
input ALU_Z;
input IEN_out;
input wire [7:0] OPCODE;
input wire [11:0] IR_addr;
input wire I;
input wire D0;
input wire D1;
input wire D2;
input wire D3;
input wire D4;
input wire D5;
input wire D6;
input wire D7;
input wire B0;
input wire B1;
input wire B2;
input wire B3;
input wire B4;
input wire B5;
input wire B6;
input wire B7;
input wire B8;
input wire B9;
input wire B10;
input wire B11;
input wire FGI;
input wire DR_ZERO;
input wire R_out;

wire SC_reset;
wire [3:0] SC_count;
SC seq(clock, SC_reset, SC_count);

wire T0;
wire T1;
wire T2;
wire T3;
wire T4;
wire T5;
wire T6;

assign T0 = (SC_count == 0) ? 1 : 0;
assign T1 = (SC_count == 1) ? 1 : 0;
assign T2 = (SC_count == 2) ? 1 : 0;
assign T3 = (SC_count == 3) ? 1 : 0;
assign T4 = (SC_count == 4) ? 1 : 0;
assign T5 = (SC_count == 5) ? 1 : 0;
assign T6 = (SC_count == 6) ? 1 : 0;

wire r;
assign r = D7 & (~I) & T3;
wire p;
assign p = D7 & I & T3;

// load
output wire AR_load;
output wire PC_load;
output wire DR_load;
output wire AC_load;
output wire IR_load;
output wire TR_load;
output wire OUTR_load;
// set
output wire IEN_set;
output wire IEN_reset;
// reset
output wire AR_reset;
output wire PC_reset;
output wire DR_reset;
output wire AC_reset;
output wire TR_reset;
// increment
output wire AR_inc;
output wire PC_inc;
output wire DR_inc;
output wire AC_inc;
output wire TR_inc;
// memory, ALU, BUS
output wire M_write;
output wire M_read;
output wire [2:0] ALU_ops;
output wire [2:0] BUS_sel;

output wire R_load;
output wire R_reset;

assign R_load = IEN_out & FGI & (~(T0 | T1 | T2));
assign R_reset = R_out & T2;

wire R;
assign R = R_out;

// HARDWIRED CONTROL
wire x1, x2, x3, x4, x5, x6, x7;
assign x1 = (D4 & T4) | (D5 & T5); // AR
assign x2 = (D5 & T4) | ((~R) & (T0)) | (R & T0); // PC
assign x3 = (D2 & T5) | (D6 & T6); // DR
assign x4 = (D3 & T4); // AC
assign x5 = ~R & T2; // IR
assign x6 = (R & T1); // TR
assign x7 = ((D0 | D1 | D2 | D6) & T4) | ((~R) & (T1)) | ((~D7) & (I) & (T3)); // M
BUS_encoder BUS_enc({x7,x6,x5,x4,x3,x2,x1}, BUS_sel);

assign SC_reset = (R & T2) | ((~R) & (r | (D7 & I & T3) | (D0 & T5) | (D1 & T5) | (D2 & T5) | (D3 & T4) | (D4 & T4) | (D5 & T5) | (D6 & T6)));
assign DR_load = (~R) & ((D0 & T4) | (D1 & T4) | (D2 & T4) | (D6 & T4));
assign DR_inc = (~R) & (D6 & T5);
assign DR_reset = 0;
assign AC_load = (~R) & ((D0 & T5) | (D1 & T5) | (D2 & T5) | (r & B9) | (r & B7) | (r & B6) | (r & B11));
assign AC_inc = (~R) & (r & B5);
assign AC_reset = (~R) & (r & B11);
assign AR_load = ((~R) & (T0)) | ((~R) & (T2)) | ((~D7) & (I) & (T3));
assign AR_reset = R & T0;
assign AR_inc = D5 & T4; 
assign M_read = ((~R) & (T1)) | ((~D7) & I & T3) | ((D0 | D1 | D2 | D6) & (T4));
assign M_write = (R & T1) | (D3 & T4) | (D5 & T4) | (D6 & T6);
assign IEN_set = (p & B7);
assign IEN_reset = (p & B6) | (R & T2);
assign PC_load = (D4 & T4) | (D5 & T5);
assign PC_reset = (R & T1);
assign PC_inc = (R & T2) | ((~R) & (T1)) | (DR_ZERO & D6 & T6) | (ALU_N & r & B3) | (~ALU_N & r & B4) | (ALU_Z & r & B2) | (~ALU_CO & r & B1);
assign IR_load = (~R & T1);
assign TR_load = (R & T0);
assign TR_inc = 0;
assign TR_reset = 0;
assign OUTR_load = ~R & p & B10;
wire [2:0] ALU_ops_1;
BUS_encoder ALU_ops_encoder({'0, r&B6, r&B7, r&B9, D2&T5, D0&T5, D1&T5}, ALU_ops_1);
assign ALU_ops = ALU_ops_1;

endmodule
