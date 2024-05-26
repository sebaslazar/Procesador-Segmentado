module Screen_RAM (
    input logic clk,
    input logic [13:0] address,
    output logic [7:0] char
);
    logic [7:0] message [0:10239];

    initial begin
        for (int i = 0; i < 10239; i++) begin
            message[i] = 8'b0;
        end
        $readmemh("Screen_Test.txt", message);
    end

    always @(posedge clk) begin
        if (address > 15'd10239) begin
            char <= 8'b0;
        end else begin
            char <= message[address];
        end
    end
endmodule