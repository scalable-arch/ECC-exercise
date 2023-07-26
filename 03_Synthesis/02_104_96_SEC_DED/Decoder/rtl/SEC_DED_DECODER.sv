module SEC_DED_DECODER(input [103:0] codeword_in, output decode_result_out ,output [95:0] data_out);

        /*
                (104, 96) SEC-DED HSIAO code
                NE 'or' CE -> decode_result_out =0 
                DUE        -> decode_result_out = 1
        */

	wire[7:0] syndrome;
        reg decode_result;
	reg[135:0] decoded;

	assign syndrome[7] = ^(codeword_in&104'b111111111111111111111000000000000000000000000000000000001111111111111111111111111111111111100000_10000000);
	assign syndrome[6] = ^(codeword_in&104'b111111000000000000000111111111111111000000000000000000001111111111111111111100000000000000011111_01000000);
	assign syndrome[5] = ^(codeword_in&104'b100000111110000000000111110000000000111111111100000000001111111111000000000011111111110000011111_00100000);
	assign syndrome[4] = ^(codeword_in&104'b010000100001111000000100001111000000111100000011111100001111000000111111000011111100001111011111_00010000);
	assign syndrome[3] = ^(codeword_in&104'b001000010001000111000010001000111000100011100011100011101000111000111000111011100011101110111100_00001000);
	assign syndrome[2] = ^(codeword_in&104'b000100001000100100110001000100100110010010011010011011010100100110100110110110011011011101110011_00000100);
	assign syndrome[1] = ^(codeword_in&104'b000010000100010010101000100010010101001001010101010110110010010101010101101101010110111011101010_00000010);
	assign syndrome[0] = ^(codeword_in&104'b000001000010001001011000010001001011000100101100101101110001001011001011011100101101110111100101_00000001);

	always_comb begin
                case(syndrome)
                        // CE 104가지
                        8'b11100000:begin decoded = codeword_in^(1'b1<<103); decode_result=1'b0;  end
                        8'b11010000:begin decoded = codeword_in^(1'b1<<102); decode_result=1'b0;  end
                        8'b11001000:begin decoded = codeword_in^(1'b1<<101); decode_result=1'b0;  end
                        8'b11000100:begin decoded = codeword_in^(1'b1<<100); decode_result=1'b0;  end
                        8'b11000010:begin decoded = codeword_in^(1'b1<<99); decode_result=1'b0;  end
                        8'b11000001:begin decoded = codeword_in^(1'b1<<98); decode_result=1'b0;  end
                        8'b10110000:begin decoded = codeword_in^(1'b1<<97); decode_result=1'b0;  end
                        8'b10101000:begin decoded = codeword_in^(1'b1<<96); decode_result=1'b0;  end
                        8'b10100100:begin decoded = codeword_in^(1'b1<<95); decode_result=1'b0;  end
                        8'b10100010:begin decoded = codeword_in^(1'b1<<94); decode_result=1'b0;  end
                        8'b10100001:begin decoded = codeword_in^(1'b1<<93); decode_result=1'b0;  end
                        8'b10011000:begin decoded = codeword_in^(1'b1<<92); decode_result=1'b0;  end
                        8'b10010100:begin decoded = codeword_in^(1'b1<<91); decode_result=1'b0;  end
                        8'b10010010:begin decoded = codeword_in^(1'b1<<90); decode_result=1'b0;  end
                        8'b10010001:begin decoded = codeword_in^(1'b1<<89); decode_result=1'b0;  end
                        8'b10001100:begin decoded = codeword_in^(1'b1<<88); decode_result=1'b0;  end
                        8'b10001010:begin decoded = codeword_in^(1'b1<<87); decode_result=1'b0;  end
                        8'b10001001:begin decoded = codeword_in^(1'b1<<86); decode_result=1'b0;  end
                        8'b10000110:begin decoded = codeword_in^(1'b1<<85); decode_result=1'b0;  end
                        8'b10000101:begin decoded = codeword_in^(1'b1<<84); decode_result=1'b0;  end
                        8'b10000011:begin decoded = codeword_in^(1'b1<<83); decode_result=1'b0;  end
                        8'b01110000:begin decoded = codeword_in^(1'b1<<82); decode_result=1'b0;  end
                        8'b01101000:begin decoded = codeword_in^(1'b1<<81); decode_result=1'b0;  end
                        8'b01100100:begin decoded = codeword_in^(1'b1<<80); decode_result=1'b0;  end
                        8'b01100010:begin decoded = codeword_in^(1'b1<<79); decode_result=1'b0;  end
                        8'b01100001:begin decoded = codeword_in^(1'b1<<78); decode_result=1'b0;  end
                        8'b01011000:begin decoded = codeword_in^(1'b1<<77); decode_result=1'b0;  end
                        8'b01010100:begin decoded = codeword_in^(1'b1<<76); decode_result=1'b0;  end
                        8'b01010010:begin decoded = codeword_in^(1'b1<<75); decode_result=1'b0;  end
                        8'b01010001:begin decoded = codeword_in^(1'b1<<74); decode_result=1'b0;  end
                        8'b01001100:begin decoded = codeword_in^(1'b1<<73); decode_result=1'b0;  end
                        8'b01001010:begin decoded = codeword_in^(1'b1<<72); decode_result=1'b0;  end
                        8'b01001001:begin decoded = codeword_in^(1'b1<<71); decode_result=1'b0;  end
                        8'b01000110:begin decoded = codeword_in^(1'b1<<70); decode_result=1'b0;  end
                        8'b01000101:begin decoded = codeword_in^(1'b1<<69); decode_result=1'b0;  end
                        8'b01000011:begin decoded = codeword_in^(1'b1<<68); decode_result=1'b0;  end
                        8'b00111000:begin decoded = codeword_in^(1'b1<<67); decode_result=1'b0;  end
                        8'b00110100:begin decoded = codeword_in^(1'b1<<66); decode_result=1'b0;  end
                        8'b00110010:begin decoded = codeword_in^(1'b1<<65); decode_result=1'b0;  end
                        8'b00110001:begin decoded = codeword_in^(1'b1<<64); decode_result=1'b0;  end
                        8'b00101100:begin decoded = codeword_in^(1'b1<<63); decode_result=1'b0;  end
                        8'b00101010:begin decoded = codeword_in^(1'b1<<62); decode_result=1'b0;  end
                        8'b00101001:begin decoded = codeword_in^(1'b1<<61); decode_result=1'b0;  end
                        8'b00100110:begin decoded = codeword_in^(1'b1<<60); decode_result=1'b0;  end
                        8'b00100101:begin decoded = codeword_in^(1'b1<<59); decode_result=1'b0;  end
                        8'b00100011:begin decoded = codeword_in^(1'b1<<58); decode_result=1'b0;  end
                        8'b00011100:begin decoded = codeword_in^(1'b1<<57); decode_result=1'b0;  end
                        8'b00011010:begin decoded = codeword_in^(1'b1<<56); decode_result=1'b0;  end
                        8'b00011001:begin decoded = codeword_in^(1'b1<<55); decode_result=1'b0;  end
                        8'b00010110:begin decoded = codeword_in^(1'b1<<54); decode_result=1'b0;  end
                        8'b00010101:begin decoded = codeword_in^(1'b1<<53); decode_result=1'b0;  end
                        8'b00010011:begin decoded = codeword_in^(1'b1<<52); decode_result=1'b0;  end
                        8'b00001110:begin decoded = codeword_in^(1'b1<<51); decode_result=1'b0;  end
                        8'b00001101:begin decoded = codeword_in^(1'b1<<50); decode_result=1'b0;  end
                        8'b00001011:begin decoded = codeword_in^(1'b1<<49); decode_result=1'b0;  end
                        8'b00000111:begin decoded = codeword_in^(1'b1<<48); decode_result=1'b0;  end
                        8'b11111000:begin decoded = codeword_in^(1'b1<<47); decode_result=1'b0;  end
                        8'b11110100:begin decoded = codeword_in^(1'b1<<46); decode_result=1'b0;  end
                        8'b11110010:begin decoded = codeword_in^(1'b1<<45); decode_result=1'b0;  end
                        8'b11110001:begin decoded = codeword_in^(1'b1<<44); decode_result=1'b0;  end
                        8'b11101100:begin decoded = codeword_in^(1'b1<<43); decode_result=1'b0;  end
                        8'b11101010:begin decoded = codeword_in^(1'b1<<42); decode_result=1'b0;  end
                        8'b11101001:begin decoded = codeword_in^(1'b1<<41); decode_result=1'b0;  end
                        8'b11100110:begin decoded = codeword_in^(1'b1<<40); decode_result=1'b0;  end
                        8'b11100101:begin decoded = codeword_in^(1'b1<<39); decode_result=1'b0;  end
                        8'b11100011:begin decoded = codeword_in^(1'b1<<38); decode_result=1'b0;  end
                        8'b11011100:begin decoded = codeword_in^(1'b1<<37); decode_result=1'b0;  end
                        8'b11011010:begin decoded = codeword_in^(1'b1<<36); decode_result=1'b0;  end
                        8'b11011001:begin decoded = codeword_in^(1'b1<<35); decode_result=1'b0;  end
                        8'b11010110:begin decoded = codeword_in^(1'b1<<34); decode_result=1'b0;  end
                        8'b11010101:begin decoded = codeword_in^(1'b1<<33); decode_result=1'b0;  end
                        8'b11010011:begin decoded = codeword_in^(1'b1<<32); decode_result=1'b0;  end
                        8'b11001110:begin decoded = codeword_in^(1'b1<<31); decode_result=1'b0;  end
                        8'b11001101:begin decoded = codeword_in^(1'b1<<30); decode_result=1'b0;  end
                        8'b11001011:begin decoded = codeword_in^(1'b1<<29); decode_result=1'b0;  end
                        8'b11000111:begin decoded = codeword_in^(1'b1<<28); decode_result=1'b0;  end
                        8'b10111100:begin decoded = codeword_in^(1'b1<<27); decode_result=1'b0;  end
                        8'b10111010:begin decoded = codeword_in^(1'b1<<26); decode_result=1'b0;  end
                        8'b10111001:begin decoded = codeword_in^(1'b1<<25); decode_result=1'b0;  end
                        8'b10110110:begin decoded = codeword_in^(1'b1<<24); decode_result=1'b0;  end
                        8'b10110101:begin decoded = codeword_in^(1'b1<<23); decode_result=1'b0;  end
                        8'b10110011:begin decoded = codeword_in^(1'b1<<22); decode_result=1'b0;  end
                        8'b10101110:begin decoded = codeword_in^(1'b1<<21); decode_result=1'b0;  end
                        8'b10101101:begin decoded = codeword_in^(1'b1<<20); decode_result=1'b0;  end
                        8'b10101011:begin decoded = codeword_in^(1'b1<<19); decode_result=1'b0;  end
                        8'b10100111:begin decoded = codeword_in^(1'b1<<18); decode_result=1'b0;  end
                        8'b10011110:begin decoded = codeword_in^(1'b1<<17); decode_result=1'b0;  end
                        8'b10011101:begin decoded = codeword_in^(1'b1<<16); decode_result=1'b0;  end
                        8'b10011011:begin decoded = codeword_in^(1'b1<<15); decode_result=1'b0;  end
                        8'b10010111:begin decoded = codeword_in^(1'b1<<14); decode_result=1'b0;  end
                        8'b10001111:begin decoded = codeword_in^(1'b1<<13); decode_result=1'b0;  end
                        8'b01111100:begin decoded = codeword_in^(1'b1<<12); decode_result=1'b0;  end
                        8'b01111010:begin decoded = codeword_in^(1'b1<<11); decode_result=1'b0;  end
                        8'b01111001:begin decoded = codeword_in^(1'b1<<10); decode_result=1'b0;  end
                        8'b01110110:begin decoded = codeword_in^(1'b1<<9); decode_result=1'b0;  end
                        8'b01110101:begin decoded = codeword_in^(1'b1<<8); decode_result=1'b0;  end
                        8'b10000000:begin decoded = codeword_in^(1'b1<<7); decode_result=1'b0;  end
                        8'b01000000:begin decoded = codeword_in^(1'b1<<6); decode_result=1'b0;  end
                        8'b00100000:begin decoded = codeword_in^(1'b1<<5); decode_result=1'b0;  end
                        8'b00010000:begin decoded = codeword_in^(1'b1<<4); decode_result=1'b0;  end
                        8'b00001000:begin decoded = codeword_in^(1'b1<<3); decode_result=1'b0;  end
                        8'b00000100:begin decoded = codeword_in^(1'b1<<2); decode_result=1'b0;  end
                        8'b00000010:begin decoded = codeword_in^(1'b1<<1); decode_result=1'b0;  end
                        8'b00000001:begin decoded = codeword_in^(1'b1<<0); decode_result=1'b0;  end
                        // NE
                        8'b00000000:begin decoded = codeword_in; decode_result=1'b0;  end
                        // DUE
                        default: begin decoded = codeword_in; decode_result=1'b1; end
                endcase
        end
        assign decode_result_out = decode_result;
	assign data_out = decoded[135:8];


endmodule



