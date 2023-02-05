module alu #(parameter width = 16)(AC, DR, E, operation_select, result, CO, OVF, N, Z);
input [width-1:0] AC;
input [width-1:0] DR;
input E;
input [2:0] operation_select;
output reg[width-1:0] result;
output reg CO;
output reg OVF;
output reg N;
output reg Z;

reg [width:0] temp;

always @(*) begin
  case(operation_select)  
    3'b000: begin // ADD
      temp = AC + DR;
      // OVF
      if (temp >= (1 << width)) begin
        OVF = 1;
      end
      else begin
        OVF = 0;
      end
      // operation
      result = temp[width-1:0];
      // CO
      CO = result[width-1];
      // Z,N
      if (result == 0) begin
        Z = 1;
        N = 0;
      end
      else if (result < 0) begin
        Z = 0;
        N = 1;
      end
      else begin
        Z = 0;
        N = 0;
      end
    end
    3'b001: begin // AND
      temp[width-1:0] = AC & DR;
      // OVF
      OVF = 0;
      // operation
      result = temp[width-1:0];
      // CO
      CO = 0;
      // Z,N
      if (result == 0) begin
        Z = 1;
        N = 0;
      end
      else if (result < 0) begin
        Z = 0;
        N = 1;
      end
      else begin
        Z = 0;
        N = 0;
      end
    end
    3'b010: begin // TRANSFER
      result = DR;
      CO = 0;
      OVF = 0;
      if (result == 0) begin
        Z = 1;
        N = 0;
      end
      else if (result < 0) begin
        Z = 0;
        N = 1;
      end
      else begin
        Z = 0;
        N = 0;
      end
    end
    3'b011: begin // COMPLEMENT
      result = AC^1;
      CO = 0;
      OVF = 0;
      if (result == 0) begin
        Z = 1;
        N = 0;
      end
      else if (result < 0) begin
        Z = 0;
        N = 1;
      end
      else begin
        Z = 0;
        N = 0;
      end
    end
    3'b100: begin // SHR
      result = {E,AC[width-1:1]} >> 1;
      CO = 0;
      OVF = 0;
      if (result == 0) begin
        Z = 1;
        N = 0;
      end
      else if (result < 0) begin
        Z = 0;
        N = 1;
      end
      else begin
        Z = 0;
        N = 0;
      end
    end
    3'b101: begin // SHL
      result = {AC[width-2:0],E} << 1;
      CO = 0;
      OVF = 0;
      if (result == 0) begin
        Z = 1;
        N = 0;
      end
      else if (result < 0) begin
        Z = 0;
        N = 1;
      end
      else begin
        Z = 0;
        N = 0;
      end

    end
    3'b110: begin

    end
    3'b111: begin

    end
    default: begin

    end
  endcase
end
endmodule
