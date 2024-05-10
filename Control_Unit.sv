module Control_Unit (
    input logic [6:0] OpCode,
    input logic [2:0] Funct3,
    input logic [6:0] Funct7,
    output logic ALUASrc,
    output logic ALUBSrc,
    output logic [3:0] ALUOp,
    output logic [4:0] BrOp,
    output logic DMWr,
    output logic [2:0] DMCtrl,
    output logic RUWr,
    output logic [1:0] RUDATAWrSrc,
    output logic [2:0] ImmSrc
);
    always @(*) begin
        case (OpCode)
        7'b0110011: //Tipo R
        begin
            ALUASrc = 1'b0;
            ALUBSrc = 1'b0;
            ALUOp = {Funct7[5], Funct3};
            BrOp = 5'b0;
            DMWr = 1'b0;
            DMCtrl = 3'b0;
            RUWr = 1'b1;
            RUDATAWrSrc = 2'b0;
            ImmSrc =3'b0;
        end
        7'b0010011: //Tipo I
        begin
            ALUASrc = 1'b0;
            ALUBSrc = 1'b1;
            if (Funct3 == 3'b101 || Funct3 == 3'b001) begin
                ALUOp = {Funct7[5], Funct3};
            end else begin
                ALUOp = {1'b0, Funct3};
            end
            BrOp = 5'b0;
            DMWr = 1'b0;
            DMCtrl = 3'b0;
            RUWr = 1'b1;
            RUDATAWrSrc = 2'b0;
            ImmSrc =3'b0;
        end
        7'b0000011: //Tipo I-Lectura
        begin
            ALUASrc = 1'b0;
            ALUBSrc = 1'b1;
            ALUOp = 4'b0;
            BrOp = 5'b0;
            DMWr = 1'b0;
            DMCtrl = Funct3;
            RUWr = 1'b1;
            RUDATAWrSrc = 2'b01;
            ImmSrc =3'b0;
        end
        7'b1100111: //Tipo I-Salto
        begin
            ALUASrc = 1'b0;
            ALUBSrc = 1'b1;
            ALUOp = 4'b0;
            BrOp = 5'b10000;
            DMWr = 1'b0;
            DMCtrl = 3'b0;
            RUWr = 1'b1;
            RUDATAWrSrc = 2'b10;
            ImmSrc =3'b0;
        end
        7'b0100011: //Tipo S
        begin
            ALUASrc = 1'b0;
            ALUBSrc = 1'b1;
            ALUOp = 4'b0;
            BrOp = 5'b0;
            DMWr = 1'b1;
            DMCtrl = Funct3;
            RUWr = 1'b0;
            RUDATAWrSrc = 2'b10;
            ImmSrc =3'b001;
        end
        7'b1100011: //Tipo B
        begin
            ALUASrc = 1'b1;
            ALUBSrc = 1'b1;
            ALUOp = 4'b0;
            BrOp = {2'b01, Funct3};
            DMWr = 1'b0;
            DMCtrl = 3'b0;
            RUWr = 1'b0;
            RUDATAWrSrc = 2'b10;
            ImmSrc =3'b101;
        end
        7'b1101111: //Tipo J
        begin
            ALUASrc = 1'b1;
            ALUBSrc = 1'b1;
            ALUOp = 4'b0;
            BrOp = 5'b10000;
            DMWr = 1'b0;
            DMCtrl = 3'b0;
            RUWr = 1'b1;
            RUDATAWrSrc = 2'b10;
            ImmSrc =3'b110;
        end
        7'b0110111: //Tipo U-lui
        begin
            ALUASrc = 1'b0;
            ALUBSrc = 1'b1;
            ALUOp = 4'b0111;
            BrOp = 5'b0;
            DMWr = 1'b0;
            DMCtrl = 3'b0;
            RUWr = 1'b0;
            RUDATAWrSrc = 2'b0;
            ImmSrc =3'b010;
        end
        7'b0010111: //Tipo U-auipc
        begin
            ALUASrc = 1'b1;
            ALUBSrc = 1'b1;
            ALUOp = 4'b0000;
            BrOp = 5'b0;
            DMWr = 1'b0;
            DMCtrl = 3'b0;
            RUWr = 1'b1;
            RUDATAWrSrc = 2'b0;
            ImmSrc =3'b010;
        end
    endcase
    end
endmodule