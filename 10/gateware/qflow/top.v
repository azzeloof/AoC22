
module top (
    input CLK,    // 16MHz clock
    input [16:0] data_in,
    output [11:0] pc,
    output en,
    output LED,
    output [15:0] data_out
);

    reg[11:0] pc = 0;
    wire[16:0] data_in;
    reg en = 1'b1;
    
    wire[15:0] data_out;

    wire op;
    wire[15:0] arg;

    assign op = data_in[16];
    assign arg = data_in[15:0];

    reg[15:0] x = 1;
    reg[15:0] sig = 0;

    assign LED = op;
    assign data_out = sig;

    always @(posedge CLK) begin
        if (en) begin
            pc = pc + 1;
            if (op == 1)
                x <= x + arg;
            if (pc == 21)
                sig <= sig + x*20;
            else if (pc == 61)
                sig <= sig + x*60;
            else if (pc == 101)
                sig <= sig + x*100;
            else if (pc == 141)
                sig <= sig + x*140;
            else if (pc == 181)
                sig <= sig + x*180;
            else if (pc == 221)
                sig <= sig + x*220;
            else if (pc > 230)
                en = 0;
        end else begin
        end
    end
endmodule
