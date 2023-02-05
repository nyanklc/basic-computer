module mem (clock, write, read, data, address, out);
input clock;
input write;
input read;
input [15:0] data;
input [11:0] address;
output reg[15:0] out;

reg[15:0] regs[0:4095];

initial begin
  $readmemh("memory_initial.mem", regs);
  $display("memory read");
end
  
always @(read) begin
  if (read == 1) begin
    out = regs[address]; 
  end
end

always @(posedge clock) begin
  if (write == 1) begin
    regs[address] <= data;
  end
end
endmodule
