module tb_PC;
    logic clk;
    logic [31:0] PC_Input;
    logic [31:0] PC_Output;
    integer i;

    PC PC_Test(
        .clk(clk),
        .PC_Input(PC_Input),
        .PC_Output(PC_Output)
    );

    always #10 begin
        clk = ~clk;
    end
    
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;

        $display("Prueba de Flip Flop");
        clk = 0;

        

        for(i=0; i<10; i=i+1) begin
            PC_Input <= i;
            #4
            $display("clk = %b   Input = %h   Output = %h", clk, PC_Input, PC_Output);
        end
        #20;
        $finish;
    end
endmodule