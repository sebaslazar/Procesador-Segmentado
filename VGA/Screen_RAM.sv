module Screen_RAM (
    input logic clk,
    input logic [7:0] scrX,
    input logic [6:0] scrY,
    input logic selector,
    output logic [7:0] caracter
);
    logic [7:0] message [0:10239];

    initial begin
        address = 14'b0;
        $readmemh("Screen_Message.txt", message);
    end

    always @(posedge clk) begin
        address <= {scrY, scrX}

        if (~selector) begin
            caracter = 8'b0; //Space
        end else if (address > 14'd10239) begin
            caracter = 8'b0;
        end else begin
            caracter = message[address];
        end
    end
endmodule