/*
 * Copyright (c) 2024 billy halleck
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_mic1_cpu (
    input  wire [7:0] ui_in,    // Giris (Dis bellekten gelen veri)
    output wire [7:0] uo_out,   // cikis (Bellek adresi veya veri)
    input  wire [7:0] uio_in,   // IO giris
    output wire [7:0] uio_out,  // IO cikis
    output wire [7:0] uio_oe,   // IO yon kontrolu (1: cikis, 0: giris)
    input  wire       clk,      // Sistem saati
    input  wire       ena,      // Tasarim aktiflik sinyali
    input  wire       rst_n     // Reset (Aktif Dusuk)
);

    // --- 1. MIC-1 YAZMACLARI ---
    reg [31:0] PC, SP, LV, CPP, TOS, OPC, H;
    reg [31:0] MDR, MAR;
    reg [7:0]  MBR;

    // --- 2. KONTROL UNITESI ---
    reg [8:0] MPC;
    // Mikro-kodun saklanacagi ROM (Simulasyon icin wire tanimli)
    wire [35:0] micro_instruction = 36'h0; 

    // --- 3. ALU VE DURUM ---
    wire [31:0] alu_out = 32'h0;
    reg N_flag, Z_flag;

    // --- 4. 8-BIT DARBOgazi Yonetimi ---
    // MAR (Memory Address Register) degerini PC'nin alt bitlerine gore disari veriyoruz
    assign uo_out = (PC[1:0] == 2'b00) ? MAR[7:0]   :
                    (PC[1:0] == 2'b01) ? MAR[15:8]  :
                    (PC[1:0] == 2'b10) ? MAR[23:16] : MAR[31:24];

    // simdilik IO'lari ve diger cikislari sifirla 
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // --- 5. ANA ISLEM Dongusu ---
    always @(posedge clk) begin
        if (!rst_n) begin
            MPC <= 9'h0;
            PC  <= 32'h0;
            MAR <= 32'h0; // MAR'i da resetleyelim
            Z_flag <= 0;
            N_flag <= 0;
            SP <= 32'h0;
            LV <= 32'h0;
            CPP <= 32'h0;
            TOS <= 32'h0;
            OPC <= 32'h0;
            H <= 32'h0;
            MDR <= 32'h0;
            MBR <= 8'h0;
        end else if (ena) begin
            PC <= PC + 1;
            MAR <= MAR + {24'h0, ui_in}; // ui_in'i MAR'a ekleyerek sistemi "mesgul" gosteriyoruz
        end

        
    end

endmodule
