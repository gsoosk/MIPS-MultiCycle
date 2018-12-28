module ALU(input [1:0] AluOp, input [7:0] A, B, input CarryIn, output reg [7:0] AluOut,output reg Zero, Carry, Negative);
  
  always@(A, B, AluOp)
  begin
    Carry = 1'b0;
    case(AluOp)
      2'b00 : begin {Carry, AluOut} = A + B + CarryIn; end
      2'b01 : begin AluOut = A & B; end
      2'b10 : begin AluOut = A | B; end
    endcase
    Zero = (AluOut == 0 );
    Negative = (AluOut < 0 );
  end
endmodule 
