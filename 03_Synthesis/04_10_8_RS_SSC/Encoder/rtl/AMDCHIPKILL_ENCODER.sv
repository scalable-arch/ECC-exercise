module AMDCHIPKILL_ENCODER(input [63:0] data_in,
                      output [79:0] codeword_out);
  // data_in: 64-bit input dataward
  // codeword_out: 80-bit RS codeword output

  // over GF(2^8) primitive polynomial, systematic-encoding
  // primitive polynomial = x^8 + x6 + x^4 + x^3 + x^2 + x + 1

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


  wire [7:0] parity [7:0]; // front [7:0] => each element is a size of 8bit, backward [7:0] => eight elements

  GFMULT gmult_00(data_in[63:56],8'b0000_0001, parity[7]); // data[63:56] x a^0 = parity[7] (8bit)
  GFMULT gmult_01(data_in[55:48],8'b0000_0010, parity[6]); // data[55:48] x a^1 = parity[6] (8bit)
  GFMULT gmult_02(data_in[47:40],8'b0000_0100, parity[5]); // data[47:40] x a^2 = parity[5] (8bit)
  GFMULT gmult_03(data_in[39:32],8'b0000_1000, parity[4]); // data[39:32] x a^3 = parity[4] (8bit)
  GFMULT gmult_04(data_in[31:24],8'b0001_0000, parity[3]); // data[31:24] x a^4 = parity[3] (8bit)
  GFMULT gmult_05(data_in[23:16],8'b0010_0000, parity[2]); // data[23:16] x a^5 = parity[2] (8bit)
  GFMULT gmult_06(data_in[15:8] ,8'b0100_0000, parity[1]); // data[15:8]  x a^6 = parity[1] (8bit)
  GFMULT gmult_07(data_in[7:0]  ,8'b1000_0000, parity[0]); // data[7:0]   x a^7 = parity[0] (8bit) 	
  
  assign codeword_out[79:16] = data_in[63:0]; // systematic- encoding
  assign codeword_out[15:8] = data_in[63:56] ^ data_in[55:48] ^ data_in[47:40] ^ data_in[39:32] ^ data_in[31:24] ^ data_in[23:16] ^ data_in[15:8] ^ data_in[7:0];
  assign codeword_out[7:0] = parity[7] ^ parity[6] ^ parity[5] ^ parity[4] ^ parity[3] ^ parity[2] ^ parity[1] ^ parity[0];

endmodule
