module TR(input clk, rst, input LTR, input [4:0] dataFromIR,  input[7:0] dataFromMem, output reg [12:0] TR);
  always@(posedge clk, posedge rst) begin
    if(rst)
      TR <= 13'b0;
    else
      if(LTR)
        TR <= {dataFromIR, dataFromMem};
      else
        TR <= TR;
  end
endmodule 

