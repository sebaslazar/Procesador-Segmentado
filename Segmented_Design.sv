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
    logic [2:0] ImmSrc_de;
    logic DMRd;

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
    logic [31:0] PCInc_ex = 32'b0;
    logic [31:0] PC_ex = 32'b0;
    logic [31:0] RUrs1_ex = 32'b0;
    logic [31:0] RUrs2_ex = 32'b0;
    logic [31:0] ImmExt_ex = 32'b0;
    logic [4:0] rd_ex = 32'b0;
    logic [4:0] rs1_ex = 32'b0;
    logic [4:0] rs2_ex = 32'b0;
    logic [31:0] PCInc_me = 32'b0;
    logic [31:0] ALURes_me = 32'b0;
    logic [31:0] RUrs2_me = 32'b0;
    logic [4:0] rd_me = 32'b0;
    logic [31:0] PCInc_wb = 32'b0;
    logic [31:0] DMDataRd_wb = 32'b0;
    logic [31:0] ALURes_wb = 32'b0;
    logic [4:0] rd_wb = 32'b0;

    //Registros con Enable y Clear
    logic [31:0] PC_fe = 32'b0;
    logic [31:0] PCInc_de = 32'b0;
    logic [31:0] PC_de = 32'b0;
    logic [31:0] Inst_de = 32'b0;

    //Registros de control execute
    logic ALUASrc_ex = 32'b0;
    logic ALUBSrc_ex = 32'b0;
    logic [3:0] ALUOp_ex = 32'b0;
    logic [4:0] BrOp_ex = 32'b0;
    logic DMWr_ex = 32'b0;
    logic [2:0] DMCtrl_ex = 32'b0;
    logic RUWr_ex = 32'b0;
    logic [1:0] RUDATAWrSrc_ex = 32'b0;
    logic DMRd_ex = 32'b0;

    //Registros de control memory
    logic DMWr_me = 32'b0;
    logic [2:0] DMCtrl_me = 32'b0;
    logic RUWr_me = 32'b0;
    logic [1:0] RUDATAWrSrc_me = 32'b0;

    //Registro de control de write back
    logic RUWr_wb = 32'b0;
    logic [1:0] RUDATAWrSrc_wb = 32'b0; 

    always_ff @(posedge clk) begin
        if(HDUStall == 0) begin
            PC_fe <= NextPCSrc ? ALURes : sumador;
            PCInc_de <= sumador;
            PC_de <= PC_fe;
            if(NextPCSrc) begin
                Inst_de <= 32'b00000000000000000000000000110011;
            end else begin
                Inst_de <= instruction;
            end
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
        PCInc_wb <= PCInc_me;
        DMDataRd_wb <= DataRd;
        ALURes_wb <= ALURes_me;
        rd_wb <= rd_me;

        ALUASrc_ex <= ALUASrc; //Pendiente el Clr
        ALUBSrc_ex <= ALUBSrc;
        ALUOp_ex <= ALUOp;
        BrOp_ex <= BrOp;
        DMWr_ex <= DMWr;
        DMCtrl_ex <= DMCtrl;
        RUWr_ex <= RUWr;
        RUDATAWrSrc_ex <= RUDATAWrSrc;
        DMRd_ex <= DMRd;

        DMWr_me <= DMWr_ex;
        DMCtrl_me <= DMCtrl_ex;
        RUWr_me <= RUWr_ex;
        RUDATAWrSrc_me <= RUDATAWrSrc_ex;

        RUDATAWrSrc_wb <= RUDATAWrSrc_me;
        RUWr_wb <= RUWr_me;
    end

    always @(*) begin
        sumador = PC_fe + 4;

        A <= ALUASrc_ex ? PC_ex : ((ForwardASrc==2'b00) ? RUrs1_ex: ((ForwardASrc==2'b01) ? ALURes_me: ((ForwardASrc==2'b10) ? ((RUDATAWrSrc_wb==2'b00) ? ALURes_wb: ((RUDATAWrSrc_wb==2'b01) ? DMDataRd_wb: ((RUDATAWrSrc_wb==2'b10) ? PCInc_wb: 2'b00))): 2'b00)));
        B <= ALUBSrc_ex ? ImmExt_ex : ((ForwardBSrc==2'b00) ? RUrs2_ex: ((ForwardBSrc==2'b01) ? ALURes_me: ((ForwardBSrc==2'b10) ? ((RUDATAWrSrc_wb==2'b00) ? ALURes_wb: ((RUDATAWrSrc_wb==2'b01) ? DMDataRd_wb: ((RUDATAWrSrc_wb==2'b10) ? PCInc_wb: 2'b00))): 2'b00)));
    end


    ALU alu(
        .A(A), 
        .B(B),
        .Op(ALUOp_ex),
        .ALURes(ALURes)
    );

    Branch_Unit branch_unit(
        .BRUrs1(RUrs1_ex),
        .BRUrs2(RUrs2_ex),
        .BrOp(BrOp_ex),
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
        .ImmSrc_de(ImmSrc_de),
        .DMRd(DMRd)
    );

    Data_Memory data_memory(
        .Address(ALURes_me),
        .DataWr(RUrs2_me),
        .DMWr(DMWr_me),
        .DMCtrl(DMCtrl_me),
        .DataRd(DataRd)
    );

    Imm_Gen imm_gen(
        .Inst(Inst_de[31:7]),
        .ImmSrc(ImmSrc_de),
        .ImmExt(ImmExt)
    );

    Instruction_Memory instruction_memory(
        .address(PC_fe),
        .instruction(instruction)
    );

    Register_Unit register_unit(
        .RUWr(RUWr_wb),
        .clk(clk),
        .rs1(Inst_de[19:15]),
        .rs2(Inst_de[24:20]),
        .rd(rd_wb),
        .RUDataWr((RUDATAWrSrc_wb==2'b00) ? ALURes_wb: ((RUDATAWrSrc_wb==2'b01) ? DMDataRd_wb: ((RUDATAWrSrc_wb==2'b10) ? PCInc_wb: 2'b00))),
        .RUrs1(RUrs1),
        .RUrs2(RUrs2)
    );

    Hazard_Detection_Unit hd_unit(
        .DMRd_ex(DMRd_ex),
        .rs1_de(Inst_de[19:15]),
        .rs2_de(Inst_de[24:20]),
        .rd_ex(rd_ex),
        .HDUStall(HDUStall)
    )

    Forwarding_Unit Forward_Unit(
        .RUWr_me(RUWr_me),
        .RUWr_wb(RUWr_wb),
        .rd_me(rd_me),
        .rd_wb(rd_wb),
        .rs1_ex(rs1_ex),
        .rs2_ex(rs2_ex),
        .ForwardASrc(ForwardASrc),
        .ForwardBSrc(ForwardBSrc)
    )

    assign result = ALURes_wb;


endmodule
