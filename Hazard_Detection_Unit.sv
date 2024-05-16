module Hazard_Detection_Unit (
    input logic DMRd_ex,
    input logic [4:0] rs1_de,
    input logic [4:0] rs2_de,
    input logic [4:0] rd_ex,
    output logic HDUStall
);
    initial begin
        HDUStall = 1'b0;
    end
    
    always @(*) begin
        if (DMRd_ex && ((rd_ex == rs1_de) || (rd_ex == rs2_de))) begin
            HDUStall = 1'b1;
        end else begin
            HDUStall = 1'b0;
        end
    end
endmodule