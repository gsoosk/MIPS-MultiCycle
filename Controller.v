module Controller( input clk, rst, output reg Halt, PCWrite, Jmp, MemRead, MemWrite, IOD, LdDI, LIR, LTR, RegSel, 
                            BSel, RegWrite, PcSel, LdC, LdN, LdZ, WriteSel,output reg[1:0] AluOp ,  output reg[1:0] RegOrMem, input [3:0] OPCode);

  reg[4:0] ns, ps;
  parameter [4:0] IF1 = 5'd0, IF2 = 5'd2, DI = 5'd3, JMP = 5'd4, LDA1 = 5'd5, LDA2 = 5'd6, STA1 = 5'd7, STA2 = 5'd8,
            ADNA = 5'd9, CALADA = 5'd10, CALANA = 5'd11, SAVEREG1 = 5'd12, ACCDECODE = 5'd13, MVR = 5'd14, ADR = 5'd15,
            SAVEREG2 = 5'd16, ANR = 5'd17, ORR = 5'd18, HALT = 5'd19, ID1 = 5'd20, ID2 = 5'd21;
  
  
  always@(ps)begin
    ns = 5'b0;
    case(ps)
      IF1 : ns = ID1;
      ID1 : ns = (OPCode[3:1] == 3'b000 | OPCode[3:1] == 3'b001 | OPCode[3:1] == 3'b010 | OPCode[3:1] == 3'b011 | OPCode[3:1] == 3'b110) 
                ? IF2 : (OPCode[3:1] == 3'b111) ? DI : (OPCode == 4'b1000 | OPCode == 4'b1001 | OPCode == 4'b1010 | OPCode == 4'b1011)? ACCDECODE : HALT;
      IF2 : ns = ID2;
      ID2 : ns = (OPCode[3:1] == 3'b000) ? LDA1 : (OPCode[3:1] == 3'b001) ? STA1 :(OPCode[3:1] == 3'b110)?JMP : ADNA;
      DI : ns = IF1;
      JMP : ns = IF1;
      LDA1 : ns = LDA2;
      LDA2 : ns = IF1;
      STA1 : ns = STA2;
      STA2 : ns = IF1;
      ADNA : ns = (OPCode[3:1] == 3'b010) ? CALADA : CALANA ;
      CALADA : ns = SAVEREG1;
      CALANA : ns = SAVEREG1;
      SAVEREG1 : ns = IF1;
      ACCDECODE : ns = (OPCode == 4'b1000) ? MVR : (OPCode == 4'b1001) ? ADR : (OPCode == 4'b1010) ? ANR : ORR;
      MVR : ns = IF1;
      ADR : ns = SAVEREG2;
      ANR : ns = SAVEREG2;
      ORR : ns = SAVEREG2;
      SAVEREG2 : ns = IF1;
      HALT : ns = HALT;
      default : ns = IF1;
    endcase
  end

  always@(ps)begin
    Halt = 0 ;PCWrite = 0; Jmp = 0; MemRead = 0; MemWrite = 0; IOD = 0; LdDI = 0; LIR = 0; LTR = 0; RegSel = 0; 
    BSel = 0; RegWrite = 0; PcSel = 0; LdC = 0;LdN = 0; LdZ = 0; WriteSel = 0; AluOp = 2'b00 ; RegOrMem =  2'b0;
    case(ps)
      IF1 : begin IOD = 0 ; MemRead = 1; LIR = 1 ; PcSel = 0 ; PCWrite = 1; AluOp = 2'b00; end
      IF2 : begin IOD = 0 ; MemRead = 1; LTR = 1 ; PcSel = 0 ; PCWrite = 1; AluOp = 2'b00; end
      DI :  begin LdDI = 1 ; end
      JMP : begin Jmp = 1; PcSel = 1; end
      LDA1: begin IOD = 1; MemRead = 1; RegOrMem = 2'b00; end
      LDA2 : begin WriteSel = 0; RegWrite = 1; RegOrMem = 2'b00; RegWrite=1; end
      STA1 : begin RegSel = 0; end
      STA2 : begin MemWrite = 1; IOD = 1;end
      ADNA : begin RegSel = 0 ; MemRead = 1; IOD = 1; BSel = 1;end
      CALADA : begin BSel = 1; AluOp = 2'b00; LdC = 1; LdN = 1; LdZ = 1;end
      CALANA : begin BSel = 1; AluOp = 2'b01; LdN = 1; LdZ = 1;end
      SAVEREG1 : begin RegOrMem = 1; WriteSel = 0 ; RegWrite = 1 ;end
      ACCDECODE : begin RegSel = 1 ; end 
      MVR : begin RegWrite = 1; RegOrMem = 2'b10; WriteSel = 1; end
      ADR : begin BSel = 0 ; AluOp = 2'b00; LdC = 1; LdN = 1; LdZ = 1; end
      ANR : begin BSel = 0 ; AluOp = 2'b01; LdN = 1; LdZ = 1; end
      ORR : begin BSel = 0 ; AluOp = 2'b10; LdN = 1; LdZ = 1; end
      SAVEREG2 : begin RegOrMem = 2'b01; WriteSel = 1 ; RegWrite = 1; end
      default : begin Halt = 0 ;PCWrite = 0; Jmp = 0; MemRead = 0; MemWrite = 0; IOD = 0; LdDI = 0; LIR = 0; LTR = 0; RegSel = 0; 
                      BSel = 0; RegWrite = 0; PcSel = 0; LdC = 0;LdN = 0; LdZ = 0; WriteSel = 0; AluOp = 2'b00 ; RegOrMem =  2'b0; end
    endcase
    
  end
  
  always@(posedge clk, posedge rst) begin
    if(rst)
      ps <= 5'b0;
    else if(clk)
      ps <= ns;
  end
      


endmodule
