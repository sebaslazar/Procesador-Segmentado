module Data_Memory (
    input logic [31:0] Address,
    input logic [31:0] DataWr,
    input logic DMWr,
    input logic [2:0] DMCtrl,
    output logic [31:0] DataRd
);
    
    logic [7:0] data_mem [0:2048];

    initial
    begin
        for (int i = 0; i < 2048; i++) begin
            data_mem[i] = 8'b0;
        end
    end

    always @(*)
    begin
        if(DMWr)
        begin
            #1
            case (DMCtrl)
                3'b000, 3'b100:
                begin
                    data_mem[Address+3] <= DataWr[7:0];
                end
                3'b001, 3'b101:
                begin
                    data_mem[Address+2] <= DataWr[15:8];
                    data_mem[Address+3] <= DataWr[7:0];
                end
                3'b010:
                begin
                    data_mem[Address] <= DataWr[31:24];
                    data_mem[Address+1] <= DataWr[23:16];
                    data_mem[Address+2] <= DataWr[15:8];
                    data_mem[Address+3] <= DataWr[7:0];
                end
            endcase
        end

        case (DMCtrl)
            3'b000: DataRd = {{{24{data_mem[Address+3][7]}}}, data_mem[Address+3]};
            3'b001: DataRd = {{{16{data_mem[Address+2][7]}}}, data_mem[Address+2], data_mem[Address+3]};  
            3'b010: DataRd = {data_mem[Address], data_mem[Address+1], data_mem[Address+2], data_mem[Address+3]};  
            3'b100: DataRd = {24'b0, data_mem[Address+3]};  
            3'b101: DataRd = {16'b0, data_mem[Address+2], data_mem[Address+3]};    
        endcase
    end
endmodule