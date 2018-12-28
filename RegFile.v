module RegisterFile(input clk, RegWrite, input [1:0] ReadReg1, ReadReg2, WriteReg, input [7:0] WriteData, 
  output [7:0] ReadData1, ReadData2);

	reg [7:0] Memory [0:3];
	

	assign ReadData1 = Memory[ReadReg1];
	assign ReadData2 = Memory[ReadReg2];

	always @(posedge clk)
		if (RegWrite)
			Memory[WriteReg] <= WriteData;
endmodule

