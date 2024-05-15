module tb_Segmented_Design;
    logic clk;
    logic [31:0] result;

    Segmented_Design Segmented_Design_Test(
        .clk(clk),
        .result(result)
    );
    
    always
    begin
        #5 clk = ~clk;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;

        $monitor("Result = %h", result);

        clk = 0;

        #100000;
        $finish;
    end
endmodule