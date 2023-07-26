module SYNDROME_GENERATOR(input [311:0] codeword_in,
                      output [7:0] syndrome0_out,
                      output [7:0] syndrome1_out,
                      output [7:0] syndrome2_out
                      );


  // GF(2^8)에서의 primitive polynomial 기반 syndrome 생성
  // primitive polynomial = x^8 + x6 + x^4 + x^3 + x^2 + x + 1 => Unity ECC와 같다.

  /*
    G-Matrix는 아래와 같다. (36개 row, 39개 column [symbol 모양])

    1 0 0 0 0 0 0 0 0 0 0 ... 0 1 1    1
    0 1 0 0 0 0 0 0 0 0 0 ... 0 1 a^1  a^2
    0 0 1 0 0 0 0 0 0 0 0 ... 0 1 a^2  a^4
    0 0 0 1 0 0 0 0 0 0 0 ... 0 1 a^3  a^6
    0 0 0 0 1 0 0 0 0 0 0 ... 0 1 a^4  a^8
    0 0 0 0 0 1 0 0 0 0 0 ... 0 1 a^5  a^10
    0 0 0 0 0 0 1 0 0 0 0 ... 0 1 a^6  a^12
    0 0 0 0 0 0 0 1 0 0 0 ... 0 1 a^7  a^14
    ...                       ...
    0 0 0 0 0 0 0 0 0 0 0 ... 1 1 a^35 a^70

    H-Matrix는 아래와 같다. (3개 row, 39개 column [symbol 모양])

    1 1   1   1   1   1    1    1    1    ... 1    1 0 0 
    1 a^1 a^2 a^3 a^4 a^5  a^6  a^7  a^8  ... a^35 0 1 0 
    1 a^2 a^4 a^6 a^8 a^10 a^12 a^14 a^16 ... a^70 0 0 1

  */


  wire [7:0] parity_1 [36:0]; // 앞 [7:0] => 각 element가 8bit 크기, 뒤 [36:0] => element가 37개 있다.
  wire [7:0] parity_2 [36:0]; // 앞 [7:0] => 각 element가 8bit 크기, 뒤 [36:0] => element가 37개 있다.

  // 두번째 parity 생성
  GFMULT gmult_00(codeword_in[311:304],8'b0000_0001, parity_1[36]); 
  GFMULT gmult_01(codeword_in[303:296],8'b0000_0010, parity_1[35]); 
  GFMULT gmult_02(codeword_in[295:288],8'b0000_0100, parity_1[34]); 
  GFMULT gmult_03(codeword_in[287:280],8'b0000_1000, parity_1[33]); 
  GFMULT gmult_04(codeword_in[279:272],8'b0001_0000, parity_1[32]); 
  GFMULT gmult_05(codeword_in[271:264],8'b0010_0000, parity_1[31]); 
  GFMULT gmult_06(codeword_in[263:256],8'b0100_0000, parity_1[30]); 
  GFMULT gmult_07(codeword_in[255:248],8'b1000_0000, parity_1[29]); 
  GFMULT gmult_08(codeword_in[247:240],8'b0101_1111, parity_1[28]); 
  GFMULT gmult_09(codeword_in[239:232],8'b1011_1110, parity_1[27]); 
  GFMULT gmult_10(codeword_in[231:224],8'b0010_0011, parity_1[26]); 
  GFMULT gmult_11(codeword_in[223:216],8'b0100_0110, parity_1[25]); 
  GFMULT gmult_12(codeword_in[215:208],8'b1000_1100, parity_1[24]); 
  GFMULT gmult_13(codeword_in[207:200],8'b0100_0111, parity_1[23]); 
  GFMULT gmult_14(codeword_in[199:192],8'b1000_1110, parity_1[22]); 
  GFMULT gmult_15(codeword_in[191:184],8'b0100_0011, parity_1[21]); 
  GFMULT gmult_16(codeword_in[183:176],8'b1000_0110, parity_1[20]); 
  GFMULT gmult_17(codeword_in[175:168],8'b0101_0011, parity_1[19]); 
  GFMULT gmult_18(codeword_in[167:160],8'b1010_0110, parity_1[18]); 
  GFMULT gmult_19(codeword_in[159:152],8'b0001_0011, parity_1[17]); 
  GFMULT gmult_20(codeword_in[151:144],8'b0010_0110, parity_1[16]); 
  GFMULT gmult_21(codeword_in[143:136],8'b0100_1100, parity_1[15]); 
  GFMULT gmult_22(codeword_in[135:128],8'b1001_1000, parity_1[14]); 
  GFMULT gmult_23(codeword_in[127:120],8'b0110_1111, parity_1[13]); 
  GFMULT gmult_24(codeword_in[119:112],8'b1101_1110, parity_1[12]); 
  GFMULT gmult_25(codeword_in[111:104],8'b1110_0011, parity_1[11]); 
  GFMULT gmult_26(codeword_in[103:96] ,8'b1001_1001, parity_1[10]); 
  GFMULT gmult_27(codeword_in[95:88]  ,8'b0110_1101, parity_1[9]); 
  GFMULT gmult_28(codeword_in[87:80]  ,8'b1101_1010, parity_1[8]); 
  GFMULT gmult_29(codeword_in[79:72]  ,8'b1110_1011, parity_1[7]); 
  GFMULT gmult_30(codeword_in[71:64]  ,8'b1000_1001, parity_1[6]); 
  GFMULT gmult_31(codeword_in[63:56]  ,8'b0100_1101, parity_1[5]); 
  GFMULT gmult_32(codeword_in[55:48]  ,8'b1001_1010, parity_1[4]); 
  GFMULT gmult_33(codeword_in[47:40]  ,8'b0110_1011, parity_1[3]); 
  GFMULT gmult_34(codeword_in[39:32]  ,8'b1101_0110, parity_1[2]); 
  GFMULT gmult_35(codeword_in[31:24]  ,8'b1111_0011, parity_1[1]);
  GFMULT gmult_72(codeword_in[15:8]   ,8'b0000_0001, parity_1[0]); 

  // 세번째 parity 생성
  GFMULT gmult_36(codeword_in[311:304],8'b0000_0001, parity_2[36]); 
  GFMULT gmult_37(codeword_in[303:296],8'b0000_0100, parity_2[35]); 
  GFMULT gmult_38(codeword_in[295:288],8'b0001_0000, parity_2[34]); 
  GFMULT gmult_39(codeword_in[287:280],8'b0100_0000, parity_2[33]); 
  GFMULT gmult_40(codeword_in[279:272],8'b0101_1111, parity_2[32]); 
  GFMULT gmult_41(codeword_in[271:264],8'b0010_0011, parity_2[31]); 
  GFMULT gmult_42(codeword_in[263:256],8'b1000_1100, parity_2[30]); 
  GFMULT gmult_43(codeword_in[255:248],8'b1000_1110, parity_2[29]); 
  GFMULT gmult_44(codeword_in[247:240],8'b1000_0110, parity_2[28]); 
  GFMULT gmult_45(codeword_in[239:232],8'b1010_0110, parity_2[27]); 
  GFMULT gmult_46(codeword_in[231:224],8'b0010_0110, parity_2[26]); 
  GFMULT gmult_47(codeword_in[223:216],8'b1001_1000, parity_2[25]); 
  GFMULT gmult_48(codeword_in[215:208],8'b1101_1110, parity_2[24]); 
  GFMULT gmult_49(codeword_in[207:200],8'b1001_1001, parity_2[23]); 
  GFMULT gmult_50(codeword_in[199:192],8'b1101_1010, parity_2[22]); 
  GFMULT gmult_51(codeword_in[191:184],8'b1000_1001, parity_2[21]); 
  GFMULT gmult_52(codeword_in[183:176],8'b1001_1010, parity_2[20]); 
  GFMULT gmult_53(codeword_in[175:168],8'b1101_0110, parity_2[19]); 
  GFMULT gmult_54(codeword_in[167:160],8'b1011_1001, parity_2[18]); 
  GFMULT gmult_55(codeword_in[159:152],8'b0101_1010, parity_2[17]); 
  GFMULT gmult_56(codeword_in[151:144],8'b0011_0111, parity_2[16]); 
  GFMULT gmult_57(codeword_in[143:136],8'b1101_1100, parity_2[15]); 
  GFMULT gmult_58(codeword_in[135:128],8'b1001_0001, parity_2[14]); 
  GFMULT gmult_59(codeword_in[127:120],8'b1111_1010, parity_2[13]); 
  GFMULT gmult_60(codeword_in[119:112],8'b0000_1001, parity_2[12]); 
  GFMULT gmult_61(codeword_in[111:104],8'b0010_0100, parity_2[11]); 
  GFMULT gmult_62(codeword_in[103:96] ,8'b1001_0000, parity_2[10]); 
  GFMULT gmult_63(codeword_in[95:88]  ,8'b1111_1110, parity_2[9]); 
  GFMULT gmult_64(codeword_in[87:80]  ,8'b0001_1001, parity_2[8]); 
  GFMULT gmult_65(codeword_in[79:72]  ,8'b0110_0100, parity_2[7]); 
  GFMULT gmult_66(codeword_in[71:64]  ,8'b1100_1111, parity_2[6]); 
  GFMULT gmult_67(codeword_in[63:56]  ,8'b1101_1101, parity_2[5]); 
  GFMULT gmult_68(codeword_in[55:48]  ,8'b1001_0101, parity_2[4]); 
  GFMULT gmult_69(codeword_in[47:40]  ,8'b1110_1010, parity_2[3]); 
  GFMULT gmult_70(codeword_in[39:32]  ,8'b0100_1001, parity_2[2]); 
  GFMULT gmult_71(codeword_in[31:24]  ,8'b0111_1011, parity_2[1]);
  GFMULT gmult_73(codeword_in[7:0]    ,8'b0000_0001, parity_2[0]);

  // S0
  assign syndrome0_out = codeword_in[311:304] ^ codeword_in[303:296] ^ codeword_in[295:288] ^ 
  codeword_in[287:280] ^ codeword_in[279:272] ^ codeword_in[271:264] ^ codeword_in[263:256] ^ codeword_in[255:248] ^ 
  codeword_in[247:240] ^ codeword_in[239:232] ^ codeword_in[231:224] ^ codeword_in[223:216] ^ codeword_in[215:208] ^ 
  codeword_in[207:200] ^ codeword_in[199:192] ^ codeword_in[191:184] ^ codeword_in[183:176] ^ codeword_in[175:168] ^
  codeword_in[167:160] ^ codeword_in[159:152] ^ codeword_in[151:144] ^ codeword_in[143:136] ^ codeword_in[135:128] ^
  codeword_in[127:120] ^ codeword_in[119:112] ^ codeword_in[111:104] ^ codeword_in[103:96]  ^ codeword_in[95:88]   ^
  codeword_in[87:80]   ^ codeword_in[79:72]   ^ codeword_in[71:64]   ^ codeword_in[63:56]   ^ codeword_in[55:48]   ^
  codeword_in[47:40]   ^ codeword_in[39:32]   ^ codeword_in[31:24]   ^ codeword_in[23:16];
  // S1
  assign syndrome1_out = parity_1[36] ^ parity_1[35] ^ parity_1[34] ^ parity_1[33] ^ 
  parity_1[32] ^ parity_1[31] ^ parity_1[30] ^ parity_1[29] ^ parity_1[28] ^ 
  parity_1[27] ^ parity_1[26] ^ parity_1[25] ^ parity_1[24] ^ parity_1[23] ^ 
  parity_1[22] ^ parity_1[21] ^ parity_1[20] ^ parity_1[19] ^ parity_1[18] ^ 
  parity_1[17] ^ parity_1[16] ^ parity_1[15] ^ parity_1[14] ^ parity_1[13] ^ 
  parity_1[12] ^ parity_1[11] ^ parity_1[10] ^ parity_1[9]  ^ parity_1[8]  ^ 
  parity_1[7]  ^ parity_1[6]  ^ parity_1[5]  ^ parity_1[4]  ^ parity_1[3]  ^ 
  parity_1[2]  ^ parity_1[1]  ^ parity_1[0];
  // S2
  assign syndrome2_out = parity_2[36] ^ parity_2[35] ^ parity_2[34] ^ parity_2[33] ^ 
  parity_2[32] ^ parity_2[31] ^ parity_2[30] ^ parity_2[29] ^ parity_2[28] ^ 
  parity_2[27] ^ parity_2[26] ^ parity_2[25] ^ parity_2[24] ^ parity_2[23] ^ 
  parity_2[22] ^ parity_2[21] ^ parity_2[20] ^ parity_2[19] ^ parity_2[18] ^ 
  parity_2[17] ^ parity_2[16] ^ parity_2[15] ^ parity_2[14] ^ parity_2[13] ^ 
  parity_2[12] ^ parity_2[11] ^ parity_2[10] ^ parity_2[9]  ^ parity_2[8]  ^ 
  parity_2[7]  ^ parity_2[6]  ^ parity_2[5]  ^ parity_2[4]  ^ parity_2[3]  ^
  parity_2[2]  ^ parity_2[1]  ^ parity_2[0];

  // always_comb begin
  //    $display("codeword         :       %b",codeword_in);
  //   //  $display("parity 1 36      :       %b",parity_1[36]);
  //   //  $display("parity 1 35      :       %b",parity_1[35]);
  //   //  $display("parity 1 calcul  :       %b",parity_1[36]^parity_1[35]);
  //    $display("parity 2 36      :       %b",parity_2[36]);
  //    $display("parity 2 35      :       %b",parity_2[35]);
  //    $display("parity 2 34      :       %b",parity_2[34]);
  //    $display("parity 2 calcul  :       %b",parity_2[36]^parity_2[35]^parity_2[34]);
  //    $display("syndrome0_out : %b",syndrome0_out);
  //    $display("syndrome1_out : %b",syndrome1_out);
  //    $display("syndrome2_out : %b",syndrome2_out);
  //  end

endmodule

