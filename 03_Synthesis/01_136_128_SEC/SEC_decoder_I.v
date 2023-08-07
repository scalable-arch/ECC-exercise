module SEC_decoder_I(input [135:0] codeword, output [127:0] message);

	wire[7:0] syndrome;
	reg[135:0] decoded;

	assign syndrome[7] = ^(codeword&136'b01010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101_10000000);
	assign syndrome[6] = ^(codeword&136'b00110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011_01000000);
	assign syndrome[5] = ^(codeword&136'b00001111000011110000111100001111000011110000111100001111000011110000111100001111000011110000111100001111000011110000111100001111_00100000);
	assign syndrome[4] = ^(codeword&136'b11111111000000001111111100000000000000001111111111111111000000001111111100000000000000001111111111111111000000000000000011111111_00010000);
	assign syndrome[3] = ^(codeword&136'b11111111000000000000000011111111111111110000000011111111000000000000000011111111111111110000000011111111000000000000000011111111_00001000);
	assign syndrome[2] = ^(codeword&136'b00000000111111111111111100000000111111110000000011111111000000000000000011111111000000001111111100000000111111111111111100000000_00000100);
	assign syndrome[1] = ^(codeword&136'b00000000111111110000000011111111000000001111111100000000111111111111111100000000111111110000000011111111000000001111111100000000_00000010);
	assign syndrome[0] = ^(codeword&136'b00000000111111110000000011111111000000001111111100000000111111110000000011111111000000001111111100000000111111110000000011111111_00000001);

	always @(syndrome) begin
	case(syndrome)
	        8'b00011000:begin decoded = codeword^(1'b1<<135); end
                8'b10011000:begin decoded = codeword^(1'b1<<134); end
                8'b01011000:begin decoded = codeword^(1'b1<<133); end
                8'b11011000:begin decoded = codeword^(1'b1<<132); end
                8'b00111000:begin decoded = codeword^(1'b1<<131); end
                8'b10111000:begin decoded = codeword^(1'b1<<130); end
                8'b01111000:begin decoded = codeword^(1'b1<<129); end
                8'b11111000:begin decoded = codeword^(1'b1<<128); end
                8'b00000111:begin decoded = codeword^(1'b1<<127); end
                8'b10000111:begin decoded = codeword^(1'b1<<126); end
                8'b01000111:begin decoded = codeword^(1'b1<<125); end
                8'b11000111:begin decoded = codeword^(1'b1<<124); end
                8'b00100111:begin decoded = codeword^(1'b1<<123); end
                8'b10100111:begin decoded = codeword^(1'b1<<122); end
                8'b01100111:begin decoded = codeword^(1'b1<<121); end
                8'b11100111:begin decoded = codeword^(1'b1<<120); end
                8'b00010100:begin decoded = codeword^(1'b1<<119); end
                8'b10010100:begin decoded = codeword^(1'b1<<118); end
                8'b01010100:begin decoded = codeword^(1'b1<<117); end
                8'b11010100:begin decoded = codeword^(1'b1<<116); end
                8'b00110100:begin decoded = codeword^(1'b1<<115); end
                8'b10110100:begin decoded = codeword^(1'b1<<114); end
                8'b01110100:begin decoded = codeword^(1'b1<<113); end
                8'b11110100:begin decoded = codeword^(1'b1<<112); end
                8'b00001011:begin decoded = codeword^(1'b1<<111); end
                8'b10001011:begin decoded = codeword^(1'b1<<110); end
                8'b01001011:begin decoded = codeword^(1'b1<<109); end
                8'b11001011:begin decoded = codeword^(1'b1<<108); end
                8'b00101011:begin decoded = codeword^(1'b1<<107); end
                8'b10101011:begin decoded = codeword^(1'b1<<106); end
                8'b01101011:begin decoded = codeword^(1'b1<<105); end
                8'b11101011:begin decoded = codeword^(1'b1<<104); end
                8'b00001100:begin decoded = codeword^(1'b1<<103); end
                8'b10001100:begin decoded = codeword^(1'b1<<102); end
                8'b01001100:begin decoded = codeword^(1'b1<<101); end
                8'b11001100:begin decoded = codeword^(1'b1<<100); end
                8'b00101100:begin decoded = codeword^(1'b1<<99); end
                8'b10101100:begin decoded = codeword^(1'b1<<98); end
                8'b01101100:begin decoded = codeword^(1'b1<<97); end
                8'b11101100:begin decoded = codeword^(1'b1<<96); end
                8'b00010011:begin decoded = codeword^(1'b1<<95); end
                8'b10010011:begin decoded = codeword^(1'b1<<94); end
                8'b01010011:begin decoded = codeword^(1'b1<<93); end
                8'b11010011:begin decoded = codeword^(1'b1<<92); end
                8'b00110011:begin decoded = codeword^(1'b1<<91); end
                8'b10110011:begin decoded = codeword^(1'b1<<90); end
                8'b01110011:begin decoded = codeword^(1'b1<<89); end
                8'b11110011:begin decoded = codeword^(1'b1<<88); end
                8'b00011100:begin decoded = codeword^(1'b1<<87); end
                8'b10011100:begin decoded = codeword^(1'b1<<86); end
                8'b01011100:begin decoded = codeword^(1'b1<<85); end
                8'b11011100:begin decoded = codeword^(1'b1<<84); end
                8'b00111100:begin decoded = codeword^(1'b1<<83); end
                8'b10111100:begin decoded = codeword^(1'b1<<82); end
                8'b01111100:begin decoded = codeword^(1'b1<<81); end
                8'b11111100:begin decoded = codeword^(1'b1<<80); end
                8'b00000011:begin decoded = codeword^(1'b1<<79); end
                8'b10000011:begin decoded = codeword^(1'b1<<78); end
                8'b01000011:begin decoded = codeword^(1'b1<<77); end
                8'b11000011:begin decoded = codeword^(1'b1<<76); end
                8'b00100011:begin decoded = codeword^(1'b1<<75); end
                8'b10100011:begin decoded = codeword^(1'b1<<74); end
                8'b01100011:begin decoded = codeword^(1'b1<<73); end
                8'b11100011:begin decoded = codeword^(1'b1<<72); end
                8'b00010010:begin decoded = codeword^(1'b1<<71); end
                8'b10010010:begin decoded = codeword^(1'b1<<70); end
                8'b01010010:begin decoded = codeword^(1'b1<<69); end
                8'b11010010:begin decoded = codeword^(1'b1<<68); end
                8'b00110010:begin decoded = codeword^(1'b1<<67); end
                8'b10110010:begin decoded = codeword^(1'b1<<66); end
                8'b01110010:begin decoded = codeword^(1'b1<<65); end
                8'b11110010:begin decoded = codeword^(1'b1<<64); end
                8'b00001101:begin decoded = codeword^(1'b1<<63); end
                8'b10001101:begin decoded = codeword^(1'b1<<62); end
                8'b01001101:begin decoded = codeword^(1'b1<<61); end
                8'b11001101:begin decoded = codeword^(1'b1<<60); end
                8'b00101101:begin decoded = codeword^(1'b1<<59); end
                8'b10101101:begin decoded = codeword^(1'b1<<58); end
                8'b01101101:begin decoded = codeword^(1'b1<<57); end
                8'b11101101:begin decoded = codeword^(1'b1<<56); end
                8'b00001010:begin decoded = codeword^(1'b1<<55); end
                8'b10001010:begin decoded = codeword^(1'b1<<54); end
                8'b01001010:begin decoded = codeword^(1'b1<<53); end
                8'b11001010:begin decoded = codeword^(1'b1<<52); end
                8'b00101010:begin decoded = codeword^(1'b1<<51); end
                8'b10101010:begin decoded = codeword^(1'b1<<50); end
                8'b01101010:begin decoded = codeword^(1'b1<<49); end
                8'b11101010:begin decoded = codeword^(1'b1<<48); end
                8'b00010101:begin decoded = codeword^(1'b1<<47); end
                8'b10010101:begin decoded = codeword^(1'b1<<46); end
                8'b01010101:begin decoded = codeword^(1'b1<<45); end
                8'b11010101:begin decoded = codeword^(1'b1<<44); end
                8'b00110101:begin decoded = codeword^(1'b1<<43); end
                8'b10110101:begin decoded = codeword^(1'b1<<42); end
                8'b01110101:begin decoded = codeword^(1'b1<<41); end
                8'b11110101:begin decoded = codeword^(1'b1<<40); end
                8'b00011010:begin decoded = codeword^(1'b1<<39); end
                8'b10011010:begin decoded = codeword^(1'b1<<38); end
                8'b01011010:begin decoded = codeword^(1'b1<<37); end
                8'b11011010:begin decoded = codeword^(1'b1<<36); end
                8'b00111010:begin decoded = codeword^(1'b1<<35); end
                8'b10111010:begin decoded = codeword^(1'b1<<34); end
                8'b01111010:begin decoded = codeword^(1'b1<<33); end
                8'b11111010:begin decoded = codeword^(1'b1<<32); end
                8'b00000101:begin decoded = codeword^(1'b1<<31); end
                8'b10000101:begin decoded = codeword^(1'b1<<30); end
                8'b01000101:begin decoded = codeword^(1'b1<<29); end
                8'b11000101:begin decoded = codeword^(1'b1<<28); end
                8'b00100101:begin decoded = codeword^(1'b1<<27); end
                8'b10100101:begin decoded = codeword^(1'b1<<26); end
                8'b01100101:begin decoded = codeword^(1'b1<<25); end
                8'b11100101:begin decoded = codeword^(1'b1<<24); end
                8'b00000110:begin decoded = codeword^(1'b1<<23); end
                8'b10000110:begin decoded = codeword^(1'b1<<22); end
                8'b01000110:begin decoded = codeword^(1'b1<<21); end
                8'b11000110:begin decoded = codeword^(1'b1<<20); end
                8'b00100110:begin decoded = codeword^(1'b1<<19); end
                8'b10100110:begin decoded = codeword^(1'b1<<18); end
                8'b01100110:begin decoded = codeword^(1'b1<<17); end
                8'b11100110:begin decoded = codeword^(1'b1<<16); end
                8'b00011001:begin decoded = codeword^(1'b1<<15); end
                8'b10011001:begin decoded = codeword^(1'b1<<14); end
                8'b01011001:begin decoded = codeword^(1'b1<<13); end
                8'b11011001:begin decoded = codeword^(1'b1<<12); end
                8'b00111001:begin decoded = codeword^(1'b1<<11); end
                8'b10111001:begin decoded = codeword^(1'b1<<10); end
                8'b01111001:begin decoded = codeword^(1'b1<<9); end
                8'b11111001:begin decoded = codeword^(1'b1<<8); end
                8'b10000000:begin decoded = codeword^(1'b1<<7); end
                8'b01000000:begin decoded = codeword^(1'b1<<6); end
                8'b00100000:begin decoded = codeword^(1'b1<<5); end
                8'b00010000:begin decoded = codeword^(1'b1<<4); end
                8'b00001000:begin decoded = codeword^(1'b1<<3); end
                8'b00000100:begin decoded = codeword^(1'b1<<2); end
                8'b00000010:begin decoded = codeword^(1'b1<<1); end
                8'b00000001:begin decoded = codeword^(1'b1<<0); end

		default: begin decoded = codeword; end
	endcase
	end
	assign message = decoded[135:8];


endmodule


