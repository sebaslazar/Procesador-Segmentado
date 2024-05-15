module tb_HDU;
    logic DMRd_ex;
    logic [4:0] rs1_de;
    logic [4:0] rs2_de;
    logic [4:0] rd_ex;
    logic HDUStall;

    Hazard_Detection_Unit HDU_Test(
        .DMRd_ex(DMRd_ex),
        .rs1_de(rs1_de),
        .rs2_de(rs2_de),
        .rd_ex(rd_ex),
        .HDUStall(HDUStall)
    );
    
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;

        DMRd_ex = 1'b0;
        rs1_de = 5'b0010;
        rs2_de = 5'b0100;
        rd_ex = 5'b0100;
        #1
        $display("DMRd_ex = %b   rs1_de = %b   rs2_de = %b   rd_ex = %b   HDUStall = %b", DMRd_ex, rs1_de, rs2_de, rd_ex, HDUStall);

        DMRd_ex = 1'b1;
        rs1_de = 5'b0010;
        rs2_de = 5'b0100;
        rd_ex = 5'b0010;
        #1
        $display("DMRd_ex = %b   rs1_de = %b   rs2_de = %b   rd_ex = %b   HDUStall = %b", DMRd_ex, rs1_de, rs2_de, rd_ex, HDUStall);

        DMRd_ex = 1'b1;
        rs1_de = 5'b0010;
        rs2_de = 5'b0100;
        rd_ex = 5'b0100;
        #1
        $display("DMRd_ex = %b   rs1_de = %b   rs2_de = %b   rd_ex = %b   HDUStall = %b", DMRd_ex, rs1_de, rs2_de, rd_ex, HDUStall);

        DMRd_ex = 1'b1;
        rs1_de = 5'b0010;
        rs2_de = 5'b0100;
        rd_ex = 5'b1000;
        #1
        $display("DMRd_ex = %b   rs1_de = %b   rs2_de = %b   rd_ex = %b   HDUStall = %b", DMRd_ex, rs1_de, rs2_de, rd_ex, HDUStall);

        #1;
        $finish;
    end
endmodule