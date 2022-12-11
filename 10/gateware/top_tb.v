`timescale 1ns/1ps
module tb ();
  initial begin
    $dumpfile("top_tb.vcd");
    $dumpvars(0, t);
  end

  reg clk;
  wire usbpu;

  initial begin
		clk = 1'b0;
	end

  always begin
    #31 clk = !clk;
  end

  initial begin
    repeat(1600) @(posedge clk);

      $finish;
  end

  top t (
    .CLK(clk),
    .LED(),
    .PIN_4(),
    .PIN_5(),
    .PIN_6(),
    .PIN_7(),
    .PIN_8(),
    .PIN_9(),
    .PIN_10(),
    .PIN_11(),
    .PIN_12(),
    .PIN_13(),
    .PIN_14(),
    .PIN_15(),
    .PIN_16(),
    .PIN_17(),
    .PIN_18(),
    .PIN_19(),
    .USBPU(usbpu)
  );



endmodule // tb