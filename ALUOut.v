module ALUOut(input clk, rst, input [7:0] dataIn, output reg [7:0] AluOut);
  always@(posedge clk, posedge rst) begin
    if(rst)
      AluOut <= 8'b0;
    else if(clk)
      AluOut <= dataIn;
  end
endmodule 



