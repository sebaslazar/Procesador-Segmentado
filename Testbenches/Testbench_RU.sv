module tb_RU;
    logic RUWr;
    logic clk;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;
    logic [31:0] RUDataWr;
    logic [31:0] RUrs1;
    logic [31:0] RUrs2;
    integer i;
    integer j;

    Register_Unit reg_unit (
        .RUWr(RUWr),
        .clk(clk),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .RUDataWr(RUDataWr),
        .RUrs1(RUrs1),
        .RUrs2(RUrs2)
    );

    always 
    begin
        #3 clk = ~clk;
    end

    always 
    begin
        #9 RUWr = ~RUWr;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;

        clk = 1;
        RUWr = 1;
        rs1 = 0;
        rs2 = 0;

        for(i=0; i<16; i=i+1)
        begin
            rd = i;
            RUDataWr = $random;
            #5;
            $display("rd = %b   RUDataWr = %h", rd, RUDataWr);
        end

        for(j=0; j+1<16; j=j+2)
        begin
            rs1 = j;
            rs2 = j + 1;
            #1
            $display("rs1 = %b  rs2 = %b  RUrs1 = %h  RUrs2 = %h", rs1, rs2, RUrs1, RUrs2);
        end

        $finish;
    end 
endmodule