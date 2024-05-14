module Forwarding_Unit (
    input logic RUWr_me,
    input logic RUWr_wb,
    input logic [4:0] rd_me,
    input logic [4:0] rd_wb,
    input logic [4:0] rs1_ex,
    input logic [4:0] rs2_ex,
    output logic [1:0] ForwardASrc,
    output logic [1:0] ForwardBSrc
);
    
    initial 
    begin
        ForwardASrc = 2'b0;
        ForwardBSrc = 2'b0;
    end

    always @(*) 
    begin
        if (RUWr_me && (rd_me != 0) && (rd_me == rs1_ex)) begin
            ForwardASrc = 2'b01;
        end else if (RUWr_me && (rd_me != 0) && (rd_me == rs2_ex)) begin
            ForwardBSrc = 2'b01;
        end else if ((RUWr_wb && (rd_wb != 0) && (rd_wb == rs1_ex)) && !(RUWr_me && (rd_me != 0) && (rd_me == rs1_ex))) begin
            ForwardASrc = 2'b10;
        end else if((RUWr_wb && (rd_wb != 0) && (rd_wb == rs2_ex)) && !(RUWr_me && (rd_me != 0) && (rd_me == rs2_ex))) begin
            ForwardBSrc = 2'b10;
        end else begin
            ForwardASrc = 2'b0;
            ForwardBSrc = 2'b0;
        end
    end
endmodule