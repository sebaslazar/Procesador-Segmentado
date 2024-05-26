module tb_ScreenRAM;
    logic clk;
    logic [13:0] address;
    logic [7:0] char;

    logic [7:0] scrX;
    logic [5:0] scrY;
    integer char_counter;
    integer line_counter;

    Screen_RAM Screen_RAM_Test(
        .clk(clk),
        .address({scrY, scrX}),
        .char(char)
    );
    
    initial
    begin
        clk = 1'b0;
        scrX = -8'b1;
        scrY = -6'b1;
        char_counter = 0;
        line_counter = 0;

        $dumpfile("dump.vcd");
        $dumpvars;

        #643;
        $finish;
    end

    always begin
        #1 clk = ~clk;
    end

    always @(posedge clk) begin
        if (scrX < 8'd159) begin
            scrX = scrX + 1;
        end else begin
            scrX = 8'b0;
            if (scrY < 64) begin
                scrY = scrY + 1;
                line_counter = line_counter + 1;
            end else begin
                scrY = 6'b0;
            end
        end
        char_counter = char_counter + 1;
        #1
        $display("char = %h    Line = %d     Char = %d     scrX = %d      scrY = %h", char, line_counter, char_counter, scrX, scrY);
    end
endmodule