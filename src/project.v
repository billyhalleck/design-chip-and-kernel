/*
 * Copyright (c) 2024 billy halleck
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_mic1_cpu (
    input  wire [7:0] ui_in,    // Giriş (Dış bellekten gelen veri)
    output wire [7:0] uo_out,   // Çıkış (Bellek adresi veya veri)
    input  wire [7:0] uio_in,   // IO giriş
    output wire [7:0] uio_out,  // IO çıkış
    output wire [7:0] uio_oe,   // IO yön kontrolü (1: çıkış, 0: giriş)
    input  wire       clk,      // Sistem saati
    input  wire       ena,      // Tasarım aktiflik sinyali
    input  wire       rst_n     // Reset (Aktif Düşük)
);

    // --- 1. MIC-1 YAZMAÇLARI ---
    reg [31:0] PC, SP, LV, CPP, TOS, OPC, H;
    reg [31:0] MDR, MAR;
    reg [7:0]  MBR;

    // --- 2. KONTROL ÜNİTESİ ---
    reg [8:0] MPC;
    // Mikro-kodun saklanacağı ROM (Simülasyon için wire tanımlı)
    wire [35:0] micro_instruction = 36'h0; 

    // --- 3. ALU VE DURUM ---
    wire [31:0] alu_out = 32'h0;
    reg N_flag, Z_flag;

    // --- 4. 8-BIT DARBOĞAZI YÖNETİMİ ---
    // MAR (Memory Address Register) değerini PC'nin alt bitlerine göre dışarı veriyoruz
    assign uo_out = (PC[1:0] == 2'b00) ? MAR[7:0]   :
                    (PC[1:0] == 2'b01) ? MAR[15:8]  :
                    (PC[1:0] == 2'b10) ? MAR[23:16] : MAR[31:24];

    // Şimdilik IO'ları ve diğer çıkışları sıfırla
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // --- 5. ANA İŞLEM DÖNGÜSÜ ---
    always @(posedge clk) begin
        if (!rst_n) begin
            MPC <= 9'h0;
            PC  <= 32'h0;
            MAR <= 32'h0; // MAR'ı da resetleyelim
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
            // Burada işlem adımları tanımlanacak
            // Şimdilik boş kalsın, sentez hatası almamak için PC'yi artıralım:
            PC <= PC + 1; 
        end
    end

endmodule
