module SECBADAEC_syndrome_gen(input [135:0] codeword, output [7:0] syndrome);

	assign syndrome[7] = ^(codeword&136'b11011001001011010101010111011010010001110010001000100100001010011110101101000010010001011001000101111110100000100101111111001100_10000000);
	assign syndrome[6] = ^(codeword&136'b10110011010110101010101110110100100011100100010001001000010100111101011110000101100010110010001111111101000001001011111010011000_01000000);
	assign syndrome[5] = ^(codeword&136'b10111110100110000000001010110011010110101010101110110100100011100100010001001000010100111101011110000101100010110010001111111101_00100000);
	assign syndrome[4] = ^(codeword&136'b10100101000111000101000010111101111100100111010101001101001101000110001011010010111000100011111001110100100101000001100100110111_00010000);
	assign syndrome[3] = ^(codeword&136'b01001011001110011010000001111011111001011110101010011011011010001100010010100100110001010111110111101000001010000011001001101111_00001000);
	assign syndrome[2] = ^(codeword&136'b10010111011100110100000011110110110010111101010100110110110100011000100001001001100010101111101011010000010100010110010011011111_00000100);
	assign syndrome[1] = ^(codeword&136'b11110110110010111101010100110110110100011000100001001001100010101111101011010000010100010110010011011111001000001001011101110011_00000010);
	assign syndrome[0] = ^(codeword&136'b11101100100101101010101001101101101000110001000110010010000101001111010110100001101000101100100010111111010000010010111111100110_00000001);

endmodule


module SECBADAEC_errorinfo_gen(input [7:0] syndrome, output reg [7:0] error_addr, output reg [1:0] error_type);

	always @(syndrome) begin
	case(syndrome)
		8'b11110111:begin error_type = 2'b01; error_addr = 8'd136; end
		8'b10001011:begin error_type = 2'b01; error_addr = 8'd135; end
		8'b01110011:begin error_type = 2'b01; error_addr = 8'd134; end
		8'b11100110:begin error_type = 2'b01; error_addr = 8'd133; end
		8'b10101001:begin error_type = 2'b01; error_addr = 8'd132; end
		8'b00110111:begin error_type = 2'b01; error_addr = 8'd131; end
		8'b01101110:begin error_type = 2'b01; error_addr = 8'd130; end
		8'b11011100:begin error_type = 2'b01; error_addr = 8'd129; end
		8'b00100011:begin error_type = 2'b01; error_addr = 8'd128; end
		8'b01000110:begin error_type = 2'b01; error_addr = 8'd127; end
		8'b10001100:begin error_type = 2'b01; error_addr = 8'd126; end
		8'b01111101:begin error_type = 2'b01; error_addr = 8'd125; end
		8'b11111010:begin error_type = 2'b01; error_addr = 8'd124; end
		8'b10010001:begin error_type = 2'b01; error_addr = 8'd123; end
		8'b01000111:begin error_type = 2'b01; error_addr = 8'd122; end
		8'b10001110:begin error_type = 2'b01; error_addr = 8'd121; end
		8'b01001011:begin error_type = 2'b01; error_addr = 8'd120; end
		8'b10010110:begin error_type = 2'b01; error_addr = 8'd119; end
		8'b01001001:begin error_type = 2'b01; error_addr = 8'd118; end
		8'b10010010:begin error_type = 2'b01; error_addr = 8'd117; end
		8'b01000001:begin error_type = 2'b01; error_addr = 8'd116; end
		8'b10000010:begin error_type = 2'b01; error_addr = 8'd115; end
		8'b01100001:begin error_type = 2'b01; error_addr = 8'd114; end
		8'b11000010:begin error_type = 2'b01; error_addr = 8'd113; end
		8'b11110100:begin error_type = 2'b01; error_addr = 8'd112; end
		8'b10001101:begin error_type = 2'b01; error_addr = 8'd111; end
		8'b01111111:begin error_type = 2'b01; error_addr = 8'd110; end
		8'b11111110:begin error_type = 2'b01; error_addr = 8'd109; end
		8'b10011001:begin error_type = 2'b01; error_addr = 8'd108; end
		8'b01010111:begin error_type = 2'b01; error_addr = 8'd107; end
		8'b10101110:begin error_type = 2'b01; error_addr = 8'd106; end
		8'b00111001:begin error_type = 2'b01; error_addr = 8'd105; end
		8'b01011111:begin error_type = 2'b01; error_addr = 8'd104; end
		8'b10111110:begin error_type = 2'b01; error_addr = 8'd103; end
		8'b00011001:begin error_type = 2'b01; error_addr = 8'd102; end
		8'b00110010:begin error_type = 2'b01; error_addr = 8'd101; end
		8'b01100100:begin error_type = 2'b01; error_addr = 8'd100; end
		8'b11001000:begin error_type = 2'b01; error_addr = 8'd99; end
		8'b11110101:begin error_type = 2'b01; error_addr = 8'd98; end
		8'b10001111:begin error_type = 2'b01; error_addr = 8'd97; end
		8'b00101110:begin error_type = 2'b01; error_addr = 8'd96; end
		8'b01011100:begin error_type = 2'b01; error_addr = 8'd95; end
		8'b10111000:begin error_type = 2'b01; error_addr = 8'd94; end
		8'b00010101:begin error_type = 2'b01; error_addr = 8'd93; end
		8'b00101010:begin error_type = 2'b01; error_addr = 8'd92; end
		8'b01010100:begin error_type = 2'b01; error_addr = 8'd91; end
		8'b10101000:begin error_type = 2'b01; error_addr = 8'd90; end
		8'b00110101:begin error_type = 2'b01; error_addr = 8'd89; end
		8'b00101001:begin error_type = 2'b01; error_addr = 8'd88; end
		8'b01010010:begin error_type = 2'b01; error_addr = 8'd87; end
		8'b10100100:begin error_type = 2'b01; error_addr = 8'd86; end
		8'b00101101:begin error_type = 2'b01; error_addr = 8'd85; end
		8'b01011010:begin error_type = 2'b01; error_addr = 8'd84; end
		8'b10110100:begin error_type = 2'b01; error_addr = 8'd83; end
		8'b00001101:begin error_type = 2'b01; error_addr = 8'd82; end
		8'b00011010:begin error_type = 2'b01; error_addr = 8'd81; end
		8'b00100110:begin error_type = 2'b01; error_addr = 8'd80; end
		8'b01001100:begin error_type = 2'b01; error_addr = 8'd79; end
		8'b10011000:begin error_type = 2'b01; error_addr = 8'd78; end
		8'b01010101:begin error_type = 2'b01; error_addr = 8'd77; end
		8'b10101010:begin error_type = 2'b01; error_addr = 8'd76; end
		8'b00110001:begin error_type = 2'b01; error_addr = 8'd75; end
		8'b11000100:begin error_type = 2'b01; error_addr = 8'd73; end
		8'b11001111:begin error_type = 2'b01; error_addr = 8'd72; end
		8'b11111011:begin error_type = 2'b01; error_addr = 8'd71; end
		8'b10010011:begin error_type = 2'b01; error_addr = 8'd70; end
		8'b01000011:begin error_type = 2'b01; error_addr = 8'd69; end
		8'b10000110:begin error_type = 2'b01; error_addr = 8'd68; end
		8'b01101001:begin error_type = 2'b01; error_addr = 8'd67; end
		8'b11010010:begin error_type = 2'b01; error_addr = 8'd66; end
		8'b11000001:begin error_type = 2'b01; error_addr = 8'd65; end
		8'b01011011:begin error_type = 2'b01; error_addr = 8'd64; end
		8'b10110110:begin error_type = 2'b01; error_addr = 8'd63; end
		8'b00001001:begin error_type = 2'b01; error_addr = 8'd62; end
		8'b00010010:begin error_type = 2'b01; error_addr = 8'd61; end
		8'b00100100:begin error_type = 2'b01; error_addr = 8'd60; end
		8'b01001000:begin error_type = 2'b01; error_addr = 8'd59; end
		8'b10010000:begin error_type = 2'b01; error_addr = 8'd58; end
		8'b01000101:begin error_type = 2'b01; error_addr = 8'd57; end
		8'b01011101:begin error_type = 2'b01; error_addr = 8'd56; end
		8'b10111010:begin error_type = 2'b01; error_addr = 8'd55; end
		8'b00010001:begin error_type = 2'b01; error_addr = 8'd54; end
		8'b00100010:begin error_type = 2'b01; error_addr = 8'd53; end
		8'b01000100:begin error_type = 2'b01; error_addr = 8'd52; end
		8'b10001000:begin error_type = 2'b01; error_addr = 8'd51; end
		8'b01110101:begin error_type = 2'b01; error_addr = 8'd50; end
		8'b11101010:begin error_type = 2'b01; error_addr = 8'd49; end
		8'b10100101:begin error_type = 2'b01; error_addr = 8'd48; end
		8'b00101111:begin error_type = 2'b01; error_addr = 8'd47; end
		8'b01011110:begin error_type = 2'b01; error_addr = 8'd46; end
		8'b10111100:begin error_type = 2'b01; error_addr = 8'd45; end
		8'b00011101:begin error_type = 2'b01; error_addr = 8'd44; end
		8'b00111010:begin error_type = 2'b01; error_addr = 8'd43; end
		8'b01110100:begin error_type = 2'b01; error_addr = 8'd42; end
		8'b11101000:begin error_type = 2'b01; error_addr = 8'd41; end
		8'b01101111:begin error_type = 2'b01; error_addr = 8'd40; end
		8'b11011110:begin error_type = 2'b01; error_addr = 8'd39; end
		8'b11011001:begin error_type = 2'b01; error_addr = 8'd38; end
		8'b11010111:begin error_type = 2'b01; error_addr = 8'd37; end
		8'b11001011:begin error_type = 2'b01; error_addr = 8'd36; end
		8'b11110011:begin error_type = 2'b01; error_addr = 8'd35; end
		8'b10000011:begin error_type = 2'b01; error_addr = 8'd34; end
		8'b01100011:begin error_type = 2'b01; error_addr = 8'd33; end
		8'b10110000:begin error_type = 2'b01; error_addr = 8'd32; end
		8'b00000101:begin error_type = 2'b01; error_addr = 8'd31; end
		8'b00001010:begin error_type = 2'b01; error_addr = 8'd30; end
		8'b00010100:begin error_type = 2'b01; error_addr = 8'd29; end
		8'b00101000:begin error_type = 2'b01; error_addr = 8'd28; end
		8'b01010000:begin error_type = 2'b01; error_addr = 8'd27; end
		8'b10100000:begin error_type = 2'b01; error_addr = 8'd26; end
		8'b00100101:begin error_type = 2'b01; error_addr = 8'd25; end
		8'b01000010:begin error_type = 2'b01; error_addr = 8'd24; end
		8'b10000100:begin error_type = 2'b01; error_addr = 8'd23; end
		8'b01101101:begin error_type = 2'b01; error_addr = 8'd22; end
		8'b11011010:begin error_type = 2'b01; error_addr = 8'd21; end
		8'b11010001:begin error_type = 2'b01; error_addr = 8'd20; end
		8'b11000111:begin error_type = 2'b01; error_addr = 8'd19; end
		8'b11101011:begin error_type = 2'b01; error_addr = 8'd18; end
		8'b10110011:begin error_type = 2'b01; error_addr = 8'd17; end
		8'b11100101:begin error_type = 2'b01; error_addr = 8'd16; end
		8'b10101111:begin error_type = 2'b01; error_addr = 8'd15; end
		8'b00111011:begin error_type = 2'b01; error_addr = 8'd14; end
		8'b01110110:begin error_type = 2'b01; error_addr = 8'd13; end
		8'b11101100:begin error_type = 2'b01; error_addr = 8'd12; end
		8'b10111101:begin error_type = 2'b01; error_addr = 8'd11; end
		8'b00011111:begin error_type = 2'b01; error_addr = 8'd10; end
		8'b00111110:begin error_type = 2'b01; error_addr = 8'd9; end
		8'b10000000:begin error_type = 2'b01; error_addr = 8'd8; end
		8'b01000000:begin error_type = 2'b01; error_addr = 8'd7; end
		8'b00100000:begin error_type = 2'b01; error_addr = 8'd6; end
		8'b00010000:begin error_type = 2'b01; error_addr = 8'd5; end
		8'b00001000:begin error_type = 2'b01; error_addr = 8'd4; end
		8'b00000100:begin error_type = 2'b01; error_addr = 8'd3; end
		8'b00000010:begin error_type = 2'b01; error_addr = 8'd2; end
		8'b00000001:begin error_type = 2'b01; error_addr = 8'd1; end

		8'b01111100:begin error_type = 2'b10; error_addr = 8'd135; end
		8'b11111000:begin error_type = 2'b10; error_addr = 8'd134; end
		8'b10010101:begin error_type = 2'b10; error_addr = 8'd133; end
		8'b01001111:begin error_type = 2'b10; error_addr = 8'd132; end
		8'b10011110:begin error_type = 2'b10; error_addr = 8'd131; end
		8'b01011001:begin error_type = 2'b10; error_addr = 8'd130; end
		8'b10110010:begin error_type = 2'b10; error_addr = 8'd129; end
		8'b11111111:begin error_type = 2'b10; error_addr = 8'd128; end
		8'b01100101:begin error_type = 2'b10; error_addr = 8'd127; end
		8'b11001010:begin error_type = 2'b10; error_addr = 8'd126; end
		8'b11110001:begin error_type = 2'b10; error_addr = 8'd125; end
		8'b10000111:begin error_type = 2'b10; error_addr = 8'd124; end
		8'b01101011:begin error_type = 2'b10; error_addr = 8'd123; end
		8'b11010110:begin error_type = 2'b10; error_addr = 8'd122; end
		8'b11001001:begin error_type = 2'b10; error_addr = 8'd121; end
		8'b11000101:begin error_type = 2'b10; error_addr = 8'd120; end
		8'b11011101:begin error_type = 2'b10; error_addr = 8'd119; end
		8'b11011111:begin error_type = 2'b10; error_addr = 8'd118; end
		8'b11011011:begin error_type = 2'b10; error_addr = 8'd117; end
		8'b11010011:begin error_type = 2'b10; error_addr = 8'd116; end
		8'b11000011:begin error_type = 2'b10; error_addr = 8'd115; end
		8'b11100011:begin error_type = 2'b10; error_addr = 8'd114; end
		8'b10100011:begin error_type = 2'b10; error_addr = 8'd113; end
		8'b00110110:begin error_type = 2'b10; error_addr = 8'd112; end
		8'b01111001:begin error_type = 2'b10; error_addr = 8'd111; end
		8'b11110010:begin error_type = 2'b10; error_addr = 8'd110; end
		8'b10000001:begin error_type = 2'b10; error_addr = 8'd109; end
		8'b01100111:begin error_type = 2'b10; error_addr = 8'd108; end
		8'b11001110:begin error_type = 2'b10; error_addr = 8'd107; end
		8'b11111001:begin error_type = 2'b10; error_addr = 8'd106; end
		8'b10010111:begin error_type = 2'b10; error_addr = 8'd105; end
		8'b01100110:begin error_type = 2'b10; error_addr = 8'd104; end
		8'b11100001:begin error_type = 2'b10; error_addr = 8'd103; end
		8'b10100111:begin error_type = 2'b10; error_addr = 8'd102; end
		8'b00101011:begin error_type = 2'b10; error_addr = 8'd101; end
		8'b01010110:begin error_type = 2'b10; error_addr = 8'd100; end
		8'b10101100:begin error_type = 2'b10; error_addr = 8'd99; end
		8'b00111101:begin error_type = 2'b10; error_addr = 8'd98; end
		8'b01111010:begin error_type = 2'b10; error_addr = 8'd97; end
		8'b10100001:begin error_type = 2'b10; error_addr = 8'd96; end
		8'b01110010:begin error_type = 2'b10; error_addr = 8'd95; end
		8'b11100100:begin error_type = 2'b10; error_addr = 8'd94; end
		8'b10101101:begin error_type = 2'b10; error_addr = 8'd93; end
		8'b00111111:begin error_type = 2'b10; error_addr = 8'd92; end
		8'b01111110:begin error_type = 2'b10; error_addr = 8'd91; end
		8'b11111100:begin error_type = 2'b10; error_addr = 8'd90; end
		8'b10011101:begin error_type = 2'b10; error_addr = 8'd89; end
		8'b00011100:begin error_type = 2'b10; error_addr = 8'd88; end
		8'b01111011:begin error_type = 2'b10; error_addr = 8'd87; end
		8'b11110110:begin error_type = 2'b10; error_addr = 8'd86; end
		8'b10001001:begin error_type = 2'b10; error_addr = 8'd85; end
		8'b01110111:begin error_type = 2'b10; error_addr = 8'd84; end
		8'b11101110:begin error_type = 2'b10; error_addr = 8'd83; end
		8'b10111001:begin error_type = 2'b10; error_addr = 8'd82; end
		8'b00010111:begin error_type = 2'b10; error_addr = 8'd81; end
		8'b00111100:begin error_type = 2'b10; error_addr = 8'd80; end
		8'b01101010:begin error_type = 2'b10; error_addr = 8'd79; end
		8'b11010100:begin error_type = 2'b10; error_addr = 8'd78; end
		8'b11001101:begin error_type = 2'b10; error_addr = 8'd77; end
		8'b11111111:begin error_type = 2'b10; error_addr = 8'd76; end
		8'b10011011:begin error_type = 2'b10; error_addr = 8'd75; end
		8'b01010011:begin error_type = 2'b10; error_addr = 8'd74; end
		8'b10100110:begin error_type = 2'b10; error_addr = 8'd73; end
		8'b00001011:begin error_type = 2'b10; error_addr = 8'd72; end
		8'b00110100:begin error_type = 2'b10; error_addr = 8'd71; end
		8'b01101000:begin error_type = 2'b10; error_addr = 8'd70; end
		8'b11010000:begin error_type = 2'b10; error_addr = 8'd69; end
		8'b11000101:begin error_type = 2'b10; error_addr = 8'd68; end
		8'b11101111:begin error_type = 2'b10; error_addr = 8'd67; end
		8'b10111011:begin error_type = 2'b10; error_addr = 8'd66; end
		8'b00010011:begin error_type = 2'b10; error_addr = 8'd65; end
		8'b10011010:begin error_type = 2'b10; error_addr = 8'd64; end
		8'b11101101:begin error_type = 2'b10; error_addr = 8'd63; end
		8'b10111111:begin error_type = 2'b10; error_addr = 8'd62; end
		8'b00011011:begin error_type = 2'b10; error_addr = 8'd61; end
		8'b00110110:begin error_type = 2'b10; error_addr = 8'd60; end
		8'b01101100:begin error_type = 2'b10; error_addr = 8'd59; end
		8'b11011000:begin error_type = 2'b10; error_addr = 8'd58; end
		8'b11010101:begin error_type = 2'b10; error_addr = 8'd57; end
		8'b00011000:begin error_type = 2'b10; error_addr = 8'd56; end
		8'b11100111:begin error_type = 2'b10; error_addr = 8'd55; end
		8'b10101011:begin error_type = 2'b10; error_addr = 8'd54; end
		8'b00110011:begin error_type = 2'b10; error_addr = 8'd53; end
		8'b01100110:begin error_type = 2'b10; error_addr = 8'd52; end
		8'b11001100:begin error_type = 2'b10; error_addr = 8'd51; end
		8'b11111101:begin error_type = 2'b10; error_addr = 8'd50; end
		8'b10011111:begin error_type = 2'b10; error_addr = 8'd49; end
		8'b01001111:begin error_type = 2'b10; error_addr = 8'd48; end
		8'b10001010:begin error_type = 2'b10; error_addr = 8'd47; end
		8'b01110001:begin error_type = 2'b10; error_addr = 8'd46; end
		8'b11100010:begin error_type = 2'b10; error_addr = 8'd45; end
		8'b10100001:begin error_type = 2'b10; error_addr = 8'd44; end
		8'b00100111:begin error_type = 2'b10; error_addr = 8'd43; end
		8'b01001110:begin error_type = 2'b10; error_addr = 8'd42; end
		8'b10011100:begin error_type = 2'b10; error_addr = 8'd41; end
		8'b10000111:begin error_type = 2'b10; error_addr = 8'd40; end
		8'b10110001:begin error_type = 2'b10; error_addr = 8'd39; end
		8'b00000111:begin error_type = 2'b10; error_addr = 8'd38; end
		8'b00001110:begin error_type = 2'b10; error_addr = 8'd37; end
		8'b00011100:begin error_type = 2'b10; error_addr = 8'd36; end
		8'b00111000:begin error_type = 2'b10; error_addr = 8'd35; end
		8'b01110000:begin error_type = 2'b10; error_addr = 8'd34; end
		8'b11100000:begin error_type = 2'b10; error_addr = 8'd33; end
		8'b11010011:begin error_type = 2'b10; error_addr = 8'd32; end
		8'b10110101:begin error_type = 2'b10; error_addr = 8'd31; end
		8'b00001111:begin error_type = 2'b10; error_addr = 8'd30; end
		8'b00011110:begin error_type = 2'b10; error_addr = 8'd29; end
		8'b00111100:begin error_type = 2'b10; error_addr = 8'd28; end
		8'b01111000:begin error_type = 2'b10; error_addr = 8'd27; end
		8'b11110000:begin error_type = 2'b10; error_addr = 8'd26; end
		8'b10000101:begin error_type = 2'b10; error_addr = 8'd25; end
		8'b01100111:begin error_type = 2'b10; error_addr = 8'd24; end
		8'b11000110:begin error_type = 2'b10; error_addr = 8'd23; end
		8'b11101001:begin error_type = 2'b10; error_addr = 8'd22; end
		8'b10110111:begin error_type = 2'b10; error_addr = 8'd21; end
		8'b00001011:begin error_type = 2'b10; error_addr = 8'd20; end
		8'b00010110:begin error_type = 2'b10; error_addr = 8'd19; end
		8'b00101100:begin error_type = 2'b10; error_addr = 8'd18; end
		8'b01011000:begin error_type = 2'b10; error_addr = 8'd17; end
		8'b01010110:begin error_type = 2'b10; error_addr = 8'd16; end
		8'b01001010:begin error_type = 2'b10; error_addr = 8'd15; end
		8'b10010100:begin error_type = 2'b10; error_addr = 8'd14; end
		8'b01001101:begin error_type = 2'b10; error_addr = 8'd13; end
		8'b10011010:begin error_type = 2'b10; error_addr = 8'd12; end
		8'b01010001:begin error_type = 2'b10; error_addr = 8'd11; end
		8'b10100010:begin error_type = 2'b10; error_addr = 8'd10; end
		8'b00100001:begin error_type = 2'b10; error_addr = 8'd9; end
		8'b10111110:begin error_type = 2'b10; error_addr = 8'd8; end
		8'b11000000:begin error_type = 2'b10; error_addr = 8'd7; end
		8'b01100000:begin error_type = 2'b10; error_addr = 8'd6; end
		8'b00110000:begin error_type = 2'b10; error_addr = 8'd5; end
		8'b00011000:begin error_type = 2'b10; error_addr = 8'd4; end
		8'b00001100:begin error_type = 2'b10; error_addr = 8'd3; end
		8'b00000110:begin error_type = 2'b10; error_addr = 8'd2; end
		8'b00000011:begin error_type = 2'b10; error_addr = 8'd1; end

		8'b00000000:begin error_type = 2'b00; error_addr = 8'd0;end

		default : begin  error_type = 2'b11; error_addr = 8'd1;end
	endcase
end
endmodule

module SECBADAEC_decoder(input [135:0] codeword, output [127:0] message, output [1:0] error_type);

	wire [7:0] syndrome;
	wire [7:0] error_addr;
	reg [135:0] decoded;
	SECBADAEC_syndrome_gen syndrome_gen(.codeword(codeword),.syndrome(syndrome));
	SECBADAEC_errorinfo_gen errorinfo_gen(.syndrome(syndrome),.error_addr(error_addr),.error_type(error_type));

	always@(error_type) begin
		if(error_type == 0) begin
			decoded = codeword;
		end
		else if(error_type == 1) begin
			decoded = codeword^(1<<(error_addr-1));
		end
		else if(error_type == 2) begin
			decoded = codeword^(3<<(error_addr-1));
		end
		else begin
			decoded = codeword;
		end
	end 

	assign message = decoded[135:8];

endmodule
