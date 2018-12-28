module CPU(input clk, rst);
 wire Halt, PCWrite, Jmp, MemRead, MemWrite, IOD, LdDI, LIR, LTR, RegSel, BSel, RegWrite, PcSel, LdC, LdN, LdZ, WriteSel ;
 wire [1:0] AluOp , RegOrMem;
 wire [3:0] OpCode;
 
  
 Controller controller (clk, rst,Halt, PCWrite, Jmp, MemRead, MemWrite, IOD, LdDI, LIR, LTR, RegSel, 
                            BSel, RegWrite, PcSel, LdC, LdN, LdZ, WriteSel, AluOp ,  RegOrMem,  OpCode);
 DataPath dataPath(clk, rst,Halt, PCWrite, Jmp, MemRead, MemWrite, IOD, LdDI, LIR, LTR, RegSel, 
                            BSel, RegWrite, PcSel, LdC, LdN, LdZ, WriteSel, AluOp ,RegOrMem, OpCode);
  

endmodule 

module TB();
 reg clk = 0;
 reg rst = 0;
 initial begin
  #15 rst = 1;
  #17 rst = 0;
  repeat(1000) #10 clk = ~clk;
 end
 CPU cpu(clk,rst);
endmodule
