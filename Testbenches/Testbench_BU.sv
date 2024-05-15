module tb_Branch_Unit;
    logic [31:0] BRUrs1;
    logic [31:0] BRUrs2;
    logic [4:0] BrOp;
    logic NextPCSrc;

    Branch_Unit Branch_Unit_Test(
        .BRUrs1(BRUrs1),
        .BRUrs2(BRUrs2),
        .BrOp(BrOp),
        .NextPCSrc(NextPCSrc)
    );
    
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;

        BRUrs1 = 32'h20;
        BRUrs2 = 32'h14;

        $display("ENTRADAS POSITIVAS\n");

        BrOp = 5'b0; //0
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);

        BrOp = 5'b01000; //beq
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);

        BrOp = 5'b01001; //bnq
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);

        BrOp = 5'b01100; //blt
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);

        BrOp = 5'b01101; //bge
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);
        
        BrOp = 5'b01110; //bltu
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);
        
        BrOp = 5'b01111; //bgeu
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);

        BrOp = 5'b11111; //1
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);


        $display("\n\nENTRADAS NEGATIVAS\n");

        BRUrs1 = 32'hff5ff0ef; //-12 base 10
        BRUrs2 = 32'hffbff0ef; //-5 base 10

        BrOp = 5'b0; //0
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);

        BrOp = 5'b01000; //beq
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);

        BrOp = 5'b01001; //bnq
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);

        BrOp = 5'b01100; //blt
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);

        BrOp = 5'b01101; //bge
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);
        

        BRUrs1 = 32'hffbff0ef; //-12 base 10
        BRUrs2 = 32'hff5ff0ef; //-5 base 10

        BrOp = 5'b01110; //bltu
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);
        
        BrOp = 5'b01111; //bgeu
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);

        BrOp = 5'b11111; //1
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);
        



        $display("\n\nPOSITIVA Y NEGATIVA\n");

        BRUrs1 = 32'hff5ff0ef; //-12 base 10
        BRUrs2 = 32'h5; //-5 base 10

        BrOp = 5'b0; //0
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);

        BrOp = 5'b01000; //beq
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);

        BrOp = 5'b01001; //bnq
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);

        BrOp = 5'b01100; //blt
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);

        BrOp = 5'b01101; //bge
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);
        
        BrOp = 5'b01110; //bltu
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);
        
        BrOp = 5'b01111; //bgeu
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);

        BrOp = 5'b11111; //1
        #10
        $display("BRUrs1 = %h   BRUrs2 = %h   BrOp = %b   NextPCSrc = %h", BRUrs1, BRUrs2, BrOp, NextPCSrc);

        #20;
        $finish;
    end
endmodule