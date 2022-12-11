// look in pins.pcf for all the pin names on the TinyFPGA BX board
module top (
    input CLK,    // 16MHz clock
    output LED,
    output PIN_4,
    output PIN_5,
    output PIN_6,
    output PIN_7,
    output PIN_8,
    output PIN_9,
    output PIN_10,
    output PIN_11,
    output PIN_12,
    output PIN_13,
    output PIN_14,
    output PIN_15,
    output PIN_16,
    output PIN_17,
    output PIN_18,
    output PIN_19,
    output USBPU  // USB pull-up resistor
);
    // drive USB pull-up resistor to '0' to disable USB
    assign USBPU = 0;

    reg[31:0] pc = 0;
    wire[16:0] data;
    reg en = 1'b1;
    
    reg[15:0] out;

    wire op;
    wire[15:0] arg;

    assign op = data[16];
    assign arg = data[15:0];

    reg[15:0] x = 1;
    reg[15:0] sig = 0;

    assign LED = op;
    assign {PIN_19, PIN_18, PIN_17, PIN_16, PIN_15, PIN_14, PIN_13, PIN_12, PIN_11, PIN_10, PIN_9, PIN_8, PIN_7, PIN_6, PIN_5, PIN_4} = sig;

    rom ROM (
        .address(pc), 
        .data(data),
        .en(en)        
    );


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
