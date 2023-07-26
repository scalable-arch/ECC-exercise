module SmartECC_encoder(input [10:0] message, output [14:0] codeword);

	assign codeword[10:0] = message[10:0];
	assign codeword[11] = ^(message&11'b00110101111);
	assign codeword[12] = ^(message&11'b01101011110);
	assign codeword[13] = ^(message&11'b11010111100);
	assign codeword[14] = ^(message&11'b10011010111);

endmodule

