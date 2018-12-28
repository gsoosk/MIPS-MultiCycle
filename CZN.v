module CZN(input clk, rst, input LdC, LdN, LdZ, input Carry, Zero, Negative, output reg C, Z, N);
  always@(posedge clk, posedge rst) begin
    if(rst)
    begin
      C <= 1'b0;
      Z <= 1'b0;
      N <= 1'b0;
    end
    else 
    begin
      if(LdC)
        C <= Carry;
      else
        C <= C;
      if(LdZ)
        Z <= Zero;
      else
        Z <= Z;
      if(LdN)
        N <= Negative;
      else
        N <= N;
    end
  end
endmodule 

