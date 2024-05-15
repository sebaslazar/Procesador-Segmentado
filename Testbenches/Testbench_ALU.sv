module tb_ALU;
    logic signed [31:0] A; 
    logic signed [31:0] B;
    logic [3:0] Op;
    logic signed [31:0] ALURes;
    integer i;

    ALU alu (
        .A(A),
        .B(B),
        .Op(Op),
        .ALURes(ALURes)
    );
            
initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    
    $display("\nPruebas de desbordamiento:");
        A = 32'b10000000000000000000000000000000;
        B = 32'b10000000000000000000000000000000;
        Op = 2'b00;
    #10
    $display("  Op=%b : A=%b  B=%b  ALURes=%b", Op, A, B, ALURes);

        A = 32'b10000000000000000000000000000001;
        B = 32'b01111111111111111111111111111111;
        Op = 2'b01;
    #10
    $display("  Op=%b : A=%b  B=%b  ALURes=%b", Op, A, B, ALURes);
    #20

    $display("\nPruebas con distintos valores en las entradas:");
    Op = 4'b0;
    A = 32'hAF2;
    B = 32'hFFFFFFFb;
    #10
    $display("  Op = %b :   A = %h    B = %h    ALURes = %h", Op, A, B, ALURes);

    Op = 4'b1000;
    A = 32'hAF2;
    B = 32'hFFFFFFFb;
    #10
    $display("  Op = %b :   A = %h    B = %h    ALURes = %h", Op, A, B, ALURes);
    
    Op = 4'b0001;
    A = 32'hAFBB2;
    B = 32'h2;
    #10
    $display("  Op = %b :   A = %b    B = %b    ALURes = %b", Op, A, B, ALURes);
    
    Op = 4'b0010;
    A = 32'hC;
    B = 32'hFFFFFFFB;
    #10
    $display("  Op = %b :   A = %h    B = %h    ALURes = %h", Op, A, B, ALURes);
    
    Op = 4'b0011;
    A = 32'hC;
    B = 32'hFFFFFFFB;
    #10
    $display("  Op = %b :   A = %h    B = %h    ALURes = %h", Op, A, B, ALURes);
    
    Op = 4'b0100;
    A = 32'b11011101010100011;
    B = 32'b00111111001110011;
    #10
    $display("  Op = %b :   A = %b    B = %b    ALURes = %b", Op, A, B, ALURes);
    
    Op = 4'b0101;
    A = 32'b1010111101;
    B = 32'b11;
    #10
    $display("  Op = %b :   A = %b    B = %b    ALURes = %b", Op, A, B, ALURes);
    
    Op = 4'b1101;
    A = 32'hFFFFFFFB;
    B = 32'h2;
    #10
    $display("  Op = %b :   A = %b    B = %b    ALURes = %b", Op, A, B, ALURes);
    
    Op = 4'b0110;
    A = 32'b1111100001111000110101;
    B = 32'b0000011110000000000111;
    #10
    $display("  Op = %b :   A = %b    B = %b    ALURes = %b", Op, A, B, ALURes);

    Op = 4'b0111;
    A = 32'b1111100001111000110101;
    B = 32'b0000011110000000000111;
    #10
    $display("  Op = %b :   A = %b    B = %b    ALURes = %b", Op, A, B, ALURes);

    #10;
    $finish;
    end
endmodule