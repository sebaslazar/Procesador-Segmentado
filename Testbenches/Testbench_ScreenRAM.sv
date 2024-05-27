module tb_ScreenRAM;
    logic clk;
    logic [13:0] address;
    logic [7:0] char;

    logic [7:0] scrX;
    logic [5:0] scrY;
    integer pixel_counter;
    integer line_counter;

    Screen_RAM Screen_RAM_Test(
        .clk(clk),
        .address({scrY, scrX}),
        .char(char)
    );
    
    initial
    begin
        clk = 1'b0;
        scrX = 8'b0;
        scrY = -6'b1;
        pixel_counter = 0;
        line_counter = 0;

        $dumpfile("dump.vcd");
        $dumpvars;

        #10560;
        $finish;
    end

    always begin
        #1 clk = ~clk;
    end

    always @(posedge clk) begin
        if (pixel_counter%160 != 0) begin
            if (pixel_counter%8 == 0) begin
                scrX = scrX + 1;
            end
        end else begin
            scrX = 8'b0;
            if (scrY < 6'd63) begin
                if (line_counter%16 == 0) begin
                    scrY = scrY + 1;
                end
            end else begin
                scrY = 6'b0;
            end
            line_counter = line_counter + 1;
        end
        pixel_counter = pixel_counter + 1;
        #1
        $display("Char = %h    Line = %d     Pixel = %d     scrX = %d      scrY = %h", char, line_counter, pixel_counter, scrX, scrY);
    end
endmodule