module tb_Unicycle_Design;
    logic clk;
    logic [31:0] result;

    Unicycle_Design Unicycle_Design_Test(
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