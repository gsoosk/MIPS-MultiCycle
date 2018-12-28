module DI(input clk, rst, input LdDI, input [4:0] dataIn, output reg [4:0] DI);
  always@(posedge clk, posedge rst) begin
    if(rst)
      DI <= 5'b0;
    else 
      if(LdDI)
        DI <= dataIn;
      else
        DI <= DI;
  end
endmodule 

