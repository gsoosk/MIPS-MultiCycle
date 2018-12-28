module IR(input clk, rst, input LIR, input [7:0] dataIn, output reg [7:0] IR);
  always@(posedge clk, posedge rst) begin
    if(rst)
      IR <= 8'b0;
    else
      if(LIR)
        IR <= dataIn;
      else
        IR <= IR;
  end
endmodule 
