module Imm_Gen (
    input logic [24:0] Inst,
    input logic [2:0] ImmSrc,
    output logic [31:0] ImmExt
);

    always @(*)
    begin
        case (ImmSrc)
            3'b000 : ImmExt = (Inst[7:5]==3'b101 || Inst[7:5]==3'b001) ? {{27{Inst[17]}}, Inst[17:13]}: {{20{Inst[24]}}, Inst[24:13]}; //Tipo I
            3'b001 : ImmExt = {{20{Inst[24]}}, Inst[24:18], Inst[4:0]}; //Tipo S
            3'b101 : ImmExt = {{19{Inst[24]}}, Inst[24], Inst[0], Inst[23:18], Inst[4:1], 1'b0}; //Tipo B
            3'b010 : ImmExt = {Inst[24:5], 12'b0}; //Tipo U
            3'b110 : ImmExt = {{11{Inst[24]}}, Inst[24], Inst[12:5], Inst[13], Inst[23:14], 1'b0}; //Tipo J
            default: ImmExt = 32'b0;
        endcase        
    end
    
endmodule