module tb_Font_ROM;
    logic clk;
    logic [11:0] address;
    logic [7:0] data;

    logic [3:0] row;

    Font_ROM FontROM_test(
        .clk(clk),
        .address(address),
        .data(data)
    );
    
    initial
    begin
        clk = 1'b0;
        row = -4'd1;

        $dumpfile("dump.vcd");
        $dumpvars;

        #32;
        $finish;
    end

    always begin
        #1 clk = ~clk;
    end

    always @(posedge clk) begin
        if (row <= 4'b1111) begin
            row = row + 1;
        end else begin
            row = 4'b0;
        end
        #0.5
        $display("Fila = %h", data);
    end

    assign address = {"!", row};
endmodule