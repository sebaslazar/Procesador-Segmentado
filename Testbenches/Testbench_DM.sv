module tb_Data_Memory;
    logic [31:0] Address;
    logic [31:0] DataWr;
    logic DMWr;
    logic [2:0] DMCtrl;
    logic [31:0] DataRd;
    integer i;
    integer j;

    Data_Memory Data_Memory_Test(
        .Address(Address),
        .DataWr(DataWr),
        .DMWr(DMWr),
        .DMCtrl(DMCtrl),
        .DataRd(DataRd)
    );
    
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
        j=1;

        $monitor("Address = %h   DataWr = %b   DMWr = %h   DMCtrl = %b   DataRd = %b", Address, DataWr, DMWr, DMCtrl, DataRd);

        $display("\nEscritura de datos:\n");
        for(i=0; i<52; i=i+4) begin
            DMWr = {$random} %2;
            if(j>1&&j<=5) begin
                case (j)
                    2 : DMCtrl = 3'b001;
                    3 : DMCtrl = 3'b010;
                    4 : DMCtrl = 3'b100;
                    5 : DMCtrl = 3'b101;
                endcase
                j = j+1;
            end else begin
                j = 2;
                DMCtrl = 3'b000;
            end
            Address = i;
            DataWr = $random;
            #10;
        end

        $display("\n\nLectura de datos:\n");
        DMWr = 0;

        $display("\n-> Byte con signo\n");
        DMCtrl = 3'b000;
        for(i=0; i<52; i=i+4) begin
            Address = i;
            #10;
        end

        $display("\n-> Half Word con signo\n");
        DMCtrl = 3'b001;
        for(i=0; i<52; i=i+4) begin
            Address = i;
            #10;
        end

        $display("\n-> Word con signo\n");
        DMCtrl = 3'b010;
        for(i=0; i<52; i=i+4) begin
            Address = i;
            #10;
        end

        $display("\n-> Byte sin signo\n");
        DMCtrl = 3'b100;
        for(i=0; i<52; i=i+4) begin
            Address = i;
            #10;
        end

        $display("\n-> Half Word sin signo\n");
        DMCtrl = 3'b101;
        for(i=0; i<52; i=i+4) begin
            Address = i;
            #10;
        end
        #20;
        $finish;
    end
endmodule