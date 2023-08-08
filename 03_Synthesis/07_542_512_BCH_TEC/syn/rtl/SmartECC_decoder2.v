module Syndrome(input [14:0] codeword, output [3:0] syndrome);
//module Syndrome#(parameter N = 15, parameter R=4, parameter K=11)(input [N-1:0] codeword, input [R-1:0] syndrome);
/*
	//synopsys templete
	integer i;
	parameter [14:0] Hmatrix[R] = 
		{15'b100010011010111,
		 15'b010011010111100,
		 15'b001001101011110,
		 15'b000100110101111}; 	
	always @(*) begin
		for(i=0;i<R;i=i+1)
			assign syndrome_cur[i] = ^(codeword&Hmatrix[i]);
	end
*/
	assign syndrome[3] = ^(codeword&15'b100010011010111);
	assign syndrome[2] = ^(codeword&15'b010011010111100);
	assign syndrome[1] = ^(codeword&15'b001001101011110);
	assign syndrome[0] = ^(codeword&15'b000100110101111);

endmodule
	

module Candidate(input [3:0] syndrome, output reg [224:0] candidate);

	always @(*) begin
		case(syndrome)
			4'b1000:begin
				candidate[14:0] 	= 15'b100_0000_0000_0000;
				candidate[29:15] 	= 15'b010_0100_0000_0000;
				candidate[44:30] 	= 15'b001_0000_0100_0000;
				candidate[59:45] 	= 15'b000_1000_0000_0001;
				candidate[74:60] 	= 15'b100_0100_0000_0000;
				candidate[89:75] 	= 15'b000_0010_0001_0000;
				candidate[104:90] 	= 15'b000_0001_0000_0010;
				candidate[119:105] 	= 15'b000_0000_1010_0000;
				candidate[134:120]	= 15'b001_0000_0100_0000;
				candidate[149:135]	= 15'b000_0000_1010_0000;
				candidate[164:150]	= 15'b000_0010_0001_0000;
				candidate[179:165]	= 15'b000_0000_0000_1100;
				candidate[194:180]	= 15'b000_0000_0000_1100;
				candidate[209:195]	= 15'b000_0001_0000_0010;
				candidate[224:210]	= 15'b000_1000_0000_0001;
			end

			4'b0100:begin
				candidate[14:0] 	= 15'b100_0100_0000_0000;
				candidate[29:15] 	= 15'b010_0000_0000_0000;
				candidate[44:30] 	= 15'b001_0010_0000_0000;
				candidate[59:45] 	= 15'b000_1000_0010_0000;
				candidate[74:60] 	= 15'b100_0100_0000_0000;
				candidate[89:75] 	= 15'b001_0010_0000_0000;
				candidate[104:90] 	= 15'b000_0001_0000_1000;
				candidate[119:105] 	= 15'b000_0000_1000_0001;
				candidate[134:120]	= 15'b000_0000_0101_0000;
				candidate[149:135]	= 15'b000_1000_0010_0000;
				candidate[164:150]	= 15'b000_0000_0101_0000;
				candidate[179:165]	= 15'b000_0001_0000_1000;
				candidate[194:180]	= 15'b000_0000_0000_0110;
				candidate[209:195]	= 15'b000_0000_0000_0110;
				candidate[224:210]	= 15'b000_0000_1000_0001;
			end
			
			4'b0010:begin
				candidate[14:0] 	= 15'b100_0000_0100_0000;
				candidate[29:15] 	= 15'b010_0010_0000_0000;
				candidate[44:30] 	= 15'b001_0000_0000_0000;
				candidate[59:45] 	= 15'b000_1001_0000_0000;
				candidate[74:60] 	= 15'b000_0100_0001_0000;
				candidate[89:75] 	= 15'b010_0010_0000_0000;
				candidate[104:90] 	= 15'b000_1001_0000_0000;
				candidate[119:105] 	= 15'b000_0000_1000_0100;
				candidate[134:120]	= 15'b100_0000_0100_0000;
				candidate[149:135]	= 15'b000_0000_0010_1000;
				candidate[164:150]	= 15'b000_0100_0001_0000;
				candidate[179:165]	= 15'b000_0000_0010_1000;
				candidate[194:180]	= 15'b000_0000_1000_0100;
				candidate[209:195]	= 15'b000_0000_0000_0011;
				candidate[224:210]	= 15'b000_0000_0000_0011;
			end

			4'b0001:begin
				candidate[14:0] 	= 15'b100_0000_0000_0001;
				candidate[29:15] 	= 15'b010_0000_0010_0000;
				candidate[44:30] 	= 15'b001_0001_0000_0000;
				candidate[59:45] 	= 15'b000_1000_0000_0000;
				candidate[74:60] 	= 15'b000_0100_1000_0000;
				candidate[89:75] 	= 15'b000_0010_0000_1000;
				candidate[104:90] 	= 15'b001_0001_0000_0000;
				candidate[119:105] 	= 15'b000_0100_1000_0000;
				candidate[134:120]	= 15'b000_0000_0100_0010;
				candidate[149:135]	= 15'b010_0000_0010_0000;
				candidate[164:150]	= 15'b000_0000_0001_0100;
				candidate[179:165]	= 15'b000_0010_0000_1000;
				candidate[194:180]	= 15'b000_0000_0001_0100;
				candidate[209:195]	= 15'b000_0000_0100_0010;
				candidate[224:210]	= 15'b010_0000_0000_0001;
			end

			4'b0110:begin
				candidate[14:0] 	= 15'b100_0000_0001_0000;
				candidate[29:15] 	= 15'b011_0000_0000_0000;
				candidate[44:30] 	= 15'b011_0000_0000_0000;
				candidate[59:45] 	= 15'b000_1000_0000_1000;
				candidate[74:60] 	= 15'b000_0100_0100_0000;
				candidate[89:75] 	= 15'b000_0010_0000_0000;
				candidate[104:90] 	= 15'b000_0001_0010_0000;
				candidate[119:105] 	= 15'b000_0000_1000_0010;
				candidate[134:120]	= 15'b000_0100_0100_0000;
				candidate[149:135]	= 15'b000_0001_0010_0000;
				candidate[164:150]	= 15'b100_0000_0001_0000;
				candidate[179:165]	= 15'b000_1000_0000_1000;
				candidate[194:180]	= 15'b000_0000_0000_0101;
				candidate[209:195]	= 15'b000_0000_1000_0010;
				candidate[224:210]	= 15'b000_0000_0000_0101;
			end

			4'b1100:begin
				candidate[14:0] 	= 15'b110_0000_0000_0000;
				candidate[29:15] 	= 15'b110_0000_0000_0000;
				candidate[44:30] 	= 15'b001_0000_0001_0000;
				candidate[59:45] 	= 15'b000_1000_1000_0000;
				candidate[74:60] 	= 15'b000_0100_0000_0000;
				candidate[89:75] 	= 15'b000_0010_0100_0000;
				candidate[104:90] 	= 15'b000_0001_0000_0100;
				candidate[119:105] 	= 15'b000_1000_1000_0000;
				candidate[134:120]	= 15'b000_0010_0100_0000;
				candidate[149:135]	= 15'b000_0000_0010_0001;
				candidate[164:150]	= 15'b001_0000_0001_0000;
				candidate[179:165]	= 15'b000_0000_0000_1010;
				candidate[194:180]	= 15'b000_0001_0000_0100;
				candidate[209:195]	= 15'b000_0000_0000_1010;
				candidate[224:210]	= 15'b000_0000_0010_0001;
			end

			4'b0011:begin
				candidate[14:0] 	= 15'b100_0000_0000_0010;
				candidate[29:15] 	= 15'b010_0000_0000_1000;
				candidate[44:30] 	= 15'b001_1000_0000_0000;
				candidate[59:45] 	= 15'b001_1000_0000_0000;
				candidate[74:60] 	= 15'b000_0100_0000_0100;
				candidate[89:75] 	= 15'b000_0010_0010_0000;
				candidate[104:90] 	= 15'b000_0001_0000_0000;
				candidate[119:105] 	= 15'b000_0000_1001_0000;
				candidate[134:120]	= 15'b000_0000_0100_0001;
				candidate[149:135]	= 15'b000_0010_0010_0000;
				candidate[164:150]	= 15'b000_0000_1001_0000;
				candidate[179:165]	= 15'b010_0000_0000_1000;
				candidate[194:180]	= 15'b000_0100_0000_0100;
				candidate[209:195]	= 15'b100_0000_0000_0010;
				candidate[224:210]	= 15'b000_0000_0100_0001;
			end

			4'b1101:begin
				candidate[14:0] 	= 15'b100_0000_0010_0000;
				candidate[29:15] 	= 15'b010_0000_0000_0001;
				candidate[44:30] 	= 15'b001_0000_0000_0100;
				candidate[59:45] 	= 15'b000_1100_0000_0000;
				candidate[74:60] 	= 15'b000_1100_0000_0000;
				candidate[89:75] 	= 15'b000_0010_0000_0010;
				candidate[104:90] 	= 15'b000_0001_0001_0000;
				candidate[119:105] 	= 15'b000_0000_1000_0000;
				candidate[134:120]	= 15'b000_0000_0100_1000;
				candidate[149:135]	= 15'b100_0000_0010_0000;
				candidate[164:150]	= 15'b000_0001_0001_0000;
				candidate[179:165]	= 15'b000_0000_0100_1000;
				candidate[194:180]	= 15'b001_0000_0000_0100;
				candidate[209:195]	= 15'b000_0010_0000_0010;
				candidate[224:210]	= 15'b010_0000_0000_0001;
			end

			4'b1010:begin
				candidate[14:0] 	= 15'b101_0000_0000_0000;
				candidate[29:15] 	= 15'b010_0000_0001_0000;
				candidate[44:30] 	= 15'b101_0000_0000_0000;
				candidate[59:45] 	= 15'b000_1000_0000_0010;
				candidate[74:60] 	= 15'b000_0110_0000_0000;
				candidate[89:75] 	= 15'b000_0110_0000_0000;
				candidate[104:90] 	= 15'b000_0001_0000_0001;
				candidate[119:105] 	= 15'b000_0000_1000_1000;
				candidate[134:120]	= 15'b000_0000_0100_0000;
				candidate[149:135]	= 15'b000_0000_0010_0100;
				candidate[164:150]	= 15'b010_0000_0001_0000;
				candidate[179:165]	= 15'b000_0000_1000_1000;
				candidate[194:180]	= 15'b000_0000_0010_0100;
				candidate[209:195]	= 15'b000_1000_0000_0010;
				candidate[224:210]	= 15'b000_0001_0000_0001;
			end

			4'b0101:begin
				candidate[14:0] 	= 15'b100_0000_1000_0000;
				candidate[29:15] 	= 15'b010_1000_0000_0000;
				candidate[44:30] 	= 15'b001_0000_0000_1000;
				candidate[59:45] 	= 15'b010_1000_0000_0000;
				candidate[74:60] 	= 15'b000_0100_0000_0001;
				candidate[89:75] 	= 15'b000_0011_0000_0000;
				candidate[104:90] 	= 15'b000_0011_0000_0000;
				candidate[119:105] 	= 15'b100_0000_1000_0000;
				candidate[134:120]	= 15'b000_0000_0100_0100;
				candidate[149:135]	= 15'b000_0000_0010_0000;
				candidate[164:150]	= 15'b000_0000_0001_0010;
				candidate[179:165]	= 15'b001_0000_0000_1000;
				candidate[194:180]	= 15'b000_0000_0100_0100;
				candidate[209:195]	= 15'b000_0000_0001_0010;
				candidate[224:210]	= 15'b000_0100_0000_0001;
			end

			4'b1110:begin
				candidate[14:0] 	= 15'b100_0010_0000_0000;
				candidate[29:15] 	= 15'b010_0000_0100_0000;
				candidate[44:30] 	= 15'b001_0100_0000_0000;
				candidate[59:45] 	= 15'b000_1000_0000_0100;
				candidate[74:60] 	= 15'b001_0100_0000_0000;
				candidate[89:75] 	= 15'b100_0010_0000_0000;
				candidate[104:90] 	= 15'b000_0001_1000_0000;
				candidate[119:105] 	= 15'b000_0001_1000_0000;
				candidate[134:120]	= 15'b010_0000_0100_0000;
				candidate[149:135]	= 15'b000_0000_0010_0010;
				candidate[164:150]	= 15'b000_0000_0001_0000;
				candidate[179:165]	= 15'b000_0000_0000_1001;
				candidate[194:180]	= 15'b000_1000_0000_0100;
				candidate[209:195]	= 15'b000_0000_0010_0010;
				candidate[224:210]	= 15'b000_0000_0000_1001;
			end

			4'b0111:begin
				candidate[14:0] 	= 15'b100_0000_0000_0100;
				candidate[29:15] 	= 15'b010_0001_0000_0000;
				candidate[44:30] 	= 15'b001_0000_0010_0000;
				candidate[59:45] 	= 15'b000_1010_0000_0000;
				candidate[74:60] 	= 15'b000_0100_0000_0010;
				candidate[89:75] 	= 15'b000_1010_0000_0000;
				candidate[104:90] 	= 15'b010_0001_0000_0000;
				candidate[119:105] 	= 15'b000_0000_1100_0000;
				candidate[134:120]	= 15'b000_0000_1100_0000;
				candidate[149:135]	= 15'b001_0000_0010_0000;
				candidate[164:150]	= 15'b000_0000_0001_0001;
				candidate[179:165]	= 15'b000_0000_0000_1000;
				candidate[194:180]	= 15'b100_0000_0000_0100;
				candidate[209:195]	= 15'b000_0100_0000_0010;
				candidate[224:210]	= 15'b000_0000_0001_0001;
			end

			4'b1111:begin
				candidate[14:0] 	= 15'b100_0000_0000_1000;
				candidate[29:15] 	= 15'b010_0000_0000_0010;
				candidate[44:30] 	= 15'b001_0000_1000_0000;
				candidate[59:45] 	= 15'b000_1000_0001_0000;
				candidate[74:60] 	= 15'b000_0101_0000_0000;
				candidate[89:75] 	= 15'b000_0010_0000_0001;
				candidate[104:90] 	= 15'b000_0101_0000_0000;
				candidate[119:105] 	= 15'b001_0000_1000_0000;
				candidate[134:120]	= 15'b000_0000_0110_0000;
				candidate[149:135]	= 15'b000_0000_0110_0000;
				candidate[164:150]	= 15'b000_1000_0001_0000;
				candidate[179:165]	= 15'b100_0000_0000_1000;
				candidate[194:180]	= 15'b000_0000_0000_0100;
				candidate[209:195]	= 15'b010_0000_0000_0010;
				candidate[224:210]	= 15'b000_0010_0000_0001;
			end

			4'b1011:begin
				candidate[14:0] 	= 15'b100_0001_0000_0000;
				candidate[29:15] 	= 15'b010_0000_0000_0100;
				candidate[44:30] 	= 15'b001_0000_0000_0001;
				candidate[59:45] 	= 15'b000_1000_0100_0000;
				candidate[74:60] 	= 15'b000_0100_0000_1000;
				candidate[89:75] 	= 15'b000_0010_1000_0000;
				candidate[104:90] 	= 15'b100_0001_0000_0000;
				candidate[119:105] 	= 15'b000_0010_1000_0000;
				candidate[134:120]	= 15'b000_1000_0100_0000;
				candidate[149:135]	= 15'b000_0000_0011_0000;
				candidate[164:150]	= 15'b000_0000_0011_0000;
				candidate[179:165]	= 15'b000_0100_0000_1000;
				candidate[194:180]	= 15'b010_0000_0000_0100;
				candidate[209:195]	= 15'b000_0000_0000_0010;
				candidate[224:210]	= 15'b001_0000_0000_0001;
			end

			4'b1001:begin
				candidate[14:0] 	= 15'b100_1000_0000_0000;
				candidate[29:15] 	= 15'b010_0000_1000_0000;
				candidate[44:30] 	= 15'b001_0000_0000_0010;
				candidate[59:45] 	= 15'b010_1000_0000_0000;
				candidate[74:60] 	= 15'b000_0100_0010_0000;
				candidate[89:75] 	= 15'b000_0010_0000_0100;
				candidate[104:90] 	= 15'b000_0001_0100_0000;
				candidate[119:105] 	= 15'b010_0000_1000_0000;
				candidate[134:120]	= 15'b000_0001_0100_0000;
				candidate[149:135]	= 15'b000_0100_0010_0000;
				candidate[164:150]	= 15'b000_0000_0001_1000;
				candidate[179:165]	= 15'b000_0000_0001_1000;
				candidate[194:180]	= 15'b000_0010_0000_0100;
				candidate[209:195]	= 15'b001_0000_0000_0010;
				candidate[224:210]	= 15'b000_0000_0000_0001;
			end

			default:
				candidate[224:0] = 224'h0;
		endcase
	end


endmodule
/*
module Candidate(input [3:0] syndrome, output reg [119:0] candidate);
	
	always @(*) begin
	case(syndrome)
		4'b1000:
		begin
			candidate[14:0] 	= 15'b100_0000_0000_0000;
			candidate[29:15] 	= 15'b010_0100_0000_0000;
			candidate[44:30] 	= 15'b001_0000_0100_0000;
			candidate[59:45]	= 15'b000_1000_0000_0001;
			candidate[74:60] 	= 15'b000_0010_0001_0000;
			candidate[89:75] 	= 15'b000_0001_0000_0010;
			candidate[104:90] 	= 15'b000_0000_1010_0000;
			candidate[119:105] 	= 15'b000_0000_0000_1100;
		end
		4'b0100:
		begin
			candidate[14:0] 	= 15'b010_0000_0000_0000;
			candidate[29:15] 	= 15'b100_0100_0000_0000;
			candidate[44:30] 	= 15'b001_0010_0000_0000;
			candidate[59:45]	= 15'b000_1000_0010_0000;
			candidate[74:60] 	= 15'b000_0001_0000_1000;
			candidate[89:75] 	= 15'b000_0000_1000_0001;
			candidate[104:90] 	= 15'b000_0000_0101_0000;
			candidate[119:105] 	= 15'b000_0000_0000_0110;
		end
		4'b0010:
		begin
			candidate[14:0] 	= 15'b001_0000_0000_0000;
			candidate[29:15] 	= 15'b100_0000_0100_0000;
			candidate[44:30] 	= 15'b010_0010_0000_0000;
			candidate[59:45]	= 15'b001_0001_0000_0000;
			candidate[74:60] 	= 15'b000_1000_0001_0000;
			candidate[89:75] 	= 15'b000_0000_1000_0100;
			candidate[104:90] 	= 15'b000_0000_0010_1000;
			candidate[119:105] 	= 15'b000_0000_0000_0011;
		end
		4'b0001:
		begin
			candidate[14:0] 	= 15'b000_1000_0000_0000;
			candidate[29:15] 	= 15'b100_0000_0000_0001;
			candidate[44:30] 	= 15'b010_0000_0010_0000;
			candidate[59:45]	= 15'b001_0001_0000_0000;
			candidate[74:60] 	= 15'b000_0100_1000_0000;
			candidate[89:75] 	= 15'b000_0010_0000_1000;
			candidate[104:90] 	= 15'b000_0000_0100_0010;
			candidate[119:105] 	= 15'b000_0000_0001_0100;
		end
		4'b1100:
		begin
			candidate[14:0] 	= 15'b000_0100_0000_0000;
			candidate[29:15] 	= 15'b110_0000_0000_0000;
			candidate[44:30] 	= 15'b001_0000_0001_0000;
			candidate[59:45]	= 15'b000_1000_1000_0000;
			candidate[74:60] 	= 15'b000_0010_0100_0000;
			candidate[89:75] 	= 15'b000_0001_0000_0100;
			candidate[104:90] 	= 15'b000_0000_0010_0001;
			candidate[119:105] 	= 15'b000_0000_0000_1010;
		end

		4'b0110:
		begin
			candidate[14:0] 	= 15'b000_0010_0000_0000;
			candidate[29:15] 	= 15'b100_0000_0001_0000;
			candidate[44:30] 	= 15'b011_0000_0000_0000;
			candidate[59:45]	= 15'b000_1000_0000_1000;
			candidate[74:60] 	= 15'b000_0100_0100_0000;
			candidate[89:75] 	= 15'b000_0001_0010_0000;
			candidate[104:90] 	= 15'b000_0000_1000_0010;
			candidate[119:105] 	= 15'b000_0000_0000_0101;
		end
		4'b0011:
		begin
			candidate[14:0] 	= 15'b000_0001_0000_0000;
			candidate[29:15] 	= 15'b100_0000_0000_0010;
			candidate[44:30] 	= 15'b010_0000_0000_1000;
			candidate[59:45]	= 15'b001_1000_0000_0000;
			candidate[74:60] 	= 15'b000_0100_0000_0010;
			candidate[89:75] 	= 15'b000_0010_0010_0000;
			candidate[104:90] 	= 15'b000_0000_1001_0000;
			candidate[119:105] 	= 15'b000_0000_0100_0001;
		end
		4'b1101:
		begin
			candidate[14:0] 	= 15'b000_0000_1000_0000;
			candidate[29:15] 	= 15'b100_0000_0010_0000;
			candidate[44:30] 	= 15'b010_0000_0000_0001;
			candidate[59:45]	= 15'b001_0000_0000_0100;
			candidate[74:60] 	= 15'b000_1100_0000_0000;
			candidate[89:75] 	= 15'b000_0010_0000_0010;
			candidate[104:90] 	= 15'b000_0001_0001_0000;
			candidate[119:105] 	= 15'b000_0000_0100_1000;
		end
		4'b1010:
		begin
			candidate[14:0] 	= 15'b000_0000_0100_0000;
			candidate[29:15] 	= 15'b101_0000_0000_0000;
			candidate[44:30] 	= 15'b010_0000_0001_0000;
			candidate[59:45]	= 15'b000_1000_0000_0010;
			candidate[74:60] 	= 15'b000_0110_0000_0000;
			candidate[89:75] 	= 15'b000_0001_0000_0001;
			candidate[104:90] 	= 15'b000_0000_1000_1000;
			candidate[119:105] 	= 15'b000_0000_0010_0100;
		end
		4'b0101:
		begin
			candidate[14:0] 	= 15'b000_0000_0010_0000;
			candidate[29:15] 	= 15'b100_0000_1000_0000;
			candidate[44:30] 	= 15'b010_1000_0000_0000;
			candidate[59:45]	= 15'b001_0000_0000_1000;
			candidate[74:60] 	= 15'b000_0100_0000_0001;
			candidate[89:75] 	= 15'b000_0011_0000_0000;
			candidate[104:90] 	= 15'b000_0000_0100_0100;
			candidate[119:105] 	= 15'b000_0000_0001_0010;
		end
		4'b1110:
		begin
			candidate[14:0] 	= 15'b000_0000_0001_0000;
			candidate[29:15] 	= 15'b100_0010_0000_0000;
			candidate[44:30] 	= 15'b010_0000_0100_0000;
			candidate[59:45]	= 15'b001_0100_0000_0000;
			candidate[74:60] 	= 15'b000_1000_0000_0100;
			candidate[89:75] 	= 15'b000_0001_1000_0000;
			candidate[104:90] 	= 15'b000_0000_0010_0010;
			candidate[119:105] 	= 15'b000_0000_0000_1001;
		end
		4'b0111:
		begin
			candidate[14:0] 	= 15'b000_0000_0000_1000;
			candidate[29:15] 	= 15'b100_0000_0000_0100;
			candidate[44:30] 	= 15'b010_0001_0000_0000;
			candidate[59:45]	= 15'b001_0000_0010_0000;
			candidate[74:60] 	= 15'b000_1010_0000_0000;
			candidate[89:75] 	= 15'b000_0100_0000_0010;
			candidate[104:90] 	= 15'b000_0000_1100_0000;
			candidate[119:105] 	= 15'b000_0000_0001_0001;
		end
		4'b1111:
		begin
			candidate[14:0] 	= 15'b000_0000_0000_0100;
			candidate[29:15] 	= 15'b100_0000_0000_1000;
			candidate[44:30] 	= 15'b010_0000_0000_0010;
			candidate[59:45]	= 15'b001_0000_1000_0000;
			candidate[74:60] 	= 15'b000_1000_0001_0000;
			candidate[89:75] 	= 15'b000_0101_0000_0000;
			candidate[104:90] 	= 15'b000_0010_0000_0001;
			candidate[119:105] 	= 15'b000_0000_0110_0000;
		end
		4'b1011:
		begin
			candidate[14:0] 	= 15'b000_0000_0000_0010;
			candidate[29:15] 	= 15'b100_0001_0000_0000;
			candidate[44:30] 	= 15'b010_0000_0000_0100;
			candidate[59:45]	= 15'b001_0000_0000_0001;
			candidate[74:60] 	= 15'b000_1000_0100_0000;
			candidate[89:75] 	= 15'b000_0100_0000_1000;
			candidate[104:90] 	= 15'b000_0010_1000_0000;
			candidate[119:105] 	= 15'b000_0000_0011_0000;
		end
		4'b1001:
		begin
			candidate[14:0] 	= 15'b000_0000_0000_0001;
			candidate[29:15] 	= 15'b100_1000_0000_0000;
			candidate[44:30] 	= 15'b010_0000_1000_0000;
			candidate[59:45]	= 15'b001_0000_0000_0010;
			candidate[74:60] 	= 15'b000_0100_0010_0000;
			candidate[89:75] 	= 15'b000_0010_0000_0100;
			candidate[104:90] 	= 15'b000_0001_0100_0000;
			candidate[119:105] 	= 15'b000_0000_0001_1000;
		end

		default : 
			candidate[119:0] 	= 120'b0;

		endcase
	end

endmodule
*/
module Error_probability(input [224:0] candidate, input [119:0] probability, output [134:0] cand_prob);
	genvar i,j,k; // i : candidate 0~14 // j probability 0~14 // k probability [j] [0~7]
	generate 
		
		for(i=0;i<15;i=i+1) begin :gen_cand_prob
			wire [7:0] and_result[14:0];
			for(j=0;j<15;j=j+1) begin : gen_and_result
				if(i!=14-j) begin 
					for(k=0;k<8;k=k+1) begin : gen_and_result_one
						assign and_result[j][k] = candidate[15*i+j] & probability[8*j+k];
					end
				end
				else begin
					assign and_result[j]= 8'b0;
				end
			end
			wire [7:0] or_result;
			assign or_result = and_result[0] | and_result[1] | and_result[2] | and_result[3] | and_result[4] |
			    		   and_result[5] | and_result[6] | and_result[7] | and_result[8] | and_result[9] |
					   and_result[10] | and_result[11] | and_result[12] | and_result[13] | and_result[14];
			assign cand_prob[9*i+8:9*i] = probability[8*(14-i)+7:8*(14-i)] + or_result;
		end
	endgenerate 


endmodule


module Probability_gen(input [14:0] codeword, input[119:0] probability, output [134:0] cand_prob);
	wire[3:0] syndrome;
	wire[3:0] index;
	wire[224:0] candidate;
	Syndrome syndrome_gen(.codeword(codeword),.syndrome(syndrome));
	Candidate candidate_gen(.syndrome(syndrome),.candidate(candidate));
	Error_probability error_prob(.candidate(candidate), .probability(probability), .cand_prob(cand_prob));
endmodule
