module tb_FU;
    logic RUWr_me;
    logic RUWr_wb;
    logic [4:0] rd_me;
    logic [4:0] rd_wb;
    logic [4:0] rs1_ex;
    logic [4:0] rs2_ex;
    logic [1:0] ForwardASrc;
    logic [1:0] ForwardBSrc;

    Forwarding_Unit FU_Test(
        .RUWr_me(RUWr_me),
        .RUWr_wb(RUWr_wb),
        .rd_me(rd_me),
        .rd_wb(rd_wb),
        .rs1_ex(rs1_ex),
        .rs2_ex(rs2_ex),
        .ForwardASrc(ForwardASrc),
        .ForwardBSrc(ForwardBSrc)
    );
    
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;

        RUWr_me = 2'b0;
        RUWr_wb = 2'b0;
        rd_me = 5'b0;
        rd_wb = rd_me;
        rs1_ex = 5'b0;
        rs2_ex = 5'b0;
        #1
        $display("RUWr_me = %b   RUWr_wb = %b   rd_me = %b   rd_wb = %b   rs1_ex = %b   rs2_ex = %b   ForwardASrc = %b   ForwardBSrc = %b", RUWr_me, RUWr_wb, rd_me, rd_wb, rs1_ex, rs2_ex, ForwardASrc, ForwardBSrc);

        RUWr_me = 1'b1;
        RUWr_wb = 1'b0;
        rd_me = 5'b0100;
        rd_wb = rd_me;
        rs1_ex = 5'b0100;
        rs2_ex = 5'b1011;
        #1
        $display("RUWr_me = %b   RUWr_wb = %b   rd_me = %b   rd_wb = %b   rs1_ex = %b   rs2_ex = %b   ForwardASrc = %b   ForwardBSrc = %b", RUWr_me, RUWr_wb, rd_me, rd_wb, rs1_ex, rs2_ex, ForwardASrc, ForwardBSrc);

        RUWr_me = 1'b1;
        RUWr_wb = 1'b0;
        rd_me = 5'b0100;
        rd_wb = rd_me;
        rs1_ex = 5'b1100;
        rs2_ex = 5'b1011;
        #1
        $display("RUWr_me = %b   RUWr_wb = %b   rd_me = %b   rd_wb = %b   rs1_ex = %b   rs2_ex = %b   ForwardASrc = %b   ForwardBSrc = %b", RUWr_me, RUWr_wb, rd_me, rd_wb, rs1_ex, rs2_ex, ForwardASrc, ForwardBSrc);

        RUWr_me = 1'b1;
        RUWr_wb = 1'b0;
        rd_me = 5'b0100;
        rd_wb = rd_me;
        rs1_ex = 5'b1100;
        rs2_ex = 5'b0100;
        #1
        $display("RUWr_me = %b   RUWr_wb = %b   rd_me = %b   rd_wb = %b   rs1_ex = %b   rs2_ex = %b   ForwardASrc = %b   ForwardBSrc = %b", RUWr_me, RUWr_wb, rd_me, rd_wb, rs1_ex, rs2_ex, ForwardASrc, ForwardBSrc);

        ///////////////////////////////////////////////////////

        RUWr_me = 1'b0;
        RUWr_wb = 1'b1;
        rd_me = 5'b0100;
        rd_wb = rd_me;
        rs1_ex = 5'b0100;
        rs2_ex = 5'b1011;
        #1
        $display("RUWr_me = %b   RUWr_wb = %b   rd_me = %b   rd_wb = %b   rs1_ex = %b   rs2_ex = %b   ForwardASrc = %b   ForwardBSrc = %b", RUWr_me, RUWr_wb, rd_me, rd_wb, rs1_ex, rs2_ex, ForwardASrc, ForwardBSrc);

        RUWr_me = 1'b0;
        RUWr_wb = 1'b1;
        rd_me = 5'b0100;
        rd_wb = rd_me;
        rs1_ex = 5'b1100;
        rs2_ex = 5'b1011;
        #1
        $display("RUWr_me = %b   RUWr_wb = %b   rd_me = %b   rd_wb = %b   rs1_ex = %b   rs2_ex = %b   ForwardASrc = %b   ForwardBSrc = %b", RUWr_me, RUWr_wb, rd_me, rd_wb, rs1_ex, rs2_ex, ForwardASrc, ForwardBSrc);

        RUWr_me = 1'b0;
        RUWr_wb = 1'b1;
        rd_me = 5'b0100;
        rd_wb = rd_me;
        rs1_ex = 5'b1100;
        rs2_ex = 5'b0100;
        #1
        $display("RUWr_me = %b   RUWr_wb = %b   rd_me = %b   rd_wb = %b   rs1_ex = %b   rs2_ex = %b   ForwardASrc = %b   ForwardBSrc = %b", RUWr_me, RUWr_wb, rd_me, rd_wb, rs1_ex, rs2_ex, ForwardASrc, ForwardBSrc);

        #20;
        $finish;
    end
endmodule