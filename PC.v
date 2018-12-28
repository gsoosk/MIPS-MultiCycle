module PC(input clk, rst, input PCWrite, input  [12:0] PCin, input Halt,output reg [12:0]PCout);
	always @(posedge clk, posedge rst) begin
		if (rst == 1)
			PCout <= 1'b0;
		else
		  if(Halt)
		    PCout <= PCout;
		  else if(PCWrite)
			  PCout <= PCin ;
	end
endmodule

