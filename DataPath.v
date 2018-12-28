module DataPath(input clk, rst, input Halt, PCWrite, Jmp, MemRead, MemWrite, IOD, LdDI, LIR, LTR, RegSel, 
                            BSel, RegWrite, PcSel, LdC, LdN, LdZ, WriteSel,input[1:0] AluOp ,  input[1:0] RegOrMem, output [3:0] OpCode);
  
  wire [7:0] IR, MemOut;
  wire[12:0] TR;
  TR TempRegister(clk, rst, LTR, IR[4:0], MemOut, TR);
  
  
  wire [12:0] PCout;
  wire [12:0] PcPlus = PCout + 13'd1;
  wire [12:0] PCin; assign PCin = PcSel ? TR : PcPlus;
  wire PCUpdate;
  PC pc(clk, rst,PCUpdate , PCin, Halt, PCout);
  
  
  IR InstructionRegister(clk, rst, LIR, MemOut, IR);
  assign OpCode = IR[7:4]; 
  
  wire [4:0] DI;
  DI DIReg(clk, rst, LdDI, IR[4:0], DI);
  
  wire [7:0] Aci, Acj; // From Reg File 
  wire [7:0] AciIn, AcjIn;
  AC aci(clk, rst, AciIn, Aci);
  AC acj(clk, rst, AcjIn, Acj);

  
  wire Carry, Zero, Negative;
  wire C, Z, N;
  CZN czn(clk, rst, LdC, LdN, LdZ, Carry, Zero, Negative, C, Z, N);
  
  
  wire[7:0] AluOutput;
  wire [7:0] B; assign B = BSel ? MemOut : Acj;
  ALU alu(AluOp, Aci, B, C, AluOutput, Zero, Carry, Negative);

  wire [7:0] AluOut;
  ALUOut aluReg(clk, rst, AluOutput, AluOut);
  
  wire [1:0] ReadReg1; assign ReadReg1 = ~RegSel ? DI[4:3] : IR[3:2] ;
  wire [1:0] ReadReg2; assign ReadReg2 = IR[1:0];
  wire [1:0] WriteReg; assign WriteReg = ~WriteSel ? DI[4:3] : IR[3:2] ;
  wire [7:0] WriteData; assign WriteData = (RegOrMem == 2'b00) ? MemOut : (RegOrMem == 2'b01) ? AluOut : Acj;
  RegisterFile regFile(clk, RegWrite,ReadReg1, ReadReg2, WriteReg,  WriteData, AciIn, AcjIn);

  
  wire[12:0] MemAddress ; assign MemAddress = IOD ? TR : PCout ; 
  wire[7:0] WriteMemData; assign WriteMemData = Aci ; 
  Memory Mem(MemWrite, MemRead, WriteMemData, MemAddress, MemOut);
  
  wire NCond, ZCond, CCond, Cond, JmpWithCond;
  and(Cond, ~DI[1], ~DI[2], Jmp);
  and(NCond, DI[1], DI[2], N, Jmp);
  and(ZCond, ~DI[1], DI[2], Z, Jmp);
  and(CCond, DI[1], ~DI[2], C, Jmp);
  or(JmpWithCond, Cond, CCond, ZCond, NCond);
  assign PCUpdate = JmpWithCond | PCWrite;
  
  
endmodule