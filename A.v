
module AC(input clk, rst, input [7:0] dataIn, output reg [7:0] Aci);
  always@(posedge clk, posedge rst) begin
    if(rst)
      Aci <= 8'b0;
    else if(clk)
      Aci <= dataIn;
  end
endmodule 




