module regist #(parameter width = 16, parameter load_value = 0)(clock, load, reset, increment, DATA, A);
input clock;
input load;
input reset;
input increment;
input [width-1:0] DATA;
output reg[width-1:0] A;

initial begin
  A = load_value;
end

always @(posedge clock) begin
  if (reset == 1) begin
    A <= 0;
  end
  else begin
    if (load == 1) begin
      A <= DATA;
    end
    else begin
      if (increment == 1) begin
        A <= A + 1;
      end
      else begin
        A <= A;
      end
    end
  end
end
endmodule
