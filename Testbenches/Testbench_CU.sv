module tb_Control_Unit;
    logic [6:0] OpCode;
    logic [2:0] Funct3;
    logic [6:0] Funct7;
    logic ALUASrc;
    logic ALUBSrc;
    logic [3:0] ALUOp;
    logic [4:0] BrOp;
    logic DMWr;
    logic [2:0] DMCtrl;
    logic RUWr;
    logic [1:0] RUDATAWrSrc;
    logic [2:0] ImmSrc;

    Control_Unit Control_Unit_Test(
        .OpCode(OpCode),
        .Funct3(Funct3),
        .Funct7(Funct7),
        .ALUASrc(ALUASrc),
        .ALUBSrc(ALUBSrc),
        .ALUOp(ALUOp),
        .BrOp(BrOp),
        .DMWr(DMWr),
        .DMCtrl(DMCtrl),
        .RUWr(RUWr),
        .RUDATAWrSrc(RUDATAWrSrc),
        .ImmSrc(ImmSrc)
    );
    
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
        Funct3 = 000;
        Funct7 = 0100000;

        $monitor("OpCode = %b   Funct3 = %b   Funct7 = %b   ALUASrc = %b   ALUBSrc = %b   ALUOp = %b   BrOp = %b   DMWr = %b   DMCtrl = %b   RUWr = %b   RUDATAWrSrc = %b   ImmSrc = %b", OpCode, Funct3, Funct7, ALUASrc,  ALUBSrc, ALUOp, BrOp, DMWr, DMCtrl, RUWr, RUDATAWrSrc, ImmSrc);

        OpCode = 7'b0110011; //Tipo R
        #10
        OpCode = 7'b0010011; //Tipo I
        #10
        OpCode = 7'b0000011; //Tipo I-Lectura
        #10
        OpCode = 7'b1100111; //Tipo I-Salto
        #10
        OpCode = 7'b0100011; //Tipo S
        #10
        OpCode = 7'b1100011; //Tipo B
        #10
        OpCode = 7'b1101111; //Tipo J
        #10
        OpCode = 7'b0110111; //Tipo U-lui
        #10
        OpCode = 7'b0010111; //Tipo U-auipc
        #20;
        $finish;
    end
endmodule