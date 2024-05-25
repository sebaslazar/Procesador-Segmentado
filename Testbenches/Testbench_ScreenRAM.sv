module tb_ScreenRAM;
    logic clk;
    logic [7:0] scrX;
    logic [6:0] scrY;
    logic selector;
    logic [7:0] caracter;

    Screen_RAM Screen_RAM_Test(
        .clk(clk),
        .scrX(scrX),
        .scrY(scrY),
        .selector(selector),
        .caracter(caracter)
    );
    
    initial
    begin
        clk = 1'b0;
        scrX = 8'b0;
        scrY = 7'b0;
        selector = 1'b1;

        $dumpfile("dump.vcd");
        $dumpvars;

        #500;
        $finish;
    end

    always begin
        #1 clk = ~clk;
    end

    always @(posedge clk) begin
        if (scrX <= 8'd159) begin
            scrX = scrX + 1;
        end else begin
            scrX = 8'b0;
            scrY = scrY + 1;
        end
        #1
        $display("caracter = %h", caracter);
    end
endmodule