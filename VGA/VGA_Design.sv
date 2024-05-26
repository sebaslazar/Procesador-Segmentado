`include "CharPos_Module.sv"
`include "Font_ROM.sv"
`include "Screen_RAM.sv"
`include "Sync_Module.sv"
`include "Text_Module.sv"

module VGA_Module (
    input logic clk,
    input logic [23:0] background_color,
    input logic [23:0] font_color,
    output logic [7:0] R_out,
    output logic [7:0] G_out,
    output logic [7:0] B_out,
    output logic VGA_clk,
    output logic VGA_sync,
    output logic VGA_blank,
    output logic Hsync,
    output logic Vsync
);
    logic horizontal_sync;
    logic vertical_sync;
    logic [10:0] Horizontal;
    logic [10:0] Vertical;
    logic blank;
    logic [7:0] screenX;
    logic [6:0] screenY;
    logic [2:0] characterX;
    logic [3:0] characterY;
    logic [7:0] character;
    logic [7:0] row_character;
    logic [11:0] char_address;

    Sync Sync_Module(
        .clk(clk),
        .VGA_sync(VGA_sync),
        .VGA_blank(blank),
        .hsync(horizontal_sync),
        .vsync(vertical_sync)
        .H(Horizontal),
        .V(Vertical)
    );

    CharPos CharPos_Module (
        .H(Horizontal),
        .V(Vertical),
        .scrX(screenX),
        .srcY(screenY),
        .charX(characterX),
        .charY(characterY),
    );

    ScreenRAM Screen_RAM (
        .clk(clk),
        .address({screenY, screenX}),
        .char(character)
    );

    TextMode Text_Module (
        .clk(clk),
        .hsync(horizontal_sync),
        .vsync(vertical_sync),
        .caracter(character),
        .columna(characterX),
        .fila(characterY),
        .VGA_blank(blank),
        .background_color(24'h000000),
        .font_color(24'hFFFFFF),
        .caracter_fila(row_character),
        .R_out(R_out),
        .G_out(G_out),
        .B_out(B_out),
        .hsync_out(Hsync),
        .vsync_out(Vsync),
        .address(char_address)
    );

    FontROM Font_ROM (
        .clk(clk),
        .address(char_address),
        .data(row_character)
    );

    assign VGA_clk = clk;
    assign VGA_blank = blank;

endmodule