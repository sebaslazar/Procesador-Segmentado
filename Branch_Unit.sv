module Branch_Unit (
    input logic signed [31:0] BRUrs1,
    input logic signed [31:0] BRUrs2,
    input logic [4:0] BrOp,
    output logic NextPCSrc
);

    always @(*)
    begin
        if (BrOp[4]==1) begin
            NextPCSrc <= 1;
        end else if (BrOp[4:3]==2'b00) begin
            NextPCSrc <= 0;
        end else if(BrOp[4:3]==2'b01) begin
            if (BrOp[2:0]==3'b000) begin
                NextPCSrc <= (BRUrs1==BRUrs2);
            end else if (BrOp[2:0]==3'b001) begin
                NextPCSrc <= (BRUrs1!=BRUrs2);
            end else if (BrOp[2:0]==3'b100) begin
                NextPCSrc <= (BRUrs1<BRUrs2);
            end else if (BrOp[2:0]==3'b101) begin
                NextPCSrc <= (BRUrs1>=BRUrs2);
            end else if (BrOp[2:0]==3'b101) begin
                NextPCSrc <= (BRUrs1>=BRUrs2);
            end else if (BrOp[2:0]==3'b110) begin
                NextPCSrc <= ($unsigned(BRUrs1)<$unsigned(BRUrs2));
            end else if (BrOp[2:0]==3'b111) begin
                NextPCSrc <= ($unsigned(BRUrs1)>=$unsigned(BRUrs2));
            end
        end
    end
    
endmodule