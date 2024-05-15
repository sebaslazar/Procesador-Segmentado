`include "ALU.sv"
`include "Branch_Unit.sv"
`include "Control_Unit.sv"
`include "Data_Memory.sv"
`include "Imm_Gen.sv"
`include "Instruction_Memory.sv"
`include "PC.sv"
`include "Register_Unit.sv"
`include "Forwarding_Unit.sv"
`include "Hazard_Detection_Unit.sv"

module Segmented_Design (
    input logic clk,
    output logic [31:0] result //Sólo sirve para el Testbench
);
    //ALU
    logic signed [31:0] A; 
    logic signed [31:0] B;
    logic signed [31:0] ALURes;

    //Branch_Unit
    logic NextPCSrc;

    //Control_Unit
    logic ALUASrc;
    logic ALUBSrc;
    logic [3:0] ALUOp;
    logic [4:0] BrOp;
    logic DMWr;
    logic [2:0] DMCtrl;
    logic RUWr;
    logic [1:0] RUDATAWrSrc;
    logic [2:0] ImmSrc;
    logic DMRd_ex;

    //Data_Memory
    logic [31:0] DataRd;

    //Imm_Gen
    logic [31:0] ImmExt;

    //Instruction_Memory
    logic [31:0] instruction;

    //Sumador
    logic [31:0] sumador = 32'b0;

    //Register_Unit
    logic [31:0] RUrs1;
    logic [31:0] RUrs2;

    //Forwarding_Unit
    logic [1:0] ForwardASrc;
    logic [1:0] ForwardBSrc;

    //Hazard_Detection_Unit
    logic HDUStall;

    //Registros simples
    logic [31:0] PCInc_ex;
    logic [31:0] PC_ex;
    logic [31:0] RUrs1_ex;
    logic [31:0] RUrs2_ex;
    logic [31:0] ImmExt_ex;
    logic [4:0] rd_ex;
    logic [4:0] rs1_ex;
    logic [4:0] rs2_ex;
    logic [31:0] PCInc_me;
    logic [31:0] ALURes_me;
    logic [31:0] RUrs2_me;
    logic [4:0] rd_me;
    logic [31:0] PC_Inc_wb;
    logic [31:0] DMDataRd_wb;
    logic [31:0] ALURes_wb;
    logic [4:0] rd_wb;

    //Registros con Enable y Clear
    logic [31:0] PC_fe = 32'b0;
    logic [31:0] PCInc_de;
    logic [31:0] PC_de;
    logic [31:0] Inst_de;

    always_ff @(posedge clk) begin
        if(HDUStall == 0) begin
            PC_fe <= NextPCSrc ? ALURes : sumador;
            PCInc_de <= sumador;
            PC_de <= PC_fe;
        end
        if(NextPCSrc) begin
            Inst_de <= 32'b00000000000000000000000000110011;
        end else begin
            Inst_de <= instruction;
        end
        PCInc_ex <= PCInc_de;
        PC_ex <= PC_de;
        RUrs1_ex <= RUrs1;
        RUrs2_ex <= RUrs2;
        ImmExt_ex <= ImmExt;
        rd_ex <= Inst_de[11:7];
        rs1_ex <= Inst_de[19:15];
        rs2_ex <= Inst_de[24:20];
        PCInc_me <= PCInc_ex;
        ALURes_me <= ALURes;
        RUrs2_me <= RUrs2_ex;
        rd_me <= rd_ex;
        PC_Inc_wb <= PCInc_me;
        DMDataRd_wb <= DataRd;
        ALURes_wb <= ALURes_me;
        rd_wb <= rd_me;
    end

    always @(*) begin
        sumador = PC_fe + 4;
        A <= ALUASrc ? PC_ex : RUrs1;
        B <= ALUBSrc ? ImmExt_ex : RUrs2;
    end


    ALU alu(
        .A(A), 
        .B(B),
        .Op(ALUOp),
        .ALURes(ALURes)
    );

    Branch_Unit branch_unit(
        .BRUrs1(RUrs1),
        .BRUrs2(RUrs2),
        .BrOp(BrOp),
        .NextPCSrc(NextPCSrc)
    );

    Control_Unit control_unit(
        .OpCode(Inst_de[6:0]),
        .Funct3(Inst_de[14:12]),
        .Funct7(Inst_de[31:25]),
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

    Data_Memory data_memory(
        .Address(ALURes),
        .DataWr(RUrs2),
        .DMWr(DMWr),
        .DMCtrl(DMCtrl),
        .DataRd(DataRd)
    );

    Imm_Gen imm_gen(
        .Inst(Inst_de[31:7]),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );

    Instruction_Memory instruction_memory(
        .address(PC_fe),
        .instruction(instruction)
    );

    Register_Unit register_unit(
        .RUWr(RUWr),
        .clk(clk),
        .rs1(Inst_de[19:15]),
        .rs2(Inst_de[24:20]),
        .rd(rd_wb),
        .RUDataWr((RUDATAWrSrc==2'b00) ? ALURes_wb: ((RUDATAWrSrc==2'b01) ? DMDataRd_wb: ((RUDATAWrSrc==2'b10) ? PC_Inc_wb: 2'b00))),
        .RUrs1(RUrs1),
        .RUrs2(RUrs2)
    );

    assign result = ALURes_wb;


endmodule
