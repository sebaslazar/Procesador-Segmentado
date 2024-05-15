module tb_Imm_Gen;
    logic [24:0] Inst;
    logic [2:0] ImmSrc;
    logic [31:0] ImmExt;
    integer i;

    Imm_Gen Imm_Gen_Test(
        .Inst(Inst),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );
    
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;

        ImmSrc = 3'b000;
        Inst = 25'b0000000111100000000001010;
        #10
        $display("Inst = %h   ImmSrc = %b   ImmExt = %h", Inst, ImmSrc, ImmExt);

        ImmSrc = 3'b001;
        Inst = 25'b0000000100100001001001000;
        #10
        $display("Inst = %h   ImmSrc = %b   ImmExt = %h", Inst, ImmSrc, ImmExt);

        ImmSrc = 3'b101;
        Inst = 25'b1111111000000000010110101;
        #10
        $display("Inst = %h   ImmSrc = %b   ImmExt = %h", Inst, ImmSrc, ImmExt);

        ImmSrc = 3'b010;
        Inst = 25'b0000001100000011100100001;
        #10
        $display("Inst = %h   ImmSrc = %b   ImmExt = %h", Inst, ImmSrc, ImmExt);

        ImmSrc = 3'b110;
        Inst = 25'b0000010010000000000000001;
        #10
        $display("Inst = %h   ImmSrc = %b   ImmExt = %h", Inst, ImmSrc, ImmExt);

        #20;
        $finish;
    end
endmodule