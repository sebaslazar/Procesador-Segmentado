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

module Sync_Module (
    input logic clk,
    output logic VGA_sync,
    output logic VGA_blank,
    output logic hsync,
    output logic vsync,
    output logic [10:0] H,
    output logic [10:0] V
);
    logic [10:0] H_pos;
    logic [10:0] V_pos;

    initial begin
        H_pos = 11'b0;
        V_pos = 11'b0;
    end
    
    always @(posedge clk) begin
        if (H_pos < 1688) begin //Recorrido por toda la pantalla
            H_pos <= H_pos + 1'b1;
        end else begin
            H_pos <= 11'b0;
            if (V_pos < 1066) begin
                V_pos <= V_pos + 1'b1;
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
            vsync <= 1'b0;
            VGA_sync <= 1'b0;
        end else begin
            vsync <= 1'b1;
            VGA_sync <= 1'b1;
        end

        if (((H_pos > 1279) && (H_pos < 1688)) || ((V_pos > 1023) && (V_pos < 1066))) begin //Desactiva RGB
            VGA_blank <= 1'b0;
        end else begin
            VGA_blank <= 1'b1;
        end
    end

    assign H = H_pos;
    assign V = V_pos;

endmodule