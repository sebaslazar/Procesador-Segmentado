/*
Configuration = 1280x1024 (60Hz)
Pixel Clock = 108MHz

H Total = 1688 Pixels
H Visible = 1280 Pixels
H Front Porch = 48 Pixels
H Back Porch = 248 Pixels
H sync = 112 Pixels

V Total = 1066 Lines
V Visible = 1024 Lines
V Front Porch = 1 Lines
V Back Porch = 38 Lines
V Sync = 3 Lines
*/

module VGA_module (
    input logic clk,
    input logic [23:0] Pixel,
    output logic [7:0] VGA_red,
    output logic [7:0] VGA_green,
    output logic [7:0] VGA_blue,
    output logic VGA_clk,
    output logic VGA_sync,
    output logic VGA_blank,
    output logic hsync,
    output logic vsync
);
    logic [10:0] H_pos = 11'b0;
    logic [10:0] V_pos = 11'b0;
    
    always @(posedge clk) begin
        if (H_pos < 1688) begin //Recorrido por toda la pantalla
            H_pos <= H_pos + 1;
        end else begin
            H_pos <= 11'b0;
            if (V_pos < 1066) begin
                V_pos <= V_pos + 1;
            end else begin
                V_pos <= 11'b0;
            end
        end

        if ((H_pos > 1327) && (H_pos < 1440)) begin //Sincronización Horizontal (Revisar)
            hsync <= 1'b0;
            VGA_sync <= 1'b0;
        end else begin
            hsync <= 1'b1;
            VGA_sync <= 1'b1;
        end

        if ((V_pos > 1024) && (V_pos < 1028)) begin //Sincronización Vertical (Revisar)
            V_pos <= 1'b0;
            VGA_sync <= 1'b0;
        end else begin
            V_pos <= 1'b1;
            VGA_sync <= 1'b1;
        end

        if (((H_pos > 1279) && (H_pos < 1688)) || ((V_pos > 1023) && (V_pos < 1066))) begin //Desactiva RGB
            VGA_red <= 8'b0;
            VGA_green <= 8'b0;
            VGA_blue <= 8'b0;
            VGA_blank <= 1'b0;
        end else begin
            VGA_red <= Pixel[23:16];
            VGA_green <= Pixel[15:8];
            VGA_blue <= Pixel[7:0];
            VGA_blank <= 1'b1;
        end
    end

    assign VGA_clk = clk; //The CLOCK input of the ADV7123 is typically the pixel clock rate of the system

endmodule