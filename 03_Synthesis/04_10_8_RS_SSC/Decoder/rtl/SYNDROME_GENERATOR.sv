module SYNDROME_GENERATOR(input [79:0] codeword_in,
                      output [15:0] syndrome_out);
  // codeword_in: 80-bit RS codeword input
  // syndrome_out : 16-bit syndrome output (two 8-bit syndromes)

  /*
    G-Matrix

    1 0 0 0 0 0 0 0 1 1
    0 1 0 0 0 0 0 0 1 a^1
    0 0 1 0 0 0 0 0 1 a^2
    0 0 0 1 0 0 0 0 1 a^3
    0 0 0 0 1 0 0 0 1 a^4
    0 0 0 0 0 1 0 0 1 a^5
    0 0 0 0 0 0 1 0 1 a^6
    0 0 0 0 0 0 0 1 1 a^7

    H-Matrix

    1 1   1   1   1   1   1   1   1 0 
    1 a^1 a^2 a^3 a^4 a^5 a^6 a^7 0 1 

  */


  wire [7:0] parity [8:0]; // front [7:0] => each element is a size of 8bits, backward [8:0] => nine elements
  GFMULT gmult_00(codeword_in[79:72],8'b0000_0001, parity[8]); // data[79:72] x a^0 = parity[7] (8bit)
  GFMULT gmult_01(codeword_in[71:64],8'b0000_0010, parity[7]); // data[71:64] x a^0 = parity[6] (8bit)
  GFMULT gmult_02(codeword_in[63:56],8'b0000_0100, parity[6]); // data[63:56] x a^0 = parity[5] (8bit)
  GFMULT gmult_03(codeword_in[55:48],8'b0000_1000, parity[5]); // data[55:48] x a^0 = parity[4] (8bit)
  GFMULT gmult_04(codeword_in[47:40],8'b0001_0000, parity[4]); // data[47:40] x a^0 = parity[3] (8bit)
  GFMULT gmult_05(codeword_in[39:32],8'b0010_0000, parity[3]); // data[39:32] x a^0 = parity[2] (8bit)
  GFMULT gmult_06(codeword_in[31:24],8'b0100_0000, parity[2]); // data[31:24] x a^0 = parity[1] (8bit)
  GFMULT gmult_07(codeword_in[23:16],8'b1000_0000, parity[1]); // data[23:16] x a^0 = parity[0] (8bit)
  GFMULT gmult_08(codeword_in[7:0]  ,8'b0000_0001, parity[0]); // data[23:16] x a^0 = parity[0] (8bit)

  assign syndrome_out[15:8] = codeword_in[79:72] ^ codeword_in[71:64] ^ codeword_in[63:56] ^ codeword_in[55:48] ^ codeword_in[47:40] ^ codeword_in[39:32] ^ codeword_in[31:24] ^ codeword_in[23:16] ^ codeword_in[15:8];
  assign syndrome_out[7:0] = parity[8] ^ parity[7] ^ parity[6] ^ parity[5] ^ parity[4] ^ parity[3] ^ parity[2] ^ parity[1] ^ parity[0] ^ codeword_in[7:0];

endmodule

