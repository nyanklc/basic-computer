module multiplex #(parameter width = 16)
(
	input0,
	input1,
	input2,
	input3,
	input4,
	input5,
	input6,
	input7,
	selects,
	out
);
input [width-1:0] input0;
input [width-1:0] input1;
input [width-1:0] input2;
input [width-1:0] input3;
input [width-1:0] input4;
input [width-1:0] input5;
input [width-1:0] input6;
input [width-1:0] input7;
input [2:0] selects;
output reg[width-1:0] out;

always @(*) begin
	case(selects)
		3'b000: out=input0;
		3'b001: out=input1;
		3'b010: out=input2;
		3'b011: out=input3;
		3'b100: out=input4;
		3'b101: out=input5;
		3'b110: out=input6;
		3'b111: out=input7;
	endcase
end
endmodule
