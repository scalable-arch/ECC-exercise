module RS_SSC_DSD_ENCODER(input [287:0] data_in,
                      output [311:0] codeword_out);
  // data_in: 288-bit 입력 데이터
  // codeword_out: 312-bit RS 코드워드 출력

  // GF(2^8)에서의 primitive polynomial 기반 systematic-encoding 진행
  // primitive polynomial = x^8 + x6 + x^4 + x^3 + x^2 + x + 1

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


  wire [7:0] parity_1 [35:0]; // 앞 [7:0] => 각 element가 8bit 크기, 뒤 [35:0] => element가 36개 있다.
  wire [7:0] parity_2 [35:0]; // 앞 [7:0] => 각 element가 8bit 크기, 뒤 [35:0] => element가 36개 있다.

  // 두번째 parity 생성
  GFMULT gmult_00(data_in[287:280],8'b0000_0001, parity_1[35]); // data[287:280] x a^0 = parity[35] (8bit)
  GFMULT gmult_01(data_in[279:272],8'b0000_0010, parity_1[34]); // data[279:272] x a^1 = parity[34] (8bit)
  GFMULT gmult_02(data_in[271:264],8'b0000_0100, parity_1[33]); 
  GFMULT gmult_03(data_in[263:256],8'b0000_1000, parity_1[32]); 
  GFMULT gmult_04(data_in[255:248],8'b0001_0000, parity_1[31]); 
  GFMULT gmult_05(data_in[247:240],8'b0010_0000, parity_1[30]); 
  GFMULT gmult_06(data_in[239:232],8'b0100_0000, parity_1[29]); 
  GFMULT gmult_07(data_in[231:224],8'b1000_0000, parity_1[28]); 
  GFMULT gmult_08(data_in[223:216],8'b0101_1111, parity_1[27]); 
  GFMULT gmult_09(data_in[215:208],8'b1011_1110, parity_1[26]); 
  GFMULT gmult_10(data_in[207:200],8'b0010_0011, parity_1[25]); 
  GFMULT gmult_11(data_in[199:192],8'b0100_0110, parity_1[24]); 
  GFMULT gmult_12(data_in[191:184],8'b1000_1100, parity_1[23]); 
  GFMULT gmult_13(data_in[183:176],8'b0100_0111, parity_1[22]); 
  GFMULT gmult_14(data_in[175:168],8'b1000_1110, parity_1[21]); 
  GFMULT gmult_15(data_in[167:160],8'b0100_0011, parity_1[20]); 
  GFMULT gmult_16(data_in[159:152],8'b1000_0110, parity_1[19]); 
  GFMULT gmult_17(data_in[151:144],8'b0101_0011, parity_1[18]); 
  GFMULT gmult_18(data_in[143:136],8'b1010_0110, parity_1[17]); 
  GFMULT gmult_19(data_in[135:128],8'b0001_0011, parity_1[16]); 
  GFMULT gmult_20(data_in[127:120],8'b0010_0110, parity_1[15]); 
  GFMULT gmult_21(data_in[119:112],8'b0100_1100, parity_1[14]); 
  GFMULT gmult_22(data_in[111:104],8'b1001_1000, parity_1[13]); 
  GFMULT gmult_23(data_in[103:96] ,8'b0110_1111, parity_1[12]); 
  GFMULT gmult_24(data_in[95:88]  ,8'b1101_1110, parity_1[11]); 
  GFMULT gmult_25(data_in[87:80]  ,8'b1110_0011, parity_1[10]); 
  GFMULT gmult_26(data_in[79:72]  ,8'b1001_1001, parity_1[9]); 
  GFMULT gmult_27(data_in[71:64]  ,8'b0110_1101, parity_1[8]); 
  GFMULT gmult_28(data_in[63:56]  ,8'b1101_1010, parity_1[7]); 
  GFMULT gmult_29(data_in[55:48]  ,8'b1110_1011, parity_1[6]); 
  GFMULT gmult_30(data_in[47:40]  ,8'b1000_1001, parity_1[5]); 
  GFMULT gmult_31(data_in[39:32]  ,8'b0100_1101, parity_1[4]); 
  GFMULT gmult_32(data_in[31:24]  ,8'b1001_1010, parity_1[3]); 
  GFMULT gmult_33(data_in[23:16]  ,8'b0110_1011, parity_1[2]); 
  GFMULT gmult_34(data_in[15:8]   ,8'b1101_0110, parity_1[1]); 
  GFMULT gmult_35(data_in[7:0]    ,8'b1111_0011, parity_1[0]); 


  // 세번째 parity 생성
  GFMULT gmult_36(data_in[287:280],8'b0000_0001, parity_2[35]); // data[287:280] x a^0 = parity[35] (8bit)
  GFMULT gmult_37(data_in[279:272],8'b0000_0100, parity_2[34]); // data[279:272] x a^2 = parity[34] (8bit)
  GFMULT gmult_38(data_in[271:264],8'b0001_0000, parity_2[33]); 
  GFMULT gmult_39(data_in[263:256],8'b0100_0000, parity_2[32]); 
  GFMULT gmult_40(data_in[255:248],8'b0101_1111, parity_2[31]); 
  GFMULT gmult_41(data_in[247:240],8'b0010_0011, parity_2[30]); 
  GFMULT gmult_42(data_in[239:232],8'b1000_1100, parity_2[29]); 
  GFMULT gmult_43(data_in[231:224],8'b1000_1110, parity_2[28]); 
  GFMULT gmult_44(data_in[223:216],8'b1000_0110, parity_2[27]); 
  GFMULT gmult_45(data_in[215:208],8'b1010_0110, parity_2[26]); 
  GFMULT gmult_46(data_in[207:200],8'b0010_0110, parity_2[25]); 
  GFMULT gmult_47(data_in[199:192],8'b1001_1000, parity_2[24]); 
  GFMULT gmult_48(data_in[191:184],8'b1101_1110, parity_2[23]); 
  GFMULT gmult_49(data_in[183:176],8'b1001_1001, parity_2[22]); 
  GFMULT gmult_50(data_in[175:168],8'b1101_1010, parity_2[21]); 
  GFMULT gmult_51(data_in[167:160],8'b1000_1001, parity_2[20]); 
  GFMULT gmult_52(data_in[159:152],8'b1001_1010, parity_2[19]); 
  GFMULT gmult_53(data_in[151:144],8'b1101_0110, parity_2[18]); 
  GFMULT gmult_54(data_in[143:136],8'b1011_1001, parity_2[17]); 
  GFMULT gmult_55(data_in[135:128],8'b0101_1010, parity_2[16]); 
  GFMULT gmult_56(data_in[127:120],8'b0011_0111, parity_2[15]); 
  GFMULT gmult_57(data_in[119:112],8'b1101_1100, parity_2[14]); 
  GFMULT gmult_58(data_in[111:104],8'b1001_0001, parity_2[13]); 
  GFMULT gmult_59(data_in[103:96] ,8'b1111_1010, parity_2[12]); 
  GFMULT gmult_60(data_in[95:88]  ,8'b0000_1001, parity_2[11]); 
  GFMULT gmult_61(data_in[87:80]  ,8'b0010_0100, parity_2[10]); 
  GFMULT gmult_62(data_in[79:72]  ,8'b1001_0000, parity_2[9]); 
  GFMULT gmult_63(data_in[71:64]  ,8'b1111_1110, parity_2[8]); 
  GFMULT gmult_64(data_in[63:56]  ,8'b0001_1001, parity_2[7]); 
  GFMULT gmult_65(data_in[55:48]  ,8'b0110_0100, parity_2[6]); 
  GFMULT gmult_66(data_in[47:40]  ,8'b1100_1111, parity_2[5]); 
  GFMULT gmult_67(data_in[39:32]  ,8'b1101_1101, parity_2[4]); 
  GFMULT gmult_68(data_in[31:24]  ,8'b1001_0101, parity_2[3]); 
  GFMULT gmult_69(data_in[23:16]  ,8'b1110_1010, parity_2[2]); 
  GFMULT gmult_70(data_in[15:8]   ,8'b0100_1001, parity_2[1]); 
  GFMULT gmult_71(data_in[7:0]    ,8'b0111_1011, parity_2[0]); 
  
  assign codeword_out[311:24] = data_in[287:0]; // systematic- encoding
  assign codeword_out[23:16] = data_in[287:280] ^ data_in[279:272] ^ data_in[271:264] ^ 
  data_in[263:256] ^ data_in[255:248] ^ data_in[247:240] ^ data_in[239:232] ^ data_in[231:224] ^ 
  data_in[223:216] ^ data_in[215:208] ^ data_in[207:200] ^ data_in[199:192] ^ data_in[191:184] ^ 
  data_in[183:176] ^ data_in[175:168] ^ data_in[167:160] ^ data_in[159:152] ^ data_in[151:144] ^ 
  data_in[143:136] ^ data_in[135:128] ^ data_in[127:120] ^ data_in[119:112] ^ data_in[111:104] ^ 
  data_in[103:96]  ^ data_in[95:88]   ^ data_in[87:80]   ^ data_in[79:72]   ^ data_in[71:64]   ^ 
  data_in[63:56]   ^ data_in[55:48]   ^ data_in[47:40]   ^ data_in[39:32]   ^ data_in[31:24]   ^ 
  data_in[23:16]   ^ data_in[15:8]    ^ data_in[7:0];
  assign codeword_out[15:8] = parity_1[35] ^ parity_1[34] ^ parity_1[33] ^ 
  parity_1[32] ^ parity_1[31] ^ parity_1[30] ^ parity_1[29] ^ parity_1[28] ^ 
  parity_1[27] ^ parity_1[26] ^ parity_1[25] ^ parity_1[24] ^ parity_1[23] ^ 
  parity_1[22] ^ parity_1[21] ^ parity_1[20] ^ parity_1[19] ^ parity_1[18] ^ 
  parity_1[17] ^ parity_1[16] ^ parity_1[15] ^ parity_1[14] ^ parity_1[13] ^ 
  parity_1[12] ^ parity_1[11] ^ parity_1[10] ^ parity_1[9]  ^ parity_1[8]  ^ 
  parity_1[7]  ^ parity_1[6]  ^ parity_1[5]  ^ parity_1[4]  ^ parity_1[3]  ^ 
  parity_1[2]  ^ parity_1[1]  ^ parity_1[0];
  assign codeword_out[7:0] = parity_2[35] ^ parity_2[34] ^ parity_2[33] ^ 
  parity_2[32] ^ parity_2[31] ^ parity_2[30] ^ parity_2[29] ^ parity_2[28] ^ 
  parity_2[27] ^ parity_2[26] ^ parity_2[25] ^ parity_2[24] ^ parity_2[23] ^ 
  parity_2[22] ^ parity_2[21] ^ parity_2[20] ^ parity_2[19] ^ parity_2[18] ^ 
  parity_2[17] ^ parity_2[16] ^ parity_2[15] ^ parity_2[14] ^ parity_2[13] ^ 
  parity_2[12] ^ parity_2[11] ^ parity_2[10] ^ parity_2[9]  ^ parity_2[8]  ^ 
  parity_2[7]  ^ parity_2[6]  ^ parity_2[5]  ^ parity_2[4]  ^ parity_2[3]  ^
  parity_2[2]  ^ parity_2[1]  ^ parity_2[0];

endmodule
