module CharPos_Module ( //160 caracteres en horizontal y 64 caracteres en vertical
    input logic [10:0] H,
    input logic [10:0] V,
    output logic [7:0] scrX,
    output logic [6:0] scrY,
    output logic [2:0] charX,
    output logic [3:0] charY,
);
    
    always @(*) begin
        charX <= H[2:0];
        charY <= V[3:0];
        scrX <= H[7:0];
        scrY <= V[5:0];
    end
endmodule