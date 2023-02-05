module BUS_encoder (x_inps, outs);

    input wire [6:0] x_inps;
    output reg [2:0] outs;

    always @(x_inps) begin
        if(x_inps[6]==1) outs=3'b111; // M
        else if(x_inps[5]==1) outs=3'b110; // TR
        else if(x_inps[4]==1) outs=3'b101; // IR
        else if(x_inps[3]==1) outs=3'b100; // AC
        else if(x_inps[2]==1) outs=3'b011; // DR
        else if(x_inps[1]==1) outs=3'b010; // PC
        else if(x_inps[0]==1) outs=3'b001;  // AR
    end
endmodule