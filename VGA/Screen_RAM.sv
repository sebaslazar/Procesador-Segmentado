module Screen_RAM (
    input logic clk,
    input logic [7:0] scrX,
    input logic [6:0] scrY,
    input logic selector,
    output logic [7:0] caracter
);
    logic [7:0] message [0:10239];
    logic [14:0] address;

    initial begin
        address = 15'b0;
        for (int i = 0; i < 10239; i++) begin
            message[i] = 8'b0;
        end
        $readmemh("Screen_test.txt", message);
    end

    always @(posedge clk) begin
        address <= {scrY, scrX};

        if (~selector) begin
            caracter <= 8'b0; //NULL
        end else if (address > 15'd10239) begin
            caracter <= 8'b0;
        end else begin
            caracter <= message[address];
        end
    end
endmodule