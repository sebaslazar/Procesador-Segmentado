`include "ALU.sv"
`include "Branch_Unit.sv"
`include "Control_Unit.sv"
`include "Data_Memory.sv"
`include "Imm_Gen.sv"
`include "Instruction_Memory.sv"
`include "PC.sv"
`include "Register_Unit.sv"

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
    logic [31:0] sumador;
    
    //PC
    logic [31:0] PC_Input;
    logic [31:0] PC_Output;

    //Register_Unit
    logic [31:0] RUrs1;
    logic [31:0] RUrs2;

    always @(*) begin
        sumador = PC_Output + 4;

        PC_Input <= NextPCSrc ? ALURes : sumador;
        A <= ALUASrc ? PC_Output : RUrs1;
        B <= ALUBSrc ? ImmExt : RUrs2;
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
        .OpCode(instruction[6:0]),
        .Funct3(instruction[14:12]),
        .Funct7(instruction[31:25]),
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
        .Inst(instruction[31:7]),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );

    Instruction_Memory instruction_memory(
        .address(PC_Output),
        .instruction(instruction)
    );

    PC programm_counter(
        .clk(clk),
        .PC_Input(PC_Input),
        .PC_Output(PC_Output)
    );

    Register_Unit register_unit(
        .RUWr(RUWr),
        .clk(clk),
        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(instruction[11:7]),
        .RUDataWr((RUDATAWrSrc==2'b00) ? ALURes: ((RUDATAWrSrc==2'b01) ? DataRd: ((RUDATAWrSrc==2'b10) ? sumador: 2'b00))),
        .RUrs1(RUrs1),
        .RUrs2(RUrs2)
    );

    assign result = ALURes;


endmodule
