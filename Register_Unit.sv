module Register_Unit (
    input logic RUWr,
    input logic clk,
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,
    input logic [31:0] RUDataWr,
    output logic [31:0] RUrs1,
    output logic [31:0] RUrs2
);

    logic [31:0] RU32 [0:31];

	initial
    begin
        for (int i = 0; i < 32; i++) begin
            RU32[i] = 32'b0;
        end
        RU32[2] = 32'd1000;
    end

    always @(posedge clk)
    begin
        if(RUWr && (rd!=0))
        begin
            RU32[rd] <= RUDataWr;
        end
    end

    assign RUrs1 = RU32[rs1];
    assign RUrs2 = RU32[rs2];
    
endmodule