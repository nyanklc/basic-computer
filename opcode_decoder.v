module opcode_decoder (inps, d0, d1, d2, d3, d4, d5, d6, d7);
    input [2:0] inps;
    output wire d0;
    output wire d1;
    output wire d2;
    output wire d3;
    output wire d4;
    output wire d5;
    output wire d6;
    output wire d7;

    reg [7:0] d;

    assign d0 = d[0];
    assign d1 = d[1];
    assign d2 = d[2];
    assign d3 = d[3];
    assign d4 = d[4];
    assign d5 = d[5];
    assign d6 = d[6];
    assign d7 = d[7];

    always @(inps) begin
        case (inps)
            0: begin
                d = 8'b00000001;
            end
            1: begin
                d = 8'b00000010;
            end
            2: begin
                d = 8'b00000100;
            end
            3: begin
                d = 8'b00001000;
            end
            4: begin
                d = 8'b00010000;
            end
            5: begin
                d = 8'b00100000;
            end
            6: begin
                d = 8'b01000000;
            end
            7: begin
                d = 8'b10000000;
            end
        endcase
    end
endmodule