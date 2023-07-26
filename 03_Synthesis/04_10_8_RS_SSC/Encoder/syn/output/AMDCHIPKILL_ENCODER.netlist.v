/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : Q-2019.12-SP5-5
// Date      : Wed Apr 19 15:04:40 2023
/////////////////////////////////////////////////////////////


module AMDCHIPKILL_ENCODER ( data_in, codeword_out );
  input [63:0] data_in;
  output [79:0] codeword_out;
  wire   n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77,
         n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91,
         n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104,
         n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115,
         n116, n117, n118, n119, n120, n121, n122, n123, n124, n125, n126;
  assign codeword_out[79] = data_in[63];
  assign codeword_out[78] = data_in[62];
  assign codeword_out[77] = data_in[61];
  assign codeword_out[76] = data_in[60];
  assign codeword_out[75] = data_in[59];
  assign codeword_out[74] = data_in[58];
  assign codeword_out[73] = data_in[57];
  assign codeword_out[72] = data_in[56];
  assign codeword_out[71] = data_in[55];
  assign codeword_out[70] = data_in[54];
  assign codeword_out[69] = data_in[53];
  assign codeword_out[68] = data_in[52];
  assign codeword_out[67] = data_in[51];
  assign codeword_out[66] = data_in[50];
  assign codeword_out[65] = data_in[49];
  assign codeword_out[64] = data_in[48];
  assign codeword_out[63] = data_in[47];
  assign codeword_out[62] = data_in[46];
  assign codeword_out[61] = data_in[45];
  assign codeword_out[60] = data_in[44];
  assign codeword_out[59] = data_in[43];
  assign codeword_out[58] = data_in[42];
  assign codeword_out[57] = data_in[41];
  assign codeword_out[56] = data_in[40];
  assign codeword_out[55] = data_in[39];
  assign codeword_out[54] = data_in[38];
  assign codeword_out[53] = data_in[37];
  assign codeword_out[52] = data_in[36];
  assign codeword_out[51] = data_in[35];
  assign codeword_out[50] = data_in[34];
  assign codeword_out[49] = data_in[33];
  assign codeword_out[48] = data_in[32];
  assign codeword_out[47] = data_in[31];
  assign codeword_out[46] = data_in[30];
  assign codeword_out[45] = data_in[29];
  assign codeword_out[44] = data_in[28];
  assign codeword_out[43] = data_in[27];
  assign codeword_out[42] = data_in[26];
  assign codeword_out[41] = data_in[25];
  assign codeword_out[40] = data_in[24];
  assign codeword_out[39] = data_in[23];
  assign codeword_out[38] = data_in[22];
  assign codeword_out[37] = data_in[21];
  assign codeword_out[36] = data_in[20];
  assign codeword_out[35] = data_in[19];
  assign codeword_out[34] = data_in[18];
  assign codeword_out[33] = data_in[17];
  assign codeword_out[32] = data_in[16];
  assign codeword_out[31] = data_in[15];
  assign codeword_out[30] = data_in[14];
  assign codeword_out[29] = data_in[13];
  assign codeword_out[28] = data_in[12];
  assign codeword_out[27] = data_in[11];
  assign codeword_out[26] = data_in[10];
  assign codeword_out[25] = data_in[9];
  assign codeword_out[24] = data_in[8];
  assign codeword_out[23] = data_in[7];
  assign codeword_out[22] = data_in[6];
  assign codeword_out[21] = data_in[5];
  assign codeword_out[20] = data_in[4];
  assign codeword_out[19] = data_in[3];
  assign codeword_out[18] = data_in[2];
  assign codeword_out[17] = data_in[1];
  assign codeword_out[16] = data_in[0];

  STQ_INV_S_0P65 U82 ( .A(n90), .X(n91) );
  STQ_EO3_0P5 U83 ( .A1(n74), .A2(data_in[28]), .A3(data_in[37]), .X(n76) );
  STQ_EO2_S_0P5 U84 ( .A1(n68), .A2(n67), .X(n69) );
  STQ_AO2BB2_1 U85 ( .A1(data_in[15]), .A2(data_in[31]), .B1(data_in[15]), 
        .B2(data_in[31]), .X(n88) );
  STQ_EO2_S_0P5 U86 ( .A1(data_in[32]), .A2(data_in[59]), .X(n93) );
  STQ_EN2_S_2 U87 ( .A1(n92), .A2(n91), .X(n99) );
  STQ_EO2_1 U88 ( .A1(n76), .A2(n75), .X(n95) );
  STQ_EO2_1 U89 ( .A1(n88), .A2(n73), .X(n97) );
  STQ_AO2BB2_1 U90 ( .A1(data_in[22]), .A2(n123), .B1(data_in[22]), .B2(n123), 
        .X(n124) );
  STQ_EO2_1 U91 ( .A1(data_in[17]), .A2(data_in[26]), .X(n77) );
  STQ_EO2_1 U92 ( .A1(data_in[52]), .A2(data_in[61]), .X(n100) );
  STQ_EO2_1 U93 ( .A1(data_in[13]), .A2(data_in[4]), .X(n72) );
  STQ_INV_S_0P65 U94 ( .A(data_in[22]), .X(n71) );
  STQ_EO3_0P5 U95 ( .A1(n86), .A2(data_in[5]), .A3(data_in[14]), .X(n90) );
  STQ_INV_S_0P65 U96 ( .A(data_in[63]), .X(n67) );
  STQ_EO3_1 U97 ( .A1(n65), .A2(data_in[11]), .A3(data_in[29]), .X(n66) );
  STQ_INV_S_0P65 U98 ( .A(data_in[6]), .X(n123) );
  STQ_EO3_0P5 U99 ( .A1(n97), .A2(n103), .A3(n84), .X(n85) );
  STQ_EO3_0P5 U100 ( .A1(data_in[27]), .A2(data_in[36]), .A3(data_in[45]), .X(
        n64) );
  STQ_EO2_S_2 U101 ( .A1(data_in[7]), .A2(data_in[23]), .X(n86) );
  STQ_EO3_0P5 U102 ( .A1(n90), .A2(data_in[18]), .A3(n64), .X(n70) );
  STQ_EO2_S_2 U103 ( .A1(data_in[38]), .A2(data_in[47]), .X(n65) );
  STQ_EO3_0P5 U104 ( .A1(n66), .A2(data_in[2]), .A3(data_in[20]), .X(n104) );
  STQ_EO3_0P5 U105 ( .A1(data_in[54]), .A2(data_in[0]), .A3(data_in[9]), .X(
        n68) );
  STQ_EN3_1 U106 ( .A1(n70), .A2(n104), .A3(n69), .X(codeword_out[7]) );
  STQ_EO3_0P5 U107 ( .A1(n72), .A2(data_in[6]), .A3(n71), .X(n73) );
  STQ_EO2_S_2 U108 ( .A1(data_in[1]), .A2(data_in[10]), .X(n74) );
  STQ_EO3_1 U109 ( .A1(data_in[19]), .A2(data_in[46]), .A3(data_in[55]), .X(
        n75) );
  STQ_EO3_0P5 U110 ( .A1(data_in[8]), .A2(data_in[44]), .A3(data_in[53]), .X(
        n79) );
  STQ_EO3_0P5 U111 ( .A1(n77), .A2(data_in[62]), .A3(data_in[35]), .X(n78) );
  STQ_EO3_0P5 U112 ( .A1(n95), .A2(n79), .A3(n78), .X(n80) );
  STQ_EO2_S_0P5 U113 ( .A1(n97), .A2(n80), .X(codeword_out[6]) );
  STQ_EO2_S_2 U114 ( .A1(n95), .A2(n104), .X(n92) );
  STQ_EO3_0P5 U115 ( .A1(data_in[24]), .A2(data_in[33]), .A3(data_in[51]), .X(
        n81) );
  STQ_EO3_0P5 U116 ( .A1(n81), .A2(data_in[60]), .A3(data_in[42]), .X(n82) );
  STQ_EO2_S_0P5 U117 ( .A1(n92), .A2(n82), .X(codeword_out[4]) );
  STQ_EO3_1 U118 ( .A1(data_in[3]), .A2(data_in[30]), .A3(data_in[12]), .X(n83) );
  STQ_EO3_0P5 U119 ( .A1(n83), .A2(data_in[21]), .A3(data_in[39]), .X(n103) );
  STQ_EO3_0P5 U120 ( .A1(data_in[7]), .A2(data_in[57]), .A3(data_in[48]), .X(
        n84) );
  STQ_EO2_S_0P5 U121 ( .A1(n85), .A2(n92), .X(codeword_out[1]) );
  STQ_EO3_0P5 U122 ( .A1(data_in[39]), .A2(n86), .A3(data_in[63]), .X(n87) );
  STQ_EO3_0P5 U123 ( .A1(data_in[55]), .A2(data_in[47]), .A3(n87), .X(n89) );
  STQ_AO2BB2_0P5 U124 ( .A1(n89), .A2(n88), .B1(n89), .B2(n88), .X(
        codeword_out[15]) );
  STQ_EO3_0P5 U125 ( .A1(n93), .A2(data_in[41]), .A3(data_in[50]), .X(n94) );
  STQ_EO2_S_0P5 U126 ( .A1(n99), .A2(n94), .X(codeword_out[3]) );
  STQ_EO3_0P5 U127 ( .A1(data_in[6]), .A2(data_in[15]), .A3(data_in[56]), .X(
        n96) );
  STQ_EO3_0P5 U128 ( .A1(n96), .A2(n103), .A3(n95), .X(codeword_out[0]) );
  STQ_EO3_0P5 U129 ( .A1(data_in[40]), .A2(data_in[58]), .A3(data_in[49]), .X(
        n98) );
  STQ_EO3_0P5 U130 ( .A1(n99), .A2(n98), .A3(n97), .X(codeword_out[2]) );
  STQ_EO3_0P5 U131 ( .A1(n100), .A2(data_in[16]), .A3(data_in[34]), .X(n101)
         );
  STQ_EO3_0P5 U132 ( .A1(n101), .A2(data_in[25]), .A3(data_in[43]), .X(n102)
         );
  STQ_EO3_0P5 U133 ( .A1(n104), .A2(n103), .A3(n102), .X(codeword_out[5]) );
  STQ_OA2BB2_1 U134 ( .A1(data_in[61]), .A2(data_in[45]), .B1(data_in[45]), 
        .B2(data_in[61]), .X(n105) );
  STQ_EO3_0P5 U135 ( .A1(data_in[21]), .A2(data_in[5]), .A3(n105), .X(n106) );
  STQ_EO3_0P5 U136 ( .A1(data_in[29]), .A2(data_in[53]), .A3(n106), .X(n107)
         );
  STQ_EO3_0P5 U137 ( .A1(n107), .A2(data_in[37]), .A3(data_in[13]), .X(
        codeword_out[13]) );
  STQ_OA2BB2_1 U138 ( .A1(data_in[52]), .A2(data_in[36]), .B1(data_in[36]), 
        .B2(data_in[52]), .X(n108) );
  STQ_EO3_0P5 U139 ( .A1(data_in[12]), .A2(data_in[60]), .A3(n108), .X(n109)
         );
  STQ_EO3_0P5 U140 ( .A1(data_in[20]), .A2(data_in[44]), .A3(n109), .X(n110)
         );
  STQ_EO3_0P5 U141 ( .A1(n110), .A2(data_in[28]), .A3(data_in[4]), .X(
        codeword_out[12]) );
  STQ_OA2BB2_1 U142 ( .A1(data_in[11]), .A2(data_in[51]), .B1(data_in[51]), 
        .B2(data_in[11]), .X(n111) );
  STQ_EO3_0P5 U143 ( .A1(data_in[43]), .A2(data_in[27]), .A3(n111), .X(n112)
         );
  STQ_EO3_0P5 U144 ( .A1(data_in[3]), .A2(data_in[59]), .A3(n112), .X(n113) );
  STQ_EO3_0P5 U145 ( .A1(n113), .A2(data_in[35]), .A3(data_in[19]), .X(
        codeword_out[11]) );
  STQ_OA2BB2_1 U146 ( .A1(data_in[34]), .A2(data_in[18]), .B1(data_in[18]), 
        .B2(data_in[34]), .X(n114) );
  STQ_EO3_0P5 U147 ( .A1(data_in[58]), .A2(data_in[50]), .A3(n114), .X(n115)
         );
  STQ_EO3_0P5 U148 ( .A1(data_in[2]), .A2(data_in[42]), .A3(n115), .X(n116) );
  STQ_EO3_0P5 U149 ( .A1(n116), .A2(data_in[26]), .A3(data_in[10]), .X(
        codeword_out[10]) );
  STQ_OA2BB2_1 U150 ( .A1(data_in[41]), .A2(data_in[33]), .B1(data_in[33]), 
        .B2(data_in[41]), .X(n117) );
  STQ_EO3_0P5 U151 ( .A1(data_in[25]), .A2(data_in[9]), .A3(n117), .X(n118) );
  STQ_EO3_0P5 U152 ( .A1(data_in[57]), .A2(data_in[49]), .A3(n118), .X(n119)
         );
  STQ_EO3_0P5 U153 ( .A1(n119), .A2(data_in[17]), .A3(data_in[1]), .X(
        codeword_out[9]) );
  STQ_OA2BB2_1 U154 ( .A1(data_in[16]), .A2(data_in[0]), .B1(data_in[0]), .B2(
        data_in[16]), .X(n120) );
  STQ_EO3_0P5 U155 ( .A1(data_in[48]), .A2(data_in[56]), .A3(n120), .X(n121)
         );
  STQ_EO3_0P5 U156 ( .A1(data_in[40]), .A2(data_in[32]), .A3(n121), .X(n122)
         );
  STQ_EO3_0P5 U157 ( .A1(n122), .A2(data_in[8]), .A3(data_in[24]), .X(
        codeword_out[8]) );
  STQ_EO3_0P5 U158 ( .A1(n124), .A2(data_in[30]), .A3(data_in[54]), .X(n125)
         );
  STQ_EO3_0P5 U159 ( .A1(data_in[38]), .A2(data_in[14]), .A3(n125), .X(n126)
         );
  STQ_EO3_0P5 U160 ( .A1(data_in[46]), .A2(data_in[62]), .A3(n126), .X(
        codeword_out[14]) );
endmodule

