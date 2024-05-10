module PC (
    input logic clk,
    input logic [31:0] PC_Input,
    output logic [31:0] PC_Output
);

    initial 
    begin
        PC_Output = 32'b0;
    end
    
    always @(posedge clk)
    begin
        PC_Output = PC_Input;
    end

endmodule