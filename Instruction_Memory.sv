module Instruction_Memory(
  input logic [31:0]address,
  output logic [31:0]instruction
);

  logic [7:0] BIOS [0:255];
  
  initial begin
    $readmemh("test_2.txt", BIOS);
  end

  assign instruction = {BIOS[address], BIOS[address+1], BIOS[address+2], BIOS[address+3]};
  
endmodule