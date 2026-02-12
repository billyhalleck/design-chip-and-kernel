`default_nettype none

module tt_um_mic1_cpu (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    reg [31:0] PC;
    reg [31:0] MAR;

    assign uo_out =
        (PC[1:0] == 2'b00) ? MAR[7:0]   :
        (PC[1:0] == 2'b01) ? MAR[15:8]  :
        (PC[1:0] == 2'b10) ? MAR[23:16] :
                             MAR[31:24];

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    always @(posedge clk) begin
        if (!rst_n) begin
            PC  <= 0;
            MAR <= 0;
        end else if (ena) begin
            PC  <= PC + 1;
            MAR <= MAR + {24'b0, ui_in};
        end
    end

endmodule
