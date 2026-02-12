/*
 * Copyright (c) 2024 billy halleck
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_mic1_cpu (
    input  wire [7:0] ui,      // input pins
    output wire [7:0] uo,      // output pins
    inout  wire [7:0] uio,     // bidirectional pins
    input  wire       clk,     // clock
    input  wire       rst_n    // reset (active low)
);

    // IO yön kontrolü
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    assign uio = uio_oe ? uio_out : 8'bz;

    // --- MIC-1 registerleri ---
    reg [31:0] PC, MAR;

    // Output: MAR'ın byte'larını sırayla dışarı ver
    assign uo = (PC[1:0] == 2'b00) ? MAR[7:0]   :
                (PC[1:0] == 2'b01) ? MAR[15:8]  :
                (PC[1:0] == 2'b10) ? MAR[23:16] : MAR[31:24];

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    always @(posedge clk) begin
        if (!rst_n) begin
            PC  <= 32'h0;
            MAR <= 32'h0;
        end else begin
            PC  <= PC + 1;
            MAR <= MAR + {24'h0, ui};
        end
    end

endmodule
