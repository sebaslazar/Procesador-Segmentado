module Text_Module (
    input logic clk,
    input logic hsync,
    input logic vsync,
    input logic [7:0] caracter,
    input logic [2:0] columna,
    input logic [3:0] fila,
    input logic VGA_blank,
    input logic [23:0] background_color,
    input logic [23:0] font_color,
    input logic [7:0] caracter_fila,
    output logic [7:0] R_out,
    output logic [7:0] G_out,
    output logic [7:0] B_out,
    output logic hsync_out,
    output logic vsync_out,
    output logic address
);
    logic hsync_save;
    logic vsync_save;
    logic [23:0] font_color_save;
    logic [23:0] background_color_save;
    logic VGA_view_save;
    logic columna_save;
    logic [1:0] pixel;

    initial begin
        hsync_save = 1'b0;
        vsync_save = 1'b0;
        font_color_save = 24'b0;
        background_color_save = 24'b0;
        VGA_view_save = 1'b0;
        columna_save = 1'b0;
        pixel = 2'b0;
        caracter_fila = 8'b0;
    end

    always @(posedge clk) begin
        hsync_out <= hsync_save
        vsync_out <= vsync_save;
        hsync_save <= hsync;
        vsync_save <= vsync;

        font_color_save <= font_color;
        background_color_save <= background_color;

        VGA_view_save <= ~VGA_blank;

        columna_save <= columna;

        pixel <= {VGA_view_save, caracter_fila[columna_save]};

        if (pixel == 2'b00 || pixel == 2'b01) begin
            R_out <= 8'b0;
            G_out <= 8'b0;
            B_out <= 8'b0;
        end else if(pixel == 2'b10) begin
            R_out <= font_color_save[23:16];
            G_out <= font_color_save[15:7];
            B_out <= font_color_save[7:0];
        end else if (pixel == 2'b11) begin
            R_out <= background_color_save[23:16];
            G_out <= background_color_save[15:7];
            B_out <= background_color_save[7:0];
        end

        address <= {fila, caracter};
    end

endmodule