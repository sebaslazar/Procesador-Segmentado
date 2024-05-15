module tb_Instruction_Memory;
    logic [31:0] address;
    logic [31:0] instruction;
    logic [2:0] delay;
    integer i;

    Instruction_Memory Instruction_Memory_Test(
        .address(address),
        .instruction(instruction)
    );
    
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;

        for(i=0; i<200; i=i+4) begin
            address = i;
            #10
            $display("Input = %h   Output = %h", address, instruction);
        end
        #20;
        $finish;
    end
endmodule