module Memory (input MemWrite, MemRead,input [7:0] WriteData, input [12:0] Address, 
    output reg [7:0] ReadData);
	reg [7:0] Memory[0:8191];
	
	initial begin
	  Memory[3000] <= 0;
	  Memory[1000] <= 43;
	  Memory[1001] <= 250;
	  Memory[1002] <= 98;
	  Memory[1003] <= 87;
	  Memory[1004] <= 121;
	  Memory[1005] <= 150;
	  Memory[1006] <= 65;
	  Memory[1007] <= 91;
	  Memory[1008] <= 42;
	  Memory[1009] <= 27;
	  Memory[1010] <= 154;
	  // Ans : 0000 0100 0110 1000
	
	  
	end
	initial begin 
	 /* Memory[0] <= 8'b11100001; //LDI 1100
	  Memory[1] <= 8'b00000001; // LDA 300
	  Memory[2] <= 8'b00101100;
	  Memory[3] <= 8'b00100001; // STA 301
	  Memory[4] <= 8'b00101101;
	  Memory[5] <= 8'b01000001; //ADA 302
	  Memory[6] <= 8'b00101110;
	  Memory[7] <= 8'b01100001; // ANA 300
	  Memory[8] <= 8'b00101100;
	  Memory[9] <= 8'b10000100; // MVR 0 to 1
	  Memory[10] <= 8'b10010001; // ADR Ac0 <= Acj
	  Memory[11] <= 8'b10110001; // ORR
	  Memory[12] <= 8'b10100001; //ANR AC0 <= Ac1
	  Memory[13] <= 8'b11000010;//Jmp to 700
	  Memory[14] <= 8'b10111100;*/
	  Memory[0] <= 8'b11100010; //LDI 00 01
	  Memory[1] <= 8'b00001011; //Ac0 <= 3000
	  Memory[2] <= 8'b10111000;
	  Memory[3] <= 8'b10101000; //Ac2 <= Ac2 & Ac0
	  Memory[4] <= 8'b11101010; // LDI 01 01
	  Memory[5] <= 8'b00000011; //Ac1 <= (1000)
	  Memory[6] <= 8'b11101000;
	  Memory[7] <= 8'b01000011;//Ac1 <= (1001) + Ac1
	  Memory[8] <= 8'b11101001;
	  Memory[9]<= 8'b11000000; // JMPc to 14
	  Memory[10]<= 8'b00001110;
	  Memory[11] <= 8'b11101001; //LDI 01 00
	  Memory[12]<= 8'b11000000; // JMP to 15
	  Memory[13]<= 8'b00001111;
	  Memory[14] <= 8'b10011000; //Ac2 <= Ac2 + Ac0 + C(=1)
	  Memory[15] <= 8'b01000011;//Ac1 <= (1002) + Ac1
	  Memory[16] <= 8'b11101010;
	  Memory[17] <= 8'b11101010; //LDI 01 01
	  Memory[18] <= 8'b11000000; // JMPc to 23
	  Memory[19] <= 8'b00010111;
	  Memory[20] <= 8'b11101001; //LDI 01 00
	  Memory[21] <= 8'b11000000; // JMP to 24
	  Memory[22] <= 8'b00011000;
	  Memory[23] <= 8'b10011000; //Ac2 <= Ac2 + Ac0 + C(=1)
	  Memory[24] <= 8'b01000011;//Ac1 <= (1003) + Ac1
	  Memory[25] <= 8'b11101011;
	  Memory[26] <= 8'b11101010; //LDI 01 01
	  Memory[27] <= 8'b11000000; // JMPc to 32
	  Memory[28] <= 8'b00100000;
	  Memory[29] <= 8'b11101001; //LDI 01 00
	  Memory[30] <= 8'b11000000; // JMP to 33
	  Memory[31] <= 8'b00100001;
	  Memory[32] <= 8'b10011000; //Ac2 <= Ac2 + Ac0 + C(=1)
	  Memory[33] <= 8'b01000011;//Ac1 <= (1004) + Ac1
	  Memory[34] <= 8'b11101100;
	  Memory[35] <= 8'b11101010; //LDI 01 01
	  Memory[36] <= 8'b11000000; // JMPc to 41
	  Memory[37] <= 8'b00101001;
	  Memory[38] <= 8'b11101001; //LDI 01 00
	  Memory[39] <= 8'b11000000; // JMP to 42
	  Memory[40] <= 8'b00101010;
	  Memory[41] <= 8'b10011000; //Ac2 <= Ac2 + Ac0 + C(=1)
	  Memory[42] <= 8'b01000011;//Ac1 <= (1005) + Ac1
	  Memory[43] <= 8'b11101101;
	  Memory[44] <= 8'b11101010; //LDI 01 01
	  Memory[45] <= 8'b11000000; // JMPc to 50
	  Memory[46] <= 8'b00110010;
	  Memory[47] <= 8'b11101001; //LDI 01 00
	  Memory[48] <= 8'b11000000; // JMP to 51
	  Memory[49] <= 8'b00110011;
	  Memory[50] <= 8'b10011000; //Ac2 <= Ac2 + Ac0 + C(=1)
	  Memory[51] <= 8'b01000011;//Ac1 <= (1006) + Ac1
	  Memory[52] <= 8'b11101110;
	  Memory[53] <= 8'b11101010; //LDI 01 01
	  Memory[54] <= 8'b11000000; // JMPc to 59
	  Memory[55] <= 8'b00111011;
	  Memory[56] <= 8'b11101001; //LDI 01 00
	  Memory[57] <= 8'b11000000; // JMP to 60
	  Memory[58] <= 8'b00111100;
	  Memory[59] <= 8'b10011000; //Ac2 <= Ac2 + Ac0 + C(=1)
	  Memory[60] <= 8'b01000011;//Ac1 <= (1007) + Ac1
	  Memory[61] <= 8'b11101111;
	  Memory[62] <= 8'b11101010; //LDI 01 01
	  Memory[63] <= 8'b11000000; // JMPc to 68
	  Memory[64] <= 8'b01000100;
	  Memory[65] <= 8'b11101001; //LDI 01 00
	  Memory[66] <= 8'b11000000; // JMP to 69
	  Memory[67] <= 8'b01000101;
	  Memory[68] <= 8'b10011000; //Ac2 <= Ac2 + Ac0 + C(=1)
	  Memory[69] <= 8'b01000011;//Ac1 <= (1008) + Ac1
	  Memory[70] <= 8'b11110000;
	  Memory[71] <= 8'b11101010; //LDI 01 01
	  Memory[72] <= 8'b11000000; // JMPc to 77
	  Memory[73] <= 8'b01001101;
	  Memory[74] <= 8'b11101001; //LDI 01 00
	  Memory[75] <= 8'b11000000; // JMP to 78
	  Memory[76] <= 8'b01001110;
	  Memory[77] <= 8'b10011000; //Ac2 <= Ac2 + Ac0 + C(=1)
	  Memory[78] <= 8'b01000011;//Ac1 <= (1009) + Ac1
	  Memory[79] <= 8'b11110001;
	  Memory[80] <= 8'b11101010; //LDI 01 01
	  Memory[81] <= 8'b11000000; // JMPc to 86
	  Memory[82] <= 8'b01010110;
	  Memory[83] <= 8'b11101001; //LDI 01 00
	  Memory[84] <= 8'b11000000; // JMP to 87
	  Memory[85] <= 8'b01010111;
	  Memory[86] <= 8'b10011000; //Ac2 <= Ac2 + Ac0 + C(=1)
	  Memory[87] <= 8'b01000011;//Ac1 <= (1010) + Ac1
	  Memory[88] <= 8'b11110010;
	  Memory[89] <= 8'b11101010; //LDI 01 01
	  Memory[90] <= 8'b11000000; // JMPc to 95
	  Memory[91] <= 8'b01011111;
	  Memory[92] <= 8'b11101001; //LDI 01 00
	  Memory[93] <= 8'b11000000; // JMP to 96
	  Memory[94] <= 8'b01100000;
	  Memory[95] <= 8'b10011000; //Ac2 <= Ac2 + Ac0 + C(=1)
	  Memory[96] <= 8'b00100111;//(2000) <= Ac1
	  Memory[97] <= 8'b11010000;
	  Memory[98] <= 8'b11110000; //LDI 10 00
	  Memory[99] <= 8'b00100111;//(2001) <= Ac2
	  Memory[100] <= 8'b11010001;
	  
	  
	  
	  
	end
	always @ (MemWrite) begin
		if (MemWrite == 1)
			Memory[Address] <= WriteData;
	end

	always @(MemRead) begin
		if (MemRead == 1)
			ReadData <= Memory[Address];
	end
endmodule
