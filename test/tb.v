`default_nettype none
`timescale 1ns / 1ps

module tb ();

  initial begin
    $dumpfile("tb.fst");
    $dumpvars(0, tb);
    #1;
  end

  reg clk = 0;
  reg rst_n = 0;

  reg  [7:0] ui;
  wire [7:0] uo;
  wire [7:0] uio;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Clock üret
  always #5 clk = ~clk;

  // DUT
  tt_um_mic1_cpu user_project (
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif
      .ui   (ui),
      .uo   (uo),
      .uio  (uio),
      .clk  (clk),
      .rst_n(rst_n)
  );

endmodule
