module Data_Memory (
    input logic [31:0] Address,
    input logic [31:0] DataWr,
    input logic DMIOWr,
    input logic [2:0] DMCtrl,
    input logic [9:0] sw,
    output logic [31:0] DataRd,
    output logic [9:0] led
);
    
    logic [7:0] data_mem [0:2048];
    logic [9:0] led_reg = 10'b0;
    logic [9:0] sw_reg = 10'b0;
    logic [31:0] DMRd = 32'b0;

    initial
    begin
        for (int i = 0; i < 2048; i++) begin
            data_mem[i] = 8'b0;
        end
    end

    always @(*)
    begin
        if(DMIOWr && ~Address[13] && ~Address[12])
        begin
            #1
            case (DMCtrl)
                3'b000, 3'b100:
                begin
                    data_mem[Address[11:0]+3] <= DataWr[7:0];
                end
                3'b001, 3'b101:
                begin
                    data_mem[Address[11:0]+2] <= DataWr[15:8];
                    data_mem[Address[11:0]+3] <= DataWr[7:0];
                end
                3'b010:
                begin
                    data_mem[Address[11:0]] <= DataWr[31:24];
                    data_mem[Address[11:0]+1] <= DataWr[23:16];
                    data_mem[Address[11:0]+2] <= DataWr[15:8];
                    data_mem[Address[11:0]+3] <= DataWr[7:0];
                end
            endcase
        end else if (DMIOWr && ~Address[13] && Address[12]) begin
            #1
            led_reg <= DataWr[9:0];
        end else if (DMIOWr && Address[13] && ~Address[12]) begin
            #1
            sw_reg <= sw;
        end

        case (DMCtrl)
            3'b000: DMRd = {{{24{data_mem[Address[11:0]+3][7]}}}, data_mem[Address[11:0]+3]};
            3'b001: DMRd = {{{16{data_mem[Address[11:0]+2][7]}}}, data_mem[Address[11:0]+2], data_mem[Address[11:0]+3]};  
            3'b010: DMRd = {data_mem[Address[11:0]], data_mem[Address[11:0]+1], data_mem[Address[11:0]+2], data_mem[Address[11:0]+3]};  
            3'b100: DMRd = {24'b0, data_mem[Address[11:0]+3]};  
            3'b101: DMRd = {16'b0, data_mem[Address[11:0]+2], data_mem[Address[11:0]+3]};    
        endcase

        if (Address[13:12] == 2'b00) begin
            DataRd <= DMRd;
        end else if (Address[13:12] == 2'b01) begin
            DataRd <= led_reg;
        end else if (Address[13:12] == 2'b10) begin
            DataRd <= sw_reg;
        end
    end

    assign led = led_reg;
endmodule