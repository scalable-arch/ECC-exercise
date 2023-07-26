/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : Q-2019.12-SP5-5
// Date      : Thu Apr  6 13:00:03 2023
/////////////////////////////////////////////////////////////


module ERROR_INFORMATION ( Syndrome_in, Error_location_out, Error_value_out, 
        Decode_result_out );
  input [15:0] Syndrome_in;
  output [3:0] Error_location_out;
  output [7:0] Error_value_out;
  output [1:0] Decode_result_out;
  wire   \gfexp_00/n362 , \gfexp_00/n361 , \gfexp_00/n360 , \gfexp_00/n359 ,
         \gfexp_00/n358 , \gfexp_00/n357 , \gfexp_00/n356 , \gfexp_00/n355 ,
         \gfexp_00/n354 , \C1/Z_6 , \C1/Z_5 , \C1/Z_4 , \C1/Z_3 , \C1/Z_2 ,
         \C1/Z_1 , \DP_OP_24J1_122_5749/n8 , \DP_OP_24J1_122_5749/n7 ,
         \DP_OP_24J1_122_5749/n6 , \DP_OP_24J1_122_5749/n5 ,
         \DP_OP_24J1_122_5749/n4 , \DP_OP_24J1_122_5749/n3 ,
         \DP_OP_24J1_122_5749/n2 , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10,
         n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66,
         n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80,
         n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94,
         n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105, n106,
         n107, n108, n109, n110, n111, n112, n113, n114, n115, n116, n117,
         n118, n119, n120, n121, n122, n123, n124, n125, n126, n127, n128,
         n129, n130, n131, n132, n133, n134, n135, n136, n137, n138, n139,
         n140, n141, n142, n143, n144, n145, n146, n147, n148, n149, n150,
         n151, n152, n153, n154, n155, n156, n157, n158, n159, n160, n161,
         n162, n163, n164, n165, n166, n167, n168, n169, n170, n171, n172,
         n173, n174, n175, n176, n177, n178, n179, n180, n181, n182, n183,
         n184, n185, n186, n187, n188, n189, n190, n191, n192, n193, n194,
         n195, n196, n197, n198, n199, n200, n201, n202, n203, n204, n205,
         n206, n207, n208, n209, n210, n211, n212, n213, n214, n215, n216,
         n217, n218, n219, n220, n221, n222, n223, n224, n225, n226, n227,
         n228, n229, n230, n231, n232, n233, n234, n235, n236, n237, n238,
         n239, n240, n241, n242, n243, n244, n245, n246, n247, n248, n249,
         n250, n251, n252, n253, n254, n255, n256, n257, n258, n259, n260,
         n261, n262, n263, n264, n265, n266, n267, n268, n269, n270, n271,
         n272, n273, n274, n275, n276, n277, n278, n279, n280, n281, n282,
         n283, n284, n285, n286, n287, n288, n289, n290, n291, n292, n293,
         n294, n295, n296, n297, n298, n299, n300, n301, n302, n303, n304,
         n305, n306, n307, n308, n309, n310, n311, n312, n313, n314, n315,
         n316, n317, n318, n319, n320, n321, n322, n323, n324, n325, n326,
         n327, n328, n329, n330, n331, n332, n333, n334, n335, n336, n337,
         n338, n339, n340, n341, n342, n343, n344, n345, n346, n347, n348,
         n349, n350, n351, n352, n353, n354, n355, n356, n357, n358, n359,
         n360, n361, n362, n363, n364, n365, n366, n367, n368, n369, n370,
         n371, n372, n373, n374, n375, n376, n377, n378, n379, n380, n381,
         n382, n383, n384, n385, n386, n387, n388, n389, n390, n391, n392,
         n393, n394, n395, n396, n397, n398, n399, n400, n401, n402, n403,
         n404, n405, n406, n407, n408, n409, n410, n411, n412, n413, n414,
         n415, n416, n417, n418, n419, n420, n421, n422, n423, n424, n425,
         n426, n427, n428, n429, n430, n431, n432, n433, n434, n435, n436,
         n437, n438, n439, n440, n441, n442, n443, n444, n445, n446, n447,
         n448, n449, n450, n451, n452, n453, n454, n455, n456, n457, n458,
         n459, n460, n461, n462, n463, n464, n465, n466, n467, n468, n469,
         n470, n471, n472, n473, n474, n475, n476, n477, n478, n479, n480,
         n481, n482, n483, n484, n485, n486, n487, n488, n489, n490, n491,
         n492, n493, n494, n495, n496, n497, n498, n499, n500, n501, n502,
         n503, n504, n505, n506, n507, n508, n509, n510, n511, n512, n513,
         n514, n515, n516, n517, n518, n519, n520, n521, n522, n523, n524,
         n525, n526, n527, n528, n529, n530, n531, n532, n533, n534, n535,
         n536, n537, n538, n539, n540, n541, n542, n543, n544, n545, n546,
         n547, n548, n549, n550, n551, n552, n553, n554, n555, n556, n557,
         n558, n559, n560, n561, n562, n563, n564, n565, n566, n567, n568,
         n569, n570, n571, n572, n573, n574, n575, n576, n577, n578, n579,
         n580, n581, n582, n583, n584, n585, n586, n587, n588, n589, n590,
         n591, n592, n593, n594, n595, n596, n597, n598, n599, n600, n601,
         n602, n603, n604, n605, n606, n607, n608, n609, n610, n611, n612,
         n613, n614, n615, n616, n617, n618, n619, n620, n621, n622, n623,
         n624, n625, n626, n627, n628, n629, n630, n631, n632, n633, n634,
         n635, n636, n637, n638, n639, n640, n641, n642, n643, n644, n645,
         n646, n647, n648, n649, n650, n651, n652, n653, n654, n655, n656,
         n657, n658, n659, n660, n661, n662, n663, n664, n665, n666, n667,
         n668, n669, n670, n671, n672, n673, n674, n675, n676, n677, n678,
         n679, n680, n681, n682, n683, n684, n685, n686, n687, n688, n689,
         n690, n691, n692, n693, n694, n695, n696, n697, n698, n699, n700,
         n701, n702, n703, n704, n705, n706, n707, n708, n709, n710, n711,
         n712, n713, n714, n715, n716, n717, n718, n719, n720, n721, n722,
         n723, n724, n725, n726, n727, n728, n729, n730, n731, n732, n733,
         n734, n735, n736, n737, n738, n739, n740, n741, n742, n743, n744,
         n745, n746, n747, n748, n749, n750, n751, n752, n753, n754, n755,
         n756, n757, n758, n759, n760, n761, n762, n763, n764, n765, n766,
         n767, n768, n769, n770, n771, n772, n773, n774, n775, n776, n777,
         n778, n779, n780, n781, n782, n783, n784, n785, n786, n787, n788,
         n789, n790, n791, n792, n793, n794, n795, n796, n797, n798, n799,
         n800, n801, n802, n803, n804, n805, n806, n807, n808, n809, n812,
         n813, n814, n815, n816, n817, n818, n819, n820;
  wire   [7:0] Syndrome0;
  wire   [7:0] Syndrome1;
  wire   [7:0] Error_location_gfexp;

  STQ_LDPQ_1 \gfexp_01/binv_reg[0]  ( .G(n820), .D(n819), .Q(Syndrome1[0]) );
  STQ_LDPQ_1 \gfexp_01/binv_reg[6]  ( .G(n820), .D(n813), .Q(Syndrome1[6]) );
  STQ_LDPQ_1 \gfexp_00/binv_reg[6]  ( .G(\gfexp_00/n362 ), .D(\gfexp_00/n355 ), 
        .Q(Syndrome0[6]) );
  STQ_LDPQ_1 \gfexp_01/binv_reg[5]  ( .G(n820), .D(n814), .Q(Syndrome1[5]) );
  STQ_LDPQ_1 \gfexp_01/binv_reg[1]  ( .G(n820), .D(n818), .Q(Syndrome1[1]) );
  STQ_LDPQ_1 \gfexp_01/binv_reg[2]  ( .G(n820), .D(n817), .Q(Syndrome1[2]) );
  STQ_LDPQ_1 \gfexp_01/binv_reg[4]  ( .G(n820), .D(n815), .Q(Syndrome1[4]) );
  STQ_LDPQ_1 \gfexp_00/binv_reg[0]  ( .G(\gfexp_00/n362 ), .D(\gfexp_00/n361 ), 
        .Q(Syndrome0[0]) );
  STQ_LDPQ_1 \gfexp_01/binv_reg[7]  ( .G(n820), .D(n812), .Q(Syndrome1[7]) );
  STQ_LDPQ_1 \gfexp_00/binv_reg[7]  ( .G(\gfexp_00/n362 ), .D(\gfexp_00/n354 ), 
        .Q(Syndrome0[7]) );
  STQ_LDPQ_1 \gfexp_00/binv_reg[3]  ( .G(\gfexp_00/n362 ), .D(\gfexp_00/n358 ), 
        .Q(Syndrome0[3]) );
  STQ_LDPQ_1 \gfexp_00/binv_reg[5]  ( .G(\gfexp_00/n362 ), .D(\gfexp_00/n356 ), 
        .Q(Syndrome0[5]) );
  STQ_LDPQ_1 \gfexp_00/binv_reg[1]  ( .G(\gfexp_00/n362 ), .D(\gfexp_00/n360 ), 
        .Q(Syndrome0[1]) );
  STQ_LDPQ_1 \gfexp_01/binv_reg[3]  ( .G(n820), .D(n816), .Q(Syndrome1[3]) );
  STQ_LDPQ_1 \gfexp_00/binv_reg[2]  ( .G(\gfexp_00/n362 ), .D(\gfexp_00/n359 ), 
        .Q(Syndrome0[2]) );
  STQ_LDPQ_1 \gfexp_00/binv_reg[4]  ( .G(\gfexp_00/n362 ), .D(\gfexp_00/n357 ), 
        .Q(Syndrome0[4]) );
  STQ_ADDF_V1_0P5 \DP_OP_24J1_122_5749/U8  ( .A(n809), .B(\C1/Z_1 ), .CI(
        \DP_OP_24J1_122_5749/n8 ), .CO(\DP_OP_24J1_122_5749/n7 ), .S(
        Error_location_gfexp[1]) );
  STQ_ADDF_V1_0P5 \DP_OP_24J1_122_5749/U7  ( .A(n808), .B(\C1/Z_2 ), .CI(
        \DP_OP_24J1_122_5749/n7 ), .CO(\DP_OP_24J1_122_5749/n6 ), .S(
        Error_location_gfexp[2]) );
  STQ_ADDF_V1_0P5 \DP_OP_24J1_122_5749/U6  ( .A(n807), .B(\C1/Z_3 ), .CI(
        \DP_OP_24J1_122_5749/n6 ), .CO(\DP_OP_24J1_122_5749/n5 ), .S(
        Error_location_gfexp[3]) );
  STQ_ADDF_V1_0P5 \DP_OP_24J1_122_5749/U5  ( .A(n806), .B(\C1/Z_4 ), .CI(
        \DP_OP_24J1_122_5749/n5 ), .CO(\DP_OP_24J1_122_5749/n4 ), .S(
        Error_location_gfexp[4]) );
  STQ_ADDF_V1_0P5 \DP_OP_24J1_122_5749/U4  ( .A(n805), .B(\C1/Z_5 ), .CI(
        \DP_OP_24J1_122_5749/n4 ), .CO(\DP_OP_24J1_122_5749/n3 ), .S(
        Error_location_gfexp[5]) );
  STQ_ADDF_V1_0P5 \DP_OP_24J1_122_5749/U3  ( .A(n804), .B(\C1/Z_6 ), .CI(
        \DP_OP_24J1_122_5749/n3 ), .CO(\DP_OP_24J1_122_5749/n2 ), .S(
        Error_location_gfexp[6]) );
  STQ_INV_3 U3 ( .A(n1), .X(n10) );
  STQ_INV_3 U4 ( .A(n802), .X(n1) );
  STQ_NR2_3 U5 ( .A1(Syndrome_in[12]), .A2(Syndrome_in[10]), .X(n19) );
  STQ_NR2_3 U6 ( .A1(Syndrome_in[13]), .A2(Syndrome_in[9]), .X(n20) );
  STQ_INV_S_0P65 U7 ( .A(Syndrome_in[12]), .X(n801) );
  STQ_INV_S_0P65 U8 ( .A(Syndrome_in[14]), .X(n253) );
  STQ_INV_S_0P65 U9 ( .A(Syndrome_in[4]), .X(n800) );
  STQ_NR2_6 U10 ( .A1(Decode_result_out[1]), .A2(n47), .X(Decode_result_out[0]) );
  STQ_AO2BB2_V3_1 U11 ( .A1(Decode_result_out[1]), .A2(n253), .B1(n1), .B2(
        Syndrome_in[6]), .X(Error_value_out[6]) );
  STQ_NR2_3 U12 ( .A1(n2), .A2(n9), .X(Error_location_out[2]) );
  STQ_NR2_G_12 U13 ( .A1(n2), .A2(n44), .X(Decode_result_out[1]) );
  STQ_OAI22_0P75 U14 ( .A1(Decode_result_out[1]), .A2(n801), .B1(n802), .B2(
        n800), .X(Error_value_out[4]) );
  STQ_INV_S_1 U15 ( .A(Syndrome_in[9]), .X(n52) );
  STQ_INV_S_1 U16 ( .A(Syndrome_in[10]), .X(n160) );
  STQ_ND2_9 U17 ( .A1(n15), .A2(n46), .X(n14) );
  STQ_ND2_S_2 U18 ( .A1(n10), .A2(n6), .X(n8) );
  STQ_AN2_S_0P5 U19 ( .A1(n49), .A2(Error_location_gfexp[2]), .X(n5) );
  STQ_AN2_2 U20 ( .A1(n802), .A2(n7), .X(n50) );
  STQ_ND2_S_2 U21 ( .A1(n10), .A2(n5), .X(n9) );
  STQ_EO2_S_0P5 U22 ( .A1(n39), .A2(n38), .X(n40) );
  STQ_INV_1P5 U23 ( .A(Syndrome_in[8]), .X(n55) );
  STQ_NR2_G_3P5 U24 ( .A1(Syndrome_in[14]), .A2(Syndrome_in[8]), .X(n18) );
  STQ_NR2_3 U25 ( .A1(Syndrome_in[15]), .A2(Syndrome_in[11]), .X(n17) );
  STQ_INV_S_1 U26 ( .A(n49), .X(n43) );
  STQ_AN2_1 U27 ( .A1(n49), .A2(Error_location_gfexp[1]), .X(n6) );
  STQ_ND2_S_0P8 U28 ( .A1(n48), .A2(n49), .X(n7) );
  STQ_EO2_S_0P5 U29 ( .A1(\DP_OP_24J1_122_5749/n2 ), .A2(n40), .X(n41) );
  STQ_ND2_S_0P8 U30 ( .A1(n37), .A2(n36), .X(n38) );
  STQ_ND2_S_0P8 U31 ( .A1(Syndrome0[7]), .A2(n37), .X(n34) );
  STQ_NR2_G_5 U32 ( .A1(Syndrome_in[6]), .A2(Syndrome_in[0]), .X(n45) );
  STQ_NR2_G_4 U33 ( .A1(Syndrome_in[7]), .A2(Syndrome_in[5]), .X(n498) );
  STQ_BUF_1 U34 ( .A(Syndrome_in[5]), .X(n107) );
  STQ_NR2_3 U35 ( .A1(n2), .A2(n50), .X(Error_location_out[0]) );
  STQ_NR2_G_2P5 U36 ( .A1(n2), .A2(n8), .X(Error_location_out[1]) );
  STQ_NR2_8 U37 ( .A1(n14), .A2(n16), .X(n2) );
  STQ_BUF_1 U38 ( .A(Syndrome_in[6]), .X(n3) );
  STQ_BUF_1 U39 ( .A(Syndrome_in[0]), .X(n4) );
  STQ_INV_S_0P65 U40 ( .A(Syndrome_in[11]), .X(n803) );
  STQ_INV_S_0P65 U41 ( .A(Syndrome_in[13]), .X(n53) );
  STQ_INV_S_0P65 U42 ( .A(Syndrome1[1]), .X(n22) );
  STQ_INV_S_0P65 U43 ( .A(Syndrome1[2]), .X(n24) );
  STQ_INV_S_0P65 U44 ( .A(Syndrome1[4]), .X(n28) );
  STQ_INV_S_0P65 U45 ( .A(Syndrome0[3]), .X(n26) );
  STQ_INV_S_0P65 U46 ( .A(Syndrome0[5]), .X(n30) );
  STQ_INV_S_0P65 U47 ( .A(Syndrome0[6]), .X(n96) );
  STQ_INV_S_0P65 U48 ( .A(Syndrome1[6]), .X(n95) );
  STQ_INV_S_0P65 U49 ( .A(Syndrome1[7]), .X(n37) );
  STQ_INV_S_0P65 U50 ( .A(Syndrome0[7]), .X(n36) );
  STQ_AOI22_0P75 U51 ( .A1(Syndrome1[7]), .A2(n36), .B1(n35), .B2(n34), .X(n99) );
  STQ_AOI21_0P75 U52 ( .A1(n31), .A2(n30), .B(Syndrome1[5]), .X(n33) );
  STQ_INV_S_0P65 U53 ( .A(Syndrome_in[15]), .X(n54) );
  STQ_BUF_1 U54 ( .A(Syndrome_in[3]), .X(n56) );
  STQ_INV_S_0P65 U55 ( .A(Syndrome_in[1]), .X(n57) );
  STQ_NR2_2 U56 ( .A1(n14), .A2(n21), .X(n47) );
  STQ_ND3_2 U57 ( .A1(n45), .A2(n498), .A3(n1), .X(n21) );
  STQ_ND4_MM_8 U58 ( .A1(n17), .A2(n20), .A3(n19), .A4(n18), .X(n802) );
  STQ_AO2BB2_V3_1 U59 ( .A1(Decode_result_out[1]), .A2(n52), .B1(n296), .B2(n1), .X(Error_value_out[1]) );
  STQ_ND2_G_4 U60 ( .A1(n11), .A2(n13), .X(Error_location_out[3]) );
  STQ_OAI21_2 U61 ( .A1(n16), .A2(n14), .B(n1), .X(n13) );
  STQ_NR2_6 U62 ( .A1(Syndrome_in[4]), .A2(Syndrome_in[3]), .X(n46) );
  STQ_AO2BB2_V3_1 U63 ( .A1(Decode_result_out[1]), .A2(n803), .B1(n1), .B2(n56), .X(Error_value_out[3]) );
  STQ_OR3B_2 U64 ( .B1(n1), .B2(n16), .A(n12), .X(n11) );
  STQ_INV_1P5 U65 ( .A(n14), .X(n12) );
  STQ_NR2_6 U66 ( .A1(Syndrome_in[1]), .A2(Syndrome_in[2]), .X(n15) );
  STQ_AO2BB2_0P5 U67 ( .A1(Decode_result_out[1]), .A2(n53), .B1(n1), .B2(
        Syndrome_in[5]), .X(Error_value_out[5]) );
  STQ_AO2BB2_0P5 U68 ( .A1(Decode_result_out[1]), .A2(n54), .B1(n1), .B2(
        Syndrome_in[7]), .X(Error_value_out[7]) );
  STQ_AO2BB2_0P5 U69 ( .A1(Decode_result_out[1]), .A2(n160), .B1(n1), .B2(n51), 
        .X(Error_value_out[2]) );
  STQ_AO2BB2_0P5 U70 ( .A1(Decode_result_out[1]), .A2(n55), .B1(Syndrome_in[0]), .B2(n1), .X(Error_value_out[0]) );
  STQ_ND2_S_10 U71 ( .A1(n45), .A2(n498), .X(n16) );
  STQ_ND4_MM_1 U72 ( .A1(n390), .A2(n309), .A3(n688), .A4(n308), .X(n310) );
  STQ_ND4_MM_1 U73 ( .A1(n367), .A2(n366), .A3(n365), .A4(n765), .X(n421) );
  STQ_ND4_MM_1 U74 ( .A1(n732), .A2(n731), .A3(n730), .A4(n729), .X(n733) );
  STQ_ND4_MM_1 U75 ( .A1(n587), .A2(n710), .A3(n559), .A4(n351), .X(n451) );
  STQ_ND4_MM_1 U76 ( .A1(n177), .A2(n228), .A3(n121), .A4(n120), .X(n136) );
  STQ_ND4_MM_1 U77 ( .A1(n393), .A2(n392), .A3(n391), .A4(n390), .X(n414) );
  STQ_ND4_MM_1 U78 ( .A1(n540), .A2(n657), .A3(n530), .A4(n471), .X(n472) );
  STQ_ND4_MM_1 U79 ( .A1(n308), .A2(n106), .A3(n305), .A4(n226), .X(n684) );
  STQ_ND4_MM_1 U80 ( .A1(n768), .A2(n767), .A3(n766), .A4(n765), .X(n786) );
  STQ_ND4_MM_1 U81 ( .A1(n672), .A2(n529), .A3(n528), .A4(n527), .X(n550) );
  STQ_OAI21_0P5 U82 ( .A1(Syndrome0[1]), .A2(n22), .B(Syndrome0[0]), .X(n23)
         );
  STQ_AO2BB2_0P5 U83 ( .A1(Syndrome1[0]), .A2(n23), .B1(Syndrome0[1]), .B2(n22), .X(n25) );
  STQ_MAJI3_1 U84 ( .A1(Syndrome0[2]), .A2(n25), .A3(n24), .X(n27) );
  STQ_MAJI3_1 U85 ( .A1(Syndrome1[3]), .A2(n27), .A3(n26), .X(n29) );
  STQ_MAJI3_1 U86 ( .A1(Syndrome0[4]), .A2(n29), .A3(n28), .X(n31) );
  STQ_OAI22_0P5 U87 ( .A1(n31), .A2(n30), .B1(Syndrome1[6]), .B2(n96), .X(n32)
         );
  STQ_OAI22_0P5 U88 ( .A1(n33), .A2(n32), .B1(Syndrome0[6]), .B2(n95), .X(n35)
         );
  STQ_MUXI2_MG_0P75 U89 ( .D0(Syndrome0[7]), .D1(Syndrome1[7]), .S(n99), .X(
        n39) );
  STQ_OR3_1 U90 ( .A1(Error_location_gfexp[6]), .A2(Error_location_gfexp[3]), 
        .A3(n41), .X(n42) );
  STQ_NR3_G_1 U91 ( .A1(Error_location_gfexp[4]), .A2(Error_location_gfexp[5]), 
        .A3(n42), .X(n49) );
  STQ_ND2_G_2 U92 ( .A1(n802), .A2(n43), .X(n44) );
  STQ_MUXI2_MG_0P75 U93 ( .D0(Syndrome0[0]), .D1(Syndrome1[0]), .S(n99), .X(
        n98) );
  STQ_MUX2_1 U94 ( .D0(Syndrome1[0]), .D1(Syndrome0[0]), .S(n99), .X(n97) );
  STQ_EN2_S_1 U95 ( .A1(n98), .A2(n97), .X(n48) );
  STQ_BUF_1 U96 ( .A(Syndrome_in[2]), .X(n51) );
  STQ_INV_S_0P65 U97 ( .A(n51), .X(n188) );
  STQ_INV_S_1 U98 ( .A(n57), .X(n296) );
  STQ_INV_S_0P65 U99 ( .A(n4), .X(n59) );
  STQ_ND3_0P5 U100 ( .A1(n296), .A2(n56), .A3(n59), .X(n73) );
  STQ_INV_S_0P65 U101 ( .A(n73), .X(n190) );
  STQ_INV_S_0P65 U102 ( .A(n3), .X(n187) );
  STQ_INV_S_0P65 U103 ( .A(n800), .X(n110) );
  STQ_ND2_S_0P8 U104 ( .A1(n187), .A2(n110), .X(n192) );
  STQ_NR2_G_0P5 U105 ( .A1(n192), .A2(n51), .X(n62) );
  STQ_ND2_S_0P8 U106 ( .A1(n190), .A2(n62), .X(n635) );
  STQ_NR2_G_0P5 U107 ( .A1(n296), .A2(n56), .X(n513) );
  STQ_ND2_S_0P8 U108 ( .A1(n513), .A2(n59), .X(n63) );
  STQ_INV_S_0P65 U109 ( .A(n63), .X(n241) );
  STQ_NR2_G_0P5 U110 ( .A1(n51), .A2(n187), .X(n240) );
  STQ_ND2_S_0P8 U111 ( .A1(n240), .A2(n800), .X(n170) );
  STQ_INV_S_0P65 U112 ( .A(n170), .X(n124) );
  STQ_ND2_S_0P8 U113 ( .A1(n241), .A2(n124), .X(n401) );
  STQ_NR2_G_0P5 U114 ( .A1(n110), .A2(n3), .X(n127) );
  STQ_ND2_S_0P8 U115 ( .A1(n51), .A2(n127), .X(n70) );
  STQ_INV_S_0P65 U116 ( .A(n70), .X(n511) );
  STQ_ND2_S_0P8 U117 ( .A1(n57), .A2(n56), .X(n64) );
  STQ_INV_S_0P65 U118 ( .A(n64), .X(n307) );
  STQ_ND2_S_0P8 U119 ( .A1(n4), .A2(n307), .X(n523) );
  STQ_INV_S_0P65 U120 ( .A(n523), .X(n512) );
  STQ_ND2_S_0P8 U121 ( .A1(n511), .A2(n512), .X(n323) );
  STQ_ND2_S_0P8 U122 ( .A1(n110), .A2(n51), .X(n71) );
  STQ_INV_S_0P65 U123 ( .A(n71), .X(n668) );
  STQ_ND2_S_0P8 U124 ( .A1(n3), .A2(n668), .X(n119) );
  STQ_INV_S_0P65 U125 ( .A(n513), .X(n114) );
  STQ_NR2_G_0P5 U126 ( .A1(n59), .A2(n114), .X(n105) );
  STQ_INV_S_0P65 U127 ( .A(n105), .X(n72) );
  STQ_NR2_G_0P5 U128 ( .A1(n119), .A2(n72), .X(n407) );
  STQ_ND2_S_0P8 U129 ( .A1(n127), .A2(n188), .X(n317) );
  STQ_NR2_G_0P5 U130 ( .A1(n317), .A2(n73), .X(n302) );
  STQ_NR2_G_0P5 U131 ( .A1(n407), .A2(n302), .X(n536) );
  STQ_ND2_S_0P8 U132 ( .A1(n110), .A2(n240), .X(n118) );
  STQ_INV_S_0P65 U133 ( .A(n118), .X(n220) );
  STQ_NR2_G_0P5 U134 ( .A1(n56), .A2(n57), .X(n481) );
  STQ_ND2_S_0P8 U135 ( .A1(n481), .A2(n59), .X(n128) );
  STQ_INV_S_0P65 U136 ( .A(n128), .X(n219) );
  STQ_ND2_S_0P8 U137 ( .A1(n220), .A2(n219), .X(n670) );
  STQ_ND3_0P5 U138 ( .A1(n51), .A2(n3), .A3(n800), .X(n522) );
  STQ_NR2_G_0P5 U139 ( .A1(n522), .A2(n523), .X(n474) );
  STQ_INV_S_0P65 U140 ( .A(n474), .X(n396) );
  STQ_INV_S_0P65 U141 ( .A(n522), .X(n69) );
  STQ_ND2_S_0P8 U142 ( .A1(n190), .A2(n69), .X(n669) );
  STQ_ND4_MM_1 U143 ( .A1(n536), .A2(n670), .A3(n396), .A4(n669), .X(n58) );
  STQ_AN4B_0P5 U144 ( .B1(n635), .B2(n401), .B3(n323), .A(n58), .X(n495) );
  STQ_INV_S_0P65 U145 ( .A(n127), .X(n215) );
  STQ_NR2_G_0P5 U146 ( .A1(n215), .A2(n63), .X(n632) );
  STQ_INV_S_0P65 U147 ( .A(n62), .X(n214) );
  STQ_ND2_S_0P8 U148 ( .A1(n4), .A2(n296), .X(n316) );
  STQ_NR2_G_0P5 U149 ( .A1(n316), .A2(n56), .X(n112) );
  STQ_INV_S_0P65 U150 ( .A(n112), .X(n129) );
  STQ_ND2_S_0P8 U151 ( .A1(n307), .A2(n59), .X(n193) );
  STQ_INV_S_0P65 U152 ( .A(n193), .X(n68) );
  STQ_NR2_G_0P5 U153 ( .A1(n3), .A2(n71), .X(n480) );
  STQ_ND2_S_0P8 U154 ( .A1(n68), .A2(n480), .X(n477) );
  STQ_OAI21_0P5 U155 ( .A1(n214), .A2(n129), .B(n477), .X(n510) );
  STQ_NR2_G_0P5 U156 ( .A1(n128), .A2(n70), .X(n653) );
  STQ_NR2_G_0P5 U157 ( .A1(n128), .A2(n214), .X(n485) );
  STQ_NR2_G_0P5 U158 ( .A1(n653), .A2(n485), .X(n186) );
  STQ_OAI21_0P5 U159 ( .A1(n317), .A2(n316), .B(n186), .X(n294) );
  STQ_ND2_S_0P8 U160 ( .A1(n241), .A2(n62), .X(n222) );
  STQ_ND2_S_0P8 U161 ( .A1(n112), .A2(n480), .X(n634) );
  STQ_NR2_G_0P5 U162 ( .A1(n170), .A2(n523), .X(n183) );
  STQ_AN3B_0P5 U163 ( .B1(n222), .B2(n634), .A(n183), .X(n116) );
  STQ_INV_S_0P65 U164 ( .A(n119), .X(n216) );
  STQ_ND2B_MM_1 U165 ( .A(n316), .B(n56), .X(n213) );
  STQ_INV_S_0P65 U166 ( .A(n213), .X(n667) );
  STQ_ND2_S_0P8 U167 ( .A1(n216), .A2(n667), .X(n471) );
  STQ_INV_S_0P65 U168 ( .A(n471), .X(n519) );
  STQ_NR2_G_0P5 U169 ( .A1(n213), .A2(n170), .X(n652) );
  STQ_INV_S_0P65 U170 ( .A(n498), .X(n678) );
  STQ_NR3_G_0P65 U171 ( .A1(n519), .A2(n652), .A3(n678), .X(n60) );
  STQ_ND2_S_0P8 U172 ( .A1(n219), .A2(n69), .X(n405) );
  STQ_ND3_0P5 U173 ( .A1(n116), .A2(n60), .A3(n405), .X(n61) );
  STQ_NR4_0P5 U174 ( .A1(n632), .A2(n510), .A3(n294), .A4(n61), .X(n76) );
  STQ_ND2_S_0P8 U175 ( .A1(n216), .A2(n68), .X(n319) );
  STQ_NR2_G_0P5 U176 ( .A1(n523), .A2(n214), .X(n398) );
  STQ_INV_S_0P65 U177 ( .A(n398), .X(n318) );
  STQ_ND2_S_0P8 U178 ( .A1(n105), .A2(n124), .X(n664) );
  STQ_ND2_S_0P8 U179 ( .A1(n667), .A2(n62), .X(n475) );
  STQ_NR2_G_0P5 U180 ( .A1(n118), .A2(n73), .X(n644) );
  STQ_NR2_G_0P5 U181 ( .A1(n128), .A2(n170), .X(n235) );
  STQ_NR2_G_0P5 U182 ( .A1(n644), .A2(n235), .X(n109) );
  STQ_INV_S_0P65 U183 ( .A(n109), .X(n506) );
  STQ_AN4B_0P5 U184 ( .B1(n318), .B2(n664), .B3(n475), .A(n506), .X(n66) );
  STQ_NR2_G_0P5 U185 ( .A1(n70), .A2(n213), .X(n520) );
  STQ_NR2_G_0P5 U186 ( .A1(n119), .A2(n63), .X(n182) );
  STQ_NR2_G_0P5 U187 ( .A1(n520), .A2(n182), .X(n658) );
  STQ_NR2_G_0P5 U188 ( .A1(n119), .A2(n129), .X(n201) );
  STQ_NR2_G_0P5 U189 ( .A1(n70), .A2(n193), .X(n322) );
  STQ_NR2_G_0P5 U190 ( .A1(n201), .A2(n322), .X(n503) );
  STQ_ND2_S_0P8 U191 ( .A1(n105), .A2(n62), .X(n649) );
  STQ_ND3_0P5 U192 ( .A1(n658), .A2(n503), .A3(n649), .X(n171) );
  STQ_NR2_G_0P5 U193 ( .A1(n118), .A2(n63), .X(n526) );
  STQ_INV_S_0P65 U194 ( .A(n480), .X(n301) );
  STQ_NR2_G_0P5 U195 ( .A1(n213), .A2(n301), .X(n204) );
  STQ_NR2_G_0P5 U196 ( .A1(n526), .A2(n204), .X(n504) );
  STQ_NR2_G_0P5 U197 ( .A1(n522), .A2(n213), .X(n654) );
  STQ_ND2_S_0P8 U198 ( .A1(n216), .A2(n512), .X(n633) );
  STQ_INV_S_0P65 U199 ( .A(n633), .X(n298) );
  STQ_NR2_G_0P5 U200 ( .A1(n654), .A2(n298), .X(n647) );
  STQ_NR2_G_0P5 U201 ( .A1(n72), .A2(n70), .X(n501) );
  STQ_INV_S_0P65 U202 ( .A(n501), .X(n468) );
  STQ_ND2_S_0P8 U203 ( .A1(n241), .A2(n480), .X(n208) );
  STQ_ND4_MM_1 U204 ( .A1(n504), .A2(n647), .A3(n468), .A4(n208), .X(n189) );
  STQ_NR2_G_0P5 U205 ( .A1(n118), .A2(n72), .X(n384) );
  STQ_NR2_G_0P5 U206 ( .A1(n73), .A2(n70), .X(n385) );
  STQ_NR2_G_0P5 U207 ( .A1(n317), .A2(n523), .X(n239) );
  STQ_NR2_G_0P5 U208 ( .A1(n385), .A2(n239), .X(n402) );
  STQ_ND2_S_0P8 U209 ( .A1(n68), .A2(n124), .X(n656) );
  STQ_ND2_S_0P8 U210 ( .A1(n402), .A2(n656), .X(n207) );
  STQ_NR2_G_0P5 U211 ( .A1(n384), .A2(n207), .X(n646) );
  STQ_AOAI211_0P75 U212 ( .A1(n213), .A2(n64), .B(n118), .C(n646), .X(n545) );
  STQ_NR3_G_0P65 U213 ( .A1(n171), .A2(n189), .A3(n545), .X(n65) );
  STQ_ND2_S_0P8 U214 ( .A1(n69), .A2(n241), .X(n482) );
  STQ_NR2_G_0P5 U215 ( .A1(n73), .A2(n301), .X(n389) );
  STQ_INV_S_0P65 U216 ( .A(n389), .X(n200) );
  STQ_ND4_MM_1 U217 ( .A1(n66), .A2(n65), .A3(n482), .A4(n200), .X(n293) );
  STQ_NR2B_1 U218 ( .A(n319), .B(n293), .X(n392) );
  STQ_NR2_G_0P5 U219 ( .A1(n193), .A2(n214), .X(n203) );
  STQ_AOI31_0P5 U220 ( .A1(n3), .A2(n112), .A3(n71), .B(n203), .X(n67) );
  STQ_INV_S_0P65 U221 ( .A(n317), .X(n113) );
  STQ_ND2_S_0P8 U222 ( .A1(n219), .A2(n113), .X(n538) );
  STQ_ND2_S_0P8 U223 ( .A1(n67), .A2(n538), .X(n640) );
  STQ_ND2_S_0P8 U224 ( .A1(n69), .A2(n68), .X(n326) );
  STQ_NR2_G_0P5 U225 ( .A1(n70), .A2(n129), .X(n386) );
  STQ_ND2_S_0P8 U226 ( .A1(n105), .A2(n480), .X(n394) );
  STQ_OAI21_0P5 U227 ( .A1(n71), .A2(n128), .B(n394), .X(n648) );
  STQ_NR2_G_0P5 U228 ( .A1(n72), .A2(n522), .X(n314) );
  STQ_NR2_G_0P5 U229 ( .A1(n119), .A2(n73), .X(n306) );
  STQ_NR2_G_0P5 U230 ( .A1(n314), .A2(n306), .X(n391) );
  STQ_ND2_S_0P8 U231 ( .A1(n512), .A2(n480), .X(n665) );
  STQ_ND2_S_0P8 U232 ( .A1(n391), .A2(n665), .X(n174) );
  STQ_NR4B_1 U233 ( .A(n326), .B1(n386), .B2(n648), .B3(n174), .X(n74) );
  STQ_ND2_S_0P8 U234 ( .A1(n190), .A2(n124), .X(n476) );
  STQ_NR2_G_0P5 U235 ( .A1(n317), .A2(n193), .X(n521) );
  STQ_INV_S_0P65 U236 ( .A(n521), .X(n304) );
  STQ_ND4B_1 U237 ( .A(n640), .B1(n74), .B2(n476), .B3(n304), .X(n661) );
  STQ_INV_S_0P65 U238 ( .A(n661), .X(n75) );
  STQ_ND4_MM_1 U239 ( .A1(n495), .A2(n76), .A3(n392), .A4(n75), .X(
        \gfexp_00/n362 ) );
  STQ_ND3_0P5 U240 ( .A1(Syndrome_in[9]), .A2(Syndrome_in[11]), .A3(n55), .X(
        n91) );
  STQ_INV_S_0P65 U241 ( .A(n91), .X(n452) );
  STQ_ND2_S_0P8 U242 ( .A1(n253), .A2(Syndrome_in[12]), .X(n428) );
  STQ_NR2_G_0P5 U243 ( .A1(n428), .A2(Syndrome_in[10]), .X(n80) );
  STQ_ND2_S_0P8 U244 ( .A1(n452), .A2(n80), .X(n788) );
  STQ_NR2_G_0P5 U245 ( .A1(Syndrome_in[9]), .A2(Syndrome_in[11]), .X(n595) );
  STQ_ND2_S_0P8 U246 ( .A1(n595), .A2(n55), .X(n81) );
  STQ_INV_S_0P65 U247 ( .A(n81), .X(n369) );
  STQ_NR2_G_0P5 U248 ( .A1(Syndrome_in[10]), .A2(n253), .X(n368) );
  STQ_ND2_S_0P8 U249 ( .A1(n368), .A2(n801), .X(n144) );
  STQ_INV_S_0P65 U250 ( .A(n144), .X(n275) );
  STQ_ND2_S_0P8 U251 ( .A1(n369), .A2(n275), .X(n746) );
  STQ_NR2_G_0P5 U252 ( .A1(Syndrome_in[12]), .A2(Syndrome_in[14]), .X(n279) );
  STQ_ND2_S_0P8 U253 ( .A1(Syndrome_in[10]), .A2(n279), .X(n88) );
  STQ_INV_S_0P65 U254 ( .A(n88), .X(n593) );
  STQ_ND2_S_0P8 U255 ( .A1(n52), .A2(Syndrome_in[11]), .X(n82) );
  STQ_INV_S_0P65 U256 ( .A(n82), .X(n435) );
  STQ_ND2_S_0P8 U257 ( .A1(Syndrome_in[8]), .A2(n435), .X(n603) );
  STQ_INV_S_0P65 U258 ( .A(n603), .X(n594) );
  STQ_ND2_S_0P8 U259 ( .A1(n593), .A2(n594), .X(n701) );
  STQ_ND2_S_0P8 U260 ( .A1(Syndrome_in[12]), .A2(Syndrome_in[10]), .X(n89) );
  STQ_INV_S_0P65 U261 ( .A(n89), .X(n728) );
  STQ_ND2_S_0P8 U262 ( .A1(Syndrome_in[14]), .A2(n728), .X(n266) );
  STQ_INV_S_0P65 U263 ( .A(n595), .X(n262) );
  STQ_NR2_G_0P5 U264 ( .A1(n55), .A2(n262), .X(n143) );
  STQ_INV_S_0P65 U265 ( .A(n143), .X(n90) );
  STQ_NR2_G_0P5 U266 ( .A1(n266), .A2(n90), .X(n358) );
  STQ_ND2_S_0P8 U267 ( .A1(n279), .A2(n160), .X(n445) );
  STQ_NR2_G_0P5 U268 ( .A1(n445), .A2(n91), .X(n343) );
  STQ_NR2_G_0P5 U269 ( .A1(n358), .A2(n343), .X(n614) );
  STQ_ND2_S_0P8 U270 ( .A1(Syndrome_in[12]), .A2(n368), .X(n259) );
  STQ_INV_S_0P65 U271 ( .A(n259), .X(n775) );
  STQ_NR2_G_0P5 U272 ( .A1(Syndrome_in[11]), .A2(n52), .X(n774) );
  STQ_ND2_S_0P8 U273 ( .A1(n774), .A2(n55), .X(n267) );
  STQ_INV_S_0P65 U274 ( .A(n267), .X(n348) );
  STQ_ND2_S_0P8 U275 ( .A1(n775), .A2(n348), .X(n730) );
  STQ_ND3_0P5 U276 ( .A1(Syndrome_in[10]), .A2(Syndrome_in[14]), .A3(n801), 
        .X(n602) );
  STQ_NR2_G_0P5 U277 ( .A1(n602), .A2(n603), .X(n749) );
  STQ_INV_S_0P65 U278 ( .A(n749), .X(n152) );
  STQ_INV_S_0P65 U279 ( .A(n602), .X(n87) );
  STQ_ND2_S_0P8 U280 ( .A1(n452), .A2(n87), .X(n729) );
  STQ_ND4_MM_1 U281 ( .A1(n614), .A2(n730), .A3(n152), .A4(n729), .X(n77) );
  STQ_AN4B_0P5 U282 ( .B1(n788), .B2(n746), .B3(n701), .A(n77), .X(n579) );
  STQ_INV_S_0P65 U283 ( .A(n279), .X(n339) );
  STQ_NR2_G_0P5 U284 ( .A1(n339), .A2(n81), .X(n690) );
  STQ_INV_S_0P65 U285 ( .A(n80), .X(n338) );
  STQ_ND2_S_0P8 U286 ( .A1(Syndrome_in[8]), .A2(Syndrome_in[9]), .X(n444) );
  STQ_NR2_G_0P5 U287 ( .A1(n444), .A2(Syndrome_in[11]), .X(n154) );
  STQ_INV_S_0P65 U288 ( .A(n154), .X(n280) );
  STQ_ND2_S_0P8 U289 ( .A1(n435), .A2(n55), .X(n429) );
  STQ_INV_S_0P65 U290 ( .A(n429), .X(n86) );
  STQ_NR2_G_0P5 U291 ( .A1(Syndrome_in[14]), .A2(n89), .X(n567) );
  STQ_ND2_S_0P8 U292 ( .A1(n86), .A2(n567), .X(n758) );
  STQ_OAI21_0P5 U293 ( .A1(n338), .A2(n280), .B(n758), .X(n592) );
  STQ_NR2_G_0P5 U294 ( .A1(n267), .A2(n88), .X(n778) );
  STQ_NR2_G_0P5 U295 ( .A1(n267), .A2(n338), .X(n699) );
  STQ_NR2_G_0P5 U296 ( .A1(n778), .A2(n699), .X(n768) );
  STQ_OAI21_0P5 U297 ( .A1(n445), .A2(n444), .B(n768), .X(n420) );
  STQ_ND2_S_0P8 U298 ( .A1(n369), .A2(n80), .X(n431) );
  STQ_ND2_S_0P8 U299 ( .A1(n154), .A2(n567), .X(n692) );
  STQ_NR2_G_0P5 U300 ( .A1(n144), .A2(n603), .X(n359) );
  STQ_AN3B_0P5 U301 ( .B1(n431), .B2(n692), .A(n359), .X(n264) );
  STQ_INV_S_0P65 U302 ( .A(n266), .X(n340) );
  STQ_ND2B_MM_1 U303 ( .A(n444), .B(Syndrome_in[11]), .X(n337) );
  STQ_INV_S_0P65 U304 ( .A(n337), .X(n727) );
  STQ_ND2_S_0P8 U305 ( .A1(n340), .A2(n727), .X(n706) );
  STQ_INV_S_0P65 U306 ( .A(n706), .X(n689) );
  STQ_NR2_G_0P5 U307 ( .A1(n337), .A2(n144), .X(n714) );
  STQ_NR2_G_0P5 U308 ( .A1(Syndrome_in[15]), .A2(Syndrome_in[13]), .X(n792) );
  STQ_INV_S_0P65 U309 ( .A(n792), .X(n737) );
  STQ_NR3_G_0P65 U310 ( .A1(n689), .A2(n714), .A3(n737), .X(n78) );
  STQ_ND2_S_0P8 U311 ( .A1(n348), .A2(n87), .X(n430) );
  STQ_ND3_0P5 U312 ( .A1(n264), .A2(n78), .A3(n430), .X(n79) );
  STQ_NR4_0P5 U313 ( .A1(n690), .A2(n592), .A3(n420), .A4(n79), .X(n94) );
  STQ_ND2_S_0P8 U314 ( .A1(n340), .A2(n86), .X(n447) );
  STQ_NR2_G_0P5 U315 ( .A1(n603), .A2(n338), .X(n700) );
  STQ_INV_S_0P65 U316 ( .A(n700), .X(n446) );
  STQ_ND2_S_0P8 U317 ( .A1(n143), .A2(n275), .X(n724) );
  STQ_ND2_S_0P8 U318 ( .A1(n727), .A2(n80), .X(n563) );
  STQ_NR2_G_0P5 U319 ( .A1(n259), .A2(n91), .X(n707) );
  STQ_NR2_G_0P5 U320 ( .A1(n267), .A2(n144), .X(n557) );
  STQ_NR2_G_0P5 U321 ( .A1(n707), .A2(n557), .X(n140) );
  STQ_INV_S_0P65 U322 ( .A(n140), .X(n773) );
  STQ_AN4B_0P5 U323 ( .B1(n446), .B2(n724), .B3(n563), .A(n773), .X(n84) );
  STQ_NR2_G_0P5 U324 ( .A1(n88), .A2(n337), .X(n772) );
  STQ_NR2_G_0P5 U325 ( .A1(n266), .A2(n81), .X(n260) );
  STQ_NR2_G_0P5 U326 ( .A1(n772), .A2(n260), .X(n718) );
  STQ_NR2_G_0P5 U327 ( .A1(n266), .A2(n280), .X(n770) );
  STQ_NR2_G_0P5 U328 ( .A1(n88), .A2(n429), .X(n450) );
  STQ_NR2_G_0P5 U329 ( .A1(n770), .A2(n450), .X(n586) );
  STQ_ND2_S_0P8 U330 ( .A1(n143), .A2(n80), .X(n759) );
  STQ_ND3_0P5 U331 ( .A1(n718), .A2(n586), .A3(n759), .X(n158) );
  STQ_NR2_G_0P5 U332 ( .A1(n259), .A2(n81), .X(n704) );
  STQ_INV_S_0P65 U333 ( .A(n567), .X(n426) );
  STQ_NR2_G_0P5 U334 ( .A1(n337), .A2(n426), .X(n344) );
  STQ_NR2_G_0P5 U335 ( .A1(n704), .A2(n344), .X(n587) );
  STQ_NR2_G_0P5 U336 ( .A1(n602), .A2(n337), .X(n715) );
  STQ_ND2_S_0P8 U337 ( .A1(n340), .A2(n594), .X(n691) );
  STQ_INV_S_0P65 U338 ( .A(n691), .X(n422) );
  STQ_NR2_G_0P5 U339 ( .A1(n715), .A2(n422), .X(n710) );
  STQ_NR2_G_0P5 U340 ( .A1(n90), .A2(n88), .X(n584) );
  STQ_INV_S_0P65 U341 ( .A(n584), .X(n559) );
  STQ_ND2_S_0P8 U342 ( .A1(n369), .A2(n567), .X(n351) );
  STQ_NR2_G_0P5 U343 ( .A1(n259), .A2(n90), .X(n364) );
  STQ_NR2_G_0P5 U344 ( .A1(n91), .A2(n88), .X(n459) );
  STQ_NR2_G_0P5 U345 ( .A1(n445), .A2(n603), .X(n769) );
  STQ_NR2_G_0P5 U346 ( .A1(n459), .A2(n769), .X(n281) );
  STQ_ND2_S_0P8 U347 ( .A1(n86), .A2(n275), .X(n779) );
  STQ_ND2_S_0P8 U348 ( .A1(n281), .A2(n779), .X(n347) );
  STQ_NR2_G_0P5 U349 ( .A1(n364), .A2(n347), .X(n709) );
  STQ_AOAI211_0P75 U350 ( .A1(n337), .A2(n82), .B(n259), .C(n709), .X(n752) );
  STQ_NR3_G_0P65 U351 ( .A1(n158), .A2(n451), .A3(n752), .X(n83) );
  STQ_ND2_S_0P8 U352 ( .A1(n87), .A2(n369), .X(n568) );
  STQ_NR2_G_0P5 U353 ( .A1(n91), .A2(n426), .X(n148) );
  STQ_INV_S_0P65 U354 ( .A(n148), .X(n556) );
  STQ_ND4_MM_1 U355 ( .A1(n84), .A2(n83), .A3(n568), .A4(n556), .X(n419) );
  STQ_NR2B_1 U356 ( .A(n447), .B(n419), .X(n147) );
  STQ_NR2_G_0P5 U357 ( .A1(n429), .A2(n338), .X(n342) );
  STQ_AOI31_0P5 U358 ( .A1(Syndrome_in[14]), .A2(n154), .A3(n89), .B(n342), 
        .X(n85) );
  STQ_INV_S_0P65 U359 ( .A(n445), .X(n155) );
  STQ_ND2_S_0P8 U360 ( .A1(n348), .A2(n155), .X(n616) );
  STQ_ND2_S_0P8 U361 ( .A1(n85), .A2(n616), .X(n696) );
  STQ_ND2_S_0P8 U362 ( .A1(n87), .A2(n86), .X(n455) );
  STQ_NR2_G_0P5 U363 ( .A1(n88), .A2(n280), .X(n441) );
  STQ_ND2_S_0P8 U364 ( .A1(n143), .A2(n567), .X(n151) );
  STQ_OAI21_0P5 U365 ( .A1(n89), .A2(n267), .B(n151), .X(n711) );
  STQ_NR2_G_0P5 U366 ( .A1(n90), .A2(n602), .X(n442) );
  STQ_NR2_G_0P5 U367 ( .A1(n266), .A2(n91), .X(n434) );
  STQ_NR2_G_0P5 U368 ( .A1(n442), .A2(n434), .X(n146) );
  STQ_ND2_S_0P8 U369 ( .A1(n594), .A2(n567), .X(n725) );
  STQ_ND2_S_0P8 U370 ( .A1(n146), .A2(n725), .X(n748) );
  STQ_NR4B_1 U371 ( .A(n455), .B1(n441), .B2(n711), .B3(n748), .X(n92) );
  STQ_ND2_S_0P8 U372 ( .A1(n452), .A2(n275), .X(n564) );
  STQ_NR2_G_0P5 U373 ( .A1(n445), .A2(n429), .X(n601) );
  STQ_INV_S_0P65 U374 ( .A(n601), .X(n282) );
  STQ_ND4B_1 U375 ( .A(n696), .B1(n92), .B2(n564), .B3(n282), .X(n721) );
  STQ_INV_S_0P65 U376 ( .A(n721), .X(n93) );
  STQ_ND4_MM_1 U377 ( .A1(n579), .A2(n94), .A3(n147), .A4(n93), .X(n820) );
  STQ_MUX2_1 U378 ( .D0(Syndrome1[6]), .D1(Syndrome0[6]), .S(n99), .X(\C1/Z_6 ) );
  STQ_MUX2_1 U379 ( .D0(n96), .D1(n95), .S(n99), .X(n804) );
  STQ_MUX2_1 U380 ( .D0(Syndrome1[5]), .D1(Syndrome0[5]), .S(n99), .X(\C1/Z_5 ) );
  STQ_MUXI2_MG_0P75 U381 ( .D0(Syndrome0[5]), .D1(Syndrome1[5]), .S(n99), .X(
        n805) );
  STQ_OR2_1 U382 ( .A1(n98), .A2(n97), .X(\DP_OP_24J1_122_5749/n8 ) );
  STQ_MUX2_1 U383 ( .D0(Syndrome1[1]), .D1(Syndrome0[1]), .S(n99), .X(\C1/Z_1 ) );
  STQ_MUXI2_MG_0P75 U384 ( .D0(Syndrome0[1]), .D1(Syndrome1[1]), .S(n99), .X(
        n809) );
  STQ_MUX2_1 U385 ( .D0(Syndrome1[2]), .D1(Syndrome0[2]), .S(n99), .X(\C1/Z_2 ) );
  STQ_MUXI2_MG_0P75 U386 ( .D0(Syndrome0[2]), .D1(Syndrome1[2]), .S(n99), .X(
        n808) );
  STQ_MUX2_1 U387 ( .D0(Syndrome1[3]), .D1(Syndrome0[3]), .S(n99), .X(\C1/Z_3 ) );
  STQ_MUXI2_MG_0P75 U388 ( .D0(Syndrome0[3]), .D1(Syndrome1[3]), .S(n99), .X(
        n807) );
  STQ_MUX2_1 U389 ( .D0(Syndrome1[4]), .D1(Syndrome0[4]), .S(n99), .X(\C1/Z_4 ) );
  STQ_MUXI2_MG_0P75 U390 ( .D0(Syndrome0[4]), .D1(Syndrome1[4]), .S(n99), .X(
        n806) );
  STQ_ND2_S_0P8 U391 ( .A1(n222), .A2(n635), .X(n321) );
  STQ_ND2_S_0P8 U392 ( .A1(n220), .A2(n667), .X(n221) );
  STQ_OAI21_0P5 U393 ( .A1(n119), .A2(n128), .B(n221), .X(n234) );
  STQ_INV_S_0P65 U394 ( .A(n302), .X(n173) );
  STQ_INV_S_0P65 U395 ( .A(n384), .X(n487) );
  STQ_INV_S_0P65 U396 ( .A(n201), .X(n663) );
  STQ_ND4_MM_1 U397 ( .A1(n173), .A2(n487), .A3(n663), .A4(n649), .X(n103) );
  STQ_NR3_G_0P65 U398 ( .A1(n110), .A2(n187), .A3(n193), .X(n100) );
  STQ_ND2_S_0P8 U399 ( .A1(n664), .A2(n319), .X(n534) );
  STQ_NR3_G_0P65 U400 ( .A1(n654), .A2(n100), .A3(n534), .X(n238) );
  STQ_OAI211_0P5 U401 ( .A1(n316), .A2(n214), .B1(n471), .B2(n633), .X(n388)
         );
  STQ_NR3_G_0P65 U402 ( .A1(n314), .A2(n385), .A3(n388), .X(n101) );
  STQ_ND4_MM_1 U403 ( .A1(n238), .A2(n101), .A3(n208), .A4(n323), .X(n102) );
  STQ_NR4_0P5 U404 ( .A1(n321), .A2(n234), .A3(n103), .A4(n102), .X(n139) );
  STQ_ND2_S_0P8 U405 ( .A1(n113), .A2(n241), .X(n324) );
  STQ_ND2_S_0P8 U406 ( .A1(n324), .A2(n394), .X(n493) );
  STQ_INV_S_0P65 U407 ( .A(n401), .X(n104) );
  STQ_NR2_G_0P5 U408 ( .A1(n104), .A2(n204), .X(n308) );
  STQ_NR2_G_0P5 U409 ( .A1(n118), .A2(n129), .X(n313) );
  STQ_OR3B_1 U410 ( .B1(n313), .B2(n521), .A(n405), .X(n515) );
  STQ_NR3_G_0P65 U411 ( .A1(n386), .A2(n182), .A3(n515), .X(n106) );
  STQ_ND2_S_0P8 U412 ( .A1(n105), .A2(n113), .X(n305) );
  STQ_ND2_S_0P8 U413 ( .A1(n112), .A2(n124), .X(n226) );
  STQ_INV_S_0P65 U414 ( .A(n306), .X(n537) );
  STQ_ND4B_1 U415 ( .A(n653), .B1(n537), .B2(n468), .B3(n476), .X(n243) );
  STQ_NR4_0P5 U416 ( .A1(n235), .A2(n493), .A3(n684), .A4(n243), .X(n138) );
  STQ_INV_S_0P65 U417 ( .A(Syndrome_in[7]), .X(n108) );
  STQ_ND2_S_0P8 U418 ( .A1(n107), .A2(n108), .X(n546) );
  STQ_ND2_S_0P8 U419 ( .A1(Syndrome_in[7]), .A2(n107), .X(n686) );
  STQ_INV_S_0P65 U420 ( .A(n686), .X(n551) );
  STQ_ND2_S_0P8 U421 ( .A1(n511), .A2(n241), .X(n191) );
  STQ_INV_S_0P65 U422 ( .A(n191), .X(n490) );
  STQ_OAI31_G_0P5 U423 ( .A1(n110), .A2(n51), .A3(n193), .B(n109), .X(n111) );
  STQ_NR3_G_0P65 U424 ( .A1(n490), .A2(n474), .A3(n111), .X(n177) );
  STQ_ND2_S_0P8 U425 ( .A1(n113), .A2(n112), .X(n399) );
  STQ_INV_S_0P65 U426 ( .A(n399), .X(n230) );
  STQ_AOAI211_0P75 U427 ( .A1(n114), .A2(n213), .B(n301), .C(n405), .X(n115)
         );
  STQ_NR3_G_0P65 U428 ( .A1(n230), .A2(n306), .A3(n115), .X(n228) );
  STQ_ND4_MM_1 U429 ( .A1(n658), .A2(n116), .A3(n326), .A4(n477), .X(n117) );
  STQ_NR3_G_0P65 U430 ( .A1(n654), .A2(n322), .A3(n117), .X(n121) );
  STQ_NR2_G_0P5 U431 ( .A1(n317), .A2(n213), .X(n180) );
  STQ_NR2_G_0P5 U432 ( .A1(n118), .A2(n193), .X(n179) );
  STQ_AOI21_0P75 U433 ( .A1(n128), .A2(n193), .B(n119), .X(n206) );
  STQ_NR4_0P5 U434 ( .A1(n180), .A2(n179), .A3(n652), .A4(n206), .X(n688) );
  STQ_NR4B_1 U435 ( .A(n688), .B1(n302), .B2(n398), .B3(n314), .X(n120) );
  STQ_NR2_G_0P5 U436 ( .A1(n522), .A2(n129), .X(n236) );
  STQ_INV_S_0P65 U437 ( .A(n121), .X(n491) );
  STQ_INV_S_0P65 U438 ( .A(n386), .X(n295) );
  STQ_INV_S_0P65 U439 ( .A(n203), .X(n486) );
  STQ_ND4B_1 U440 ( .A(n644), .B1(n295), .B2(n486), .B3(n208), .X(n122) );
  STQ_NR3_G_0P65 U441 ( .A1(n236), .A2(n491), .A3(n122), .X(n133) );
  STQ_ND2_S_0P8 U442 ( .A1(n468), .A2(n476), .X(n123) );
  STQ_AOI211_0P75 U443 ( .A1(n481), .A2(n124), .B1(n385), .B2(n123), .X(n125)
         );
  STQ_AOI31_0P5 U444 ( .A1(n133), .A2(n495), .A3(n125), .B(n678), .X(n135) );
  STQ_INV_S_0P65 U445 ( .A(n179), .X(n650) );
  STQ_ND3_0P5 U446 ( .A1(n650), .A2(n476), .A3(n475), .X(n126) );
  STQ_AOI211_0P75 U447 ( .A1(n127), .A2(n513), .B1(n235), .B2(n126), .X(n672)
         );
  STQ_NR2_G_0P5 U448 ( .A1(n128), .A2(n192), .X(n325) );
  STQ_NR2_G_0P5 U449 ( .A1(n129), .A2(n214), .X(n131) );
  STQ_ND3_0P5 U450 ( .A1(n402), .A2(n200), .A3(n649), .X(n639) );
  STQ_ND2_S_0P8 U451 ( .A1(n240), .A2(n667), .X(n467) );
  STQ_ND4_MM_1 U452 ( .A1(n304), .A2(n633), .A3(n664), .A4(n467), .X(n130) );
  STQ_NR4_0P5 U453 ( .A1(n325), .A2(n131), .A3(n639), .A4(n130), .X(n132) );
  STQ_NR2_G_0P5 U454 ( .A1(n107), .A2(n108), .X(n673) );
  STQ_INV_S_0P65 U455 ( .A(n673), .X(n553) );
  STQ_AOI31_0P5 U456 ( .A1(n133), .A2(n672), .A3(n132), .B(n553), .X(n134) );
  STQ_AOI211_0P75 U457 ( .A1(n551), .A2(n136), .B1(n135), .B2(n134), .X(n137)
         );
  STQ_AOAI211_0P75 U458 ( .A1(n139), .A2(n138), .B(n546), .C(n137), .X(
        \gfexp_00/n359 ) );
  STQ_NR2_G_0P5 U459 ( .A1(n259), .A2(n429), .X(n277) );
  STQ_ND2_S_0P8 U460 ( .A1(n593), .A2(n369), .X(n427) );
  STQ_INV_S_0P65 U461 ( .A(n427), .X(n574) );
  STQ_OAI31_G_0P5 U462 ( .A1(Syndrome_in[12]), .A2(Syndrome_in[10]), .A3(n429), 
        .B(n140), .X(n141) );
  STQ_NR3_G_0P65 U463 ( .A1(n574), .A2(n749), .A3(n141), .X(n270) );
  STQ_ND4_MM_1 U464 ( .A1(n270), .A2(n568), .A3(n725), .A4(n746), .X(n142) );
  STQ_NR3_G_0P65 U465 ( .A1(n772), .A2(n277), .A3(n142), .X(n374) );
  STQ_NR2_G_0P5 U466 ( .A1(n445), .A2(n337), .X(n268) );
  STQ_NR2_G_0P5 U467 ( .A1(n715), .A2(n268), .X(n610) );
  STQ_ND2_S_0P8 U468 ( .A1(n374), .A2(n610), .X(n764) );
  STQ_ND2_S_0P8 U469 ( .A1(n155), .A2(n369), .X(n705) );
  STQ_ND2_S_0P8 U470 ( .A1(n705), .A2(n151), .X(n577) );
  STQ_NR2_G_0P5 U471 ( .A1(n602), .A2(n280), .X(n273) );
  STQ_NR2_G_0P5 U472 ( .A1(n359), .A2(n273), .X(n341) );
  STQ_ND2_S_0P8 U473 ( .A1(n341), .A2(n616), .X(n440) );
  STQ_ND2_S_0P8 U474 ( .A1(n143), .A2(n155), .X(n765) );
  STQ_OAI21_0P5 U475 ( .A1(n144), .A2(n444), .B(n765), .X(n757) );
  STQ_NR4_0P5 U476 ( .A1(n764), .A2(n577), .A3(n440), .A4(n757), .X(n169) );
  STQ_ND2B_MM_1 U477 ( .A(n442), .B(n614), .X(n360) );
  STQ_NR4_0P5 U478 ( .A1(n441), .A2(n459), .A3(n364), .A4(n360), .X(n145) );
  STQ_ND2_S_0P8 U479 ( .A1(n145), .A2(n730), .X(n583) );
  STQ_OAI211_0P5 U480 ( .A1(n444), .A2(n338), .B1(n706), .B2(n691), .X(n433)
         );
  STQ_NR4_0P5 U481 ( .A1(n148), .A2(n584), .A3(n583), .A4(n433), .X(n168) );
  STQ_ND2_S_0P8 U482 ( .A1(Syndrome_in[15]), .A2(Syndrome_in[13]), .X(n799) );
  STQ_ND2_S_0P8 U483 ( .A1(n154), .A2(n275), .X(n352) );
  STQ_ND3_0P5 U484 ( .A1(n692), .A2(n729), .A3(n352), .X(n357) );
  STQ_NR2_G_0P5 U485 ( .A1(n358), .A2(n749), .X(n703) );
  STQ_AN2_S_0P5 U486 ( .A1(n765), .A2(n282), .X(n438) );
  STQ_ND4_MM_1 U487 ( .A1(n703), .A2(n147), .A3(n146), .A4(n438), .X(n166) );
  STQ_NR2_G_0P5 U488 ( .A1(Syndrome_in[13]), .A2(n54), .X(n785) );
  STQ_NR2_G_0P5 U489 ( .A1(n267), .A2(n428), .X(n454) );
  STQ_NR4_0P5 U490 ( .A1(n343), .A2(n148), .A3(n704), .A4(n454), .X(n149) );
  STQ_ND4B_1 U491 ( .A(n357), .B1(n149), .B2(n616), .B3(n455), .X(n599) );
  STQ_INV_S_0P65 U492 ( .A(n770), .X(n723) );
  STQ_ND2_S_0P8 U493 ( .A1(n724), .A2(n447), .X(n612) );
  STQ_ND2_S_0P8 U494 ( .A1(n431), .A2(n788), .X(n449) );
  STQ_NR4_0P5 U495 ( .A1(n584), .A2(n342), .A3(n612), .A4(n449), .X(n150) );
  STQ_ND3B_0P5 U496 ( .A(n260), .B1(n723), .B2(n150), .X(n763) );
  STQ_AN2_S_0P5 U497 ( .A1(n730), .A2(n151), .X(n613) );
  STQ_INV_S_0P65 U498 ( .A(n364), .X(n571) );
  STQ_INV_S_0P65 U499 ( .A(n273), .X(n365) );
  STQ_ND3_0P5 U500 ( .A1(n613), .A2(n571), .A3(n365), .X(n598) );
  STQ_ND2_S_0P8 U501 ( .A1(n152), .A2(n564), .X(n153) );
  STQ_NR3_G_0P65 U502 ( .A1(n700), .A2(n598), .A3(n153), .X(n156) );
  STQ_ND2_S_0P8 U503 ( .A1(n155), .A2(n154), .X(n423) );
  STQ_ND3_0P5 U504 ( .A1(n156), .A2(n568), .A3(n423), .X(n162) );
  STQ_ND2_S_0P8 U505 ( .A1(n775), .A2(n594), .X(n722) );
  STQ_ND4_MM_1 U506 ( .A1(n281), .A2(n746), .A3(n691), .A4(n722), .X(n157) );
  STQ_NR4_0P5 U507 ( .A1(n599), .A2(n763), .A3(n162), .A4(n157), .X(n164) );
  STQ_ND2_S_0P8 U508 ( .A1(Syndrome_in[13]), .A2(n54), .X(n622) );
  STQ_ND3_0P5 U509 ( .A1(n725), .A2(n563), .A3(n430), .X(n576) );
  STQ_NR3B_MG_0P75 U510 ( .A(n587), .B1(n778), .B2(n158), .X(n159) );
  STQ_INV_S_0P65 U511 ( .A(n342), .X(n570) );
  STQ_ND3_0P5 U512 ( .A1(n159), .A2(n692), .A3(n570), .X(n756) );
  STQ_NR2_G_0P5 U513 ( .A1(n160), .A2(n253), .X(n453) );
  STQ_INV_S_0P65 U514 ( .A(n352), .X(n771) );
  STQ_AO211_1 U515 ( .A1(n453), .A2(n727), .B1(n358), .B2(n771), .X(n161) );
  STQ_NR4_0P5 U516 ( .A1(n162), .A2(n576), .A3(n756), .A4(n161), .X(n163) );
  STQ_OAI22_0P5 U517 ( .A1(n164), .A2(n622), .B1(n163), .B2(n737), .X(n165) );
  STQ_OAOI211_0P5 U518 ( .A1(n357), .A2(n166), .B(n785), .C(n165), .X(n167) );
  STQ_AOAI211_0P75 U519 ( .A1(n169), .A2(n168), .B(n799), .C(n167), .X(n816)
         );
  STQ_OAI21_0P5 U520 ( .A1(n170), .A2(n316), .B(n305), .X(n380) );
  STQ_NR3B_MG_0P75 U521 ( .A(n504), .B1(n653), .B2(n171), .X(n172) );
  STQ_ND3_0P5 U522 ( .A1(n172), .A2(n634), .A3(n486), .X(n533) );
  STQ_ND2_S_0P8 U523 ( .A1(n173), .A2(n635), .X(n659) );
  STQ_OR4B_1 U524 ( .B1(n474), .B2(n174), .B3(n659), .A(n401), .X(n176) );
  STQ_ND3_0P5 U525 ( .A1(n471), .A2(n324), .A3(n477), .X(n642) );
  STQ_INV_S_0P65 U526 ( .A(n323), .X(n525) );
  STQ_NR2_G_0P5 U527 ( .A1(n183), .A2(n525), .X(n233) );
  STQ_OR4B_1 U528 ( .B1(n230), .B2(n545), .B3(n642), .A(n233), .X(n175) );
  STQ_NR4_0P5 U529 ( .A1(n380), .A2(n533), .A3(n176), .A4(n175), .X(n212) );
  STQ_INV_S_0P65 U530 ( .A(n546), .X(n682) );
  STQ_ND4_MM_1 U531 ( .A1(n177), .A2(n482), .A3(n665), .A4(n401), .X(n178) );
  STQ_NR3_G_0P65 U532 ( .A1(n520), .A2(n179), .A3(n178), .X(n247) );
  STQ_NR2_G_0P5 U533 ( .A1(n654), .A2(n180), .X(n531) );
  STQ_ND2_S_0P8 U534 ( .A1(n247), .A2(n531), .X(n382) );
  STQ_NR4_0P5 U535 ( .A1(n501), .A2(n203), .A3(n534), .A4(n321), .X(n181) );
  STQ_ND3B_0P5 U536 ( .A(n182), .B1(n663), .B2(n181), .X(n404) );
  STQ_NR2_G_0P5 U537 ( .A1(n183), .A2(n236), .X(n312) );
  STQ_ND3_0P5 U538 ( .A1(n312), .A2(n200), .A3(n208), .X(n544) );
  STQ_NR2_G_0P5 U539 ( .A1(n519), .A2(n526), .X(n637) );
  STQ_ND3_0P5 U540 ( .A1(n637), .A2(n649), .A3(n477), .X(n184) );
  STQ_NR4_0P5 U541 ( .A1(n382), .A2(n404), .A3(n544), .A4(n184), .X(n185) );
  STQ_ND4_MM_1 U542 ( .A1(n186), .A2(n185), .A3(n295), .A4(n305), .X(n199) );
  STQ_NR2_G_0P5 U543 ( .A1(n188), .A2(n187), .X(n408) );
  STQ_ND2_S_0P8 U544 ( .A1(n220), .A2(n512), .X(n662) );
  STQ_INV_S_0P65 U545 ( .A(n662), .X(n518) );
  STQ_AOI211_0P75 U546 ( .A1(n408), .A2(n190), .B1(n518), .B2(n189), .X(n484)
         );
  STQ_INV_S_0P65 U547 ( .A(n226), .X(n406) );
  STQ_NR4_0P5 U548 ( .A1(n520), .A2(n406), .A3(n201), .A4(n239), .X(n197) );
  STQ_AOI21_0P75 U549 ( .A1(n220), .A2(n481), .B(n506), .X(n196) );
  STQ_OAI211_0P5 U550 ( .A1(n193), .A2(n192), .B1(n191), .B2(n664), .X(n194)
         );
  STQ_ND4B_1 U551 ( .A(n194), .B1(n482), .B2(n222), .B3(n405), .X(n311) );
  STQ_ND2_S_0P8 U552 ( .A1(n318), .A2(n221), .X(n217) );
  STQ_NR4B_1 U553 ( .A(n656), .B1(n653), .B2(n311), .B3(n217), .X(n195) );
  STQ_ND4_MM_1 U554 ( .A1(n484), .A2(n197), .A3(n196), .A4(n195), .X(n198) );
  STQ_AOI22_0P75 U555 ( .A1(n682), .A2(n199), .B1(n673), .B2(n198), .X(n211)
         );
  STQ_NR2_G_0P5 U556 ( .A1(n407), .A2(n474), .X(n393) );
  STQ_ND3B_0P5 U557 ( .A(n235), .B1(n200), .B2(n669), .X(n470) );
  STQ_NR4_0P5 U558 ( .A1(n201), .A2(n398), .A3(n485), .A4(n470), .X(n202) );
  STQ_ND4B_1 U559 ( .A(n526), .B1(n393), .B2(n202), .B3(n323), .X(n643) );
  STQ_NR3_G_0P65 U560 ( .A1(n302), .A2(n386), .A3(n203), .X(n336) );
  STQ_ND3B_0P5 U561 ( .A(n204), .B1(n633), .B2(n336), .X(n205) );
  STQ_NR4_0P5 U562 ( .A1(n207), .A2(n206), .A3(n510), .A4(n205), .X(n529) );
  STQ_ND3_0P5 U563 ( .A1(n529), .A2(n665), .A3(n326), .X(n218) );
  STQ_ND3B_0P5 U564 ( .A(n322), .B1(n399), .B2(n208), .X(n224) );
  STQ_OR4B_1 U565 ( .B1(n313), .B2(n218), .B3(n224), .A(n635), .X(n209) );
  STQ_OAI31_G_0P5 U566 ( .A1(n243), .A2(n643), .A3(n209), .B(n498), .X(n210)
         );
  STQ_OAI211_0P5 U567 ( .A1(n686), .A2(n212), .B1(n211), .B2(n210), .X(
        \gfexp_00/n357 ) );
  STQ_AOAI211_0P75 U568 ( .A1(n215), .A2(n214), .B(n213), .C(n662), .X(n514)
         );
  STQ_AOI211_0P75 U569 ( .A1(n513), .A2(n216), .B1(n632), .B2(n514), .X(n252)
         );
  STQ_NR4_0P5 U570 ( .A1(n380), .A2(n544), .A3(n218), .A4(n217), .X(n251) );
  STQ_OAI21_0P5 U571 ( .A1(n220), .A2(n480), .B(n219), .X(n223) );
  STQ_ND3_0P5 U572 ( .A1(n223), .A2(n222), .A3(n221), .X(n524) );
  STQ_ND2_S_0P8 U573 ( .A1(n663), .A2(n476), .X(n473) );
  STQ_NR4_0P5 U574 ( .A1(n639), .A2(n524), .A3(n224), .A4(n473), .X(n225) );
  STQ_ND4_MM_1 U575 ( .A1(n225), .A2(n538), .A3(n226), .A4(n537), .X(n249) );
  STQ_ND3_0P5 U576 ( .A1(n634), .A2(n669), .A3(n226), .X(n415) );
  STQ_NR4_0P5 U577 ( .A1(n653), .A2(n652), .A3(n234), .A4(n510), .X(n227) );
  STQ_ND4_MM_1 U578 ( .A1(n228), .A2(n227), .A3(n662), .A4(n475), .X(n229) );
  STQ_NR4_0P5 U579 ( .A1(n407), .A2(n385), .A3(n415), .A4(n229), .X(n246) );
  STQ_NR2_G_0P5 U580 ( .A1(n56), .A2(n4), .X(n231) );
  STQ_ND2B_MM_1 U581 ( .A(n314), .B(n536), .X(n383) );
  STQ_AOI211_0P75 U582 ( .A1(n480), .A2(n231), .B1(n230), .B2(n383), .X(n232)
         );
  STQ_ND4_MM_1 U583 ( .A1(n233), .A2(n232), .A3(n482), .A4(n665), .X(n641) );
  STQ_NR4_0P5 U584 ( .A1(n384), .A2(n235), .A3(n515), .A4(n234), .X(n237) );
  STQ_INV_S_0P65 U585 ( .A(n236), .X(n395) );
  STQ_ND4_MM_1 U586 ( .A1(n238), .A2(n237), .A3(n395), .A4(n305), .X(n297) );
  STQ_AOI211_0P75 U587 ( .A1(n241), .A2(n240), .B1(n644), .B2(n239), .X(n242)
         );
  STQ_OR4B_1 U588 ( .B1(n514), .B2(n243), .B3(n485), .A(n242), .X(n244) );
  STQ_OAI31_G_0P5 U589 ( .A1(n641), .A2(n297), .A3(n244), .B(n551), .X(n245)
         );
  STQ_AOAI211_0P75 U590 ( .A1(n247), .A2(n246), .B(n678), .C(n245), .X(n248)
         );
  STQ_OAOI211_0P5 U591 ( .A1(n382), .A2(n249), .B(n682), .C(n248), .X(n250) );
  STQ_AOAI211_0P75 U592 ( .A1(n252), .A2(n251), .B(n553), .C(n250), .X(
        \gfexp_00/n360 ) );
  STQ_ND2_S_0P8 U593 ( .A1(n775), .A2(n727), .X(n349) );
  STQ_OAI21_0P5 U594 ( .A1(n266), .A2(n267), .B(n349), .X(n363) );
  STQ_INV_S_0P65 U595 ( .A(n343), .X(n719) );
  STQ_ND4_MM_1 U596 ( .A1(n719), .A2(n571), .A3(n723), .A4(n759), .X(n257) );
  STQ_NR3_G_0P65 U597 ( .A1(Syndrome_in[12]), .A2(n253), .A3(n429), .X(n254)
         );
  STQ_NR3_G_0P65 U598 ( .A1(n715), .A2(n254), .A3(n612), .X(n367) );
  STQ_NR3_G_0P65 U599 ( .A1(n442), .A2(n459), .A3(n433), .X(n255) );
  STQ_ND4_MM_1 U600 ( .A1(n367), .A2(n255), .A3(n351), .A4(n701), .X(n256) );
  STQ_NR4_0P5 U601 ( .A1(n449), .A2(n363), .A3(n257), .A4(n256), .X(n292) );
  STQ_INV_S_0P65 U602 ( .A(n746), .X(n258) );
  STQ_NR2_G_0P5 U603 ( .A1(n258), .A2(n344), .X(n436) );
  STQ_NR2_G_0P5 U604 ( .A1(n259), .A2(n280), .X(n791) );
  STQ_OR3B_1 U605 ( .B1(n791), .B2(n601), .A(n430), .X(n597) );
  STQ_NR3_G_0P65 U606 ( .A1(n441), .A2(n260), .A3(n597), .X(n261) );
  STQ_ND4_MM_1 U607 ( .A1(n436), .A2(n261), .A3(n765), .A4(n352), .X(n742) );
  STQ_INV_S_0P65 U608 ( .A(n434), .X(n615) );
  STQ_ND4B_1 U609 ( .A(n778), .B1(n615), .B2(n559), .B3(n564), .X(n795) );
  STQ_NR4_0P5 U610 ( .A1(n557), .A2(n577), .A3(n742), .A4(n795), .X(n291) );
  STQ_INV_S_0P65 U611 ( .A(n799), .X(n627) );
  STQ_INV_S_0P65 U612 ( .A(n423), .X(n753) );
  STQ_AOAI211_0P75 U613 ( .A1(n262), .A2(n337), .B(n426), .C(n430), .X(n263)
         );
  STQ_NR3_G_0P65 U614 ( .A1(n753), .A2(n434), .A3(n263), .X(n355) );
  STQ_ND4_MM_1 U615 ( .A1(n718), .A2(n264), .A3(n455), .A4(n758), .X(n265) );
  STQ_NR3_G_0P65 U616 ( .A1(n715), .A2(n450), .A3(n265), .X(n271) );
  STQ_AOI21_0P75 U617 ( .A1(n267), .A2(n429), .B(n266), .X(n346) );
  STQ_NR4_0P5 U618 ( .A1(n268), .A2(n277), .A3(n714), .A4(n346), .X(n745) );
  STQ_NR4B_1 U619 ( .A(n745), .B1(n343), .B2(n700), .B3(n442), .X(n269) );
  STQ_ND4_MM_1 U620 ( .A1(n270), .A2(n355), .A3(n271), .A4(n269), .X(n289) );
  STQ_INV_S_0P65 U621 ( .A(n271), .X(n575) );
  STQ_INV_S_0P65 U622 ( .A(n441), .X(n766) );
  STQ_ND4B_1 U623 ( .A(n707), .B1(n766), .B2(n570), .B3(n351), .X(n272) );
  STQ_NR3_G_0P65 U624 ( .A1(n273), .A2(n575), .A3(n272), .X(n286) );
  STQ_ND2_S_0P8 U625 ( .A1(n559), .A2(n564), .X(n274) );
  STQ_AOI211_0P75 U626 ( .A1(n774), .A2(n275), .B1(n459), .B2(n274), .X(n276)
         );
  STQ_AOI31_0P5 U627 ( .A1(n286), .A2(n579), .A3(n276), .B(n737), .X(n288) );
  STQ_INV_S_0P65 U628 ( .A(n277), .X(n712) );
  STQ_ND3_0P5 U629 ( .A1(n712), .A2(n564), .A3(n563), .X(n278) );
  STQ_AOI211_0P75 U630 ( .A1(n279), .A2(n595), .B1(n557), .B2(n278), .X(n732)
         );
  STQ_NR2_G_0P5 U631 ( .A1(n280), .A2(n338), .X(n284) );
  STQ_ND3_0P5 U632 ( .A1(n281), .A2(n556), .A3(n759), .X(n695) );
  STQ_ND2_S_0P8 U633 ( .A1(n368), .A2(n727), .X(n558) );
  STQ_ND4_MM_1 U634 ( .A1(n282), .A2(n691), .A3(n724), .A4(n558), .X(n283) );
  STQ_NR4_0P5 U635 ( .A1(n454), .A2(n284), .A3(n695), .A4(n283), .X(n285) );
  STQ_INV_S_0P65 U636 ( .A(n785), .X(n629) );
  STQ_AOI31_0P5 U637 ( .A1(n286), .A2(n732), .A3(n285), .B(n629), .X(n287) );
  STQ_AOI211_0P75 U638 ( .A1(n627), .A2(n289), .B1(n288), .B2(n287), .X(n290)
         );
  STQ_AOAI211_0P75 U639 ( .A1(n292), .A2(n291), .B(n622), .C(n290), .X(n817)
         );
  STQ_NR4B_1 U640 ( .A(n477), .B1(n294), .B2(n293), .B3(n648), .X(n335) );
  STQ_ND4_MM_1 U641 ( .A1(n295), .A2(n650), .A3(n538), .A4(n649), .X(n489) );
  STQ_ND2_S_0P8 U642 ( .A1(n296), .A2(n56), .X(n300) );
  STQ_NR4_0P5 U643 ( .A1(n490), .A2(n298), .A3(n321), .A4(n297), .X(n299) );
  STQ_OAI211_0P5 U644 ( .A1(n301), .A2(n300), .B1(n299), .B2(n399), .X(n333)
         );
  STQ_NR4_0P5 U645 ( .A1(n302), .A2(n389), .A3(n526), .A4(n325), .X(n303) );
  STQ_ND4B_1 U646 ( .A(n415), .B1(n303), .B2(n538), .B3(n326), .X(n517) );
  STQ_AN2_S_0P5 U647 ( .A1(n305), .A2(n304), .X(n390) );
  STQ_AOI211_0P75 U648 ( .A1(n307), .A2(n511), .B1(n306), .B2(n388), .X(n309)
         );
  STQ_NR3_G_0P65 U649 ( .A1(n517), .A2(n311), .A3(n310), .X(n331) );
  STQ_ND2_S_0P8 U650 ( .A1(n312), .A2(n538), .X(n381) );
  STQ_NR4_0P5 U651 ( .A1(n314), .A2(n386), .A3(n313), .A4(n381), .X(n315) );
  STQ_OAI21_0P5 U652 ( .A1(n317), .A2(n316), .B(n315), .X(n675) );
  STQ_ND2_S_0P8 U653 ( .A1(n319), .A2(n318), .X(n320) );
  STQ_NR4_0P5 U654 ( .A1(n520), .A2(n322), .A3(n321), .A4(n320), .X(n541) );
  STQ_ND4_MM_1 U655 ( .A1(n541), .A2(n401), .A3(n324), .A4(n323), .X(n329) );
  STQ_NR3_G_0P65 U656 ( .A1(n521), .A2(n644), .A3(n325), .X(n327) );
  STQ_ND4_MM_1 U657 ( .A1(n484), .A2(n327), .A3(n650), .A4(n326), .X(n328) );
  STQ_NR4_0P5 U658 ( .A1(n385), .A2(n675), .A3(n329), .A4(n328), .X(n330) );
  STQ_OAI22_0P5 U659 ( .A1(n331), .A2(n546), .B1(n330), .B2(n686), .X(n332) );
  STQ_OAOI211_0P5 U660 ( .A1(n489), .A2(n333), .B(n673), .C(n332), .X(n334) );
  STQ_AOAI211_0P75 U661 ( .A1(n336), .A2(n335), .B(n678), .C(n334), .X(
        \gfexp_00/n356 ) );
  STQ_AOAI211_0P75 U662 ( .A1(n339), .A2(n338), .B(n337), .C(n722), .X(n596)
         );
  STQ_AOI211_0P75 U663 ( .A1(n595), .A2(n340), .B1(n690), .B2(n596), .X(n379)
         );
  STQ_ND3_0P5 U664 ( .A1(n341), .A2(n556), .A3(n351), .X(n762) );
  STQ_NR3_G_0P65 U665 ( .A1(n343), .A2(n441), .A3(n342), .X(n466) );
  STQ_ND3B_0P5 U666 ( .A(n344), .B1(n691), .B2(n466), .X(n345) );
  STQ_NR4_0P5 U667 ( .A1(n347), .A2(n346), .A3(n592), .A4(n345), .X(n608) );
  STQ_ND3_0P5 U668 ( .A1(n608), .A2(n725), .A3(n455), .X(n790) );
  STQ_ND2_S_0P8 U669 ( .A1(n446), .A2(n349), .X(n776) );
  STQ_NR4_0P5 U670 ( .A1(n757), .A2(n762), .A3(n790), .A4(n776), .X(n378) );
  STQ_OAI21_0P5 U671 ( .A1(n775), .A2(n567), .B(n348), .X(n350) );
  STQ_ND3_0P5 U672 ( .A1(n350), .A2(n431), .A3(n349), .X(n604) );
  STQ_ND3B_0P5 U673 ( .A(n450), .B1(n423), .B2(n351), .X(n789) );
  STQ_ND2_S_0P8 U674 ( .A1(n723), .A2(n564), .X(n562) );
  STQ_NR4_0P5 U675 ( .A1(n695), .A2(n604), .A3(n789), .A4(n562), .X(n353) );
  STQ_ND4_MM_1 U676 ( .A1(n353), .A2(n616), .A3(n352), .A4(n615), .X(n376) );
  STQ_INV_S_0P65 U677 ( .A(n622), .X(n787) );
  STQ_NR4_0P5 U678 ( .A1(n778), .A2(n714), .A3(n363), .A4(n592), .X(n354) );
  STQ_ND4_MM_1 U679 ( .A1(n355), .A2(n354), .A3(n722), .A4(n563), .X(n356) );
  STQ_NR4_0P5 U680 ( .A1(n358), .A2(n459), .A3(n357), .A4(n356), .X(n373) );
  STQ_INV_S_0P65 U681 ( .A(n701), .X(n605) );
  STQ_NR2_G_0P5 U682 ( .A1(n359), .A2(n605), .X(n750) );
  STQ_NR2_G_0P5 U683 ( .A1(Syndrome_in[8]), .A2(Syndrome_in[11]), .X(n361) );
  STQ_AOI211_0P75 U684 ( .A1(n567), .A2(n361), .B1(n753), .B2(n360), .X(n362)
         );
  STQ_ND4_MM_1 U685 ( .A1(n750), .A2(n362), .A3(n568), .A4(n725), .X(n697) );
  STQ_NR4_0P5 U686 ( .A1(n364), .A2(n557), .A3(n597), .A4(n363), .X(n366) );
  STQ_AOI211_0P75 U687 ( .A1(n369), .A2(n368), .B1(n707), .B2(n769), .X(n370)
         );
  STQ_OR4B_1 U688 ( .B1(n596), .B2(n795), .B3(n699), .A(n370), .X(n371) );
  STQ_OAI31_G_0P5 U689 ( .A1(n697), .A2(n421), .A3(n371), .B(n627), .X(n372)
         );
  STQ_AOAI211_0P75 U690 ( .A1(n374), .A2(n373), .B(n737), .C(n372), .X(n375)
         );
  STQ_OAOI211_0P5 U691 ( .A1(n764), .A2(n376), .B(n787), .C(n375), .X(n377) );
  STQ_AOAI211_0P75 U692 ( .A1(n379), .A2(n378), .B(n629), .C(n377), .X(n818)
         );
  STQ_NR4_0P5 U693 ( .A1(n382), .A2(n493), .A3(n381), .A4(n380), .X(n418) );
  STQ_NR4_0P5 U694 ( .A1(n386), .A2(n385), .A3(n384), .A4(n383), .X(n387) );
  STQ_ND2_S_0P8 U695 ( .A1(n387), .A2(n670), .X(n500) );
  STQ_NR4_0P5 U696 ( .A1(n389), .A2(n501), .A3(n500), .A4(n388), .X(n417) );
  STQ_AN2_S_0P5 U697 ( .A1(n670), .A2(n394), .X(n535) );
  STQ_ND3_0P5 U698 ( .A1(n535), .A2(n487), .A3(n395), .X(n516) );
  STQ_ND2_S_0P8 U699 ( .A1(n396), .A2(n476), .X(n397) );
  STQ_NR3_G_0P65 U700 ( .A1(n398), .A2(n516), .A3(n397), .X(n400) );
  STQ_ND3_0P5 U701 ( .A1(n400), .A2(n482), .A3(n399), .X(n410) );
  STQ_ND4_MM_1 U702 ( .A1(n402), .A2(n401), .A3(n633), .A4(n662), .X(n403) );
  STQ_NR4_0P5 U703 ( .A1(n517), .A2(n404), .A3(n410), .A4(n403), .X(n412) );
  STQ_ND3_0P5 U704 ( .A1(n665), .A2(n475), .A3(n405), .X(n492) );
  STQ_AO211_1 U705 ( .A1(n408), .A2(n667), .B1(n407), .B2(n406), .X(n409) );
  STQ_NR4_0P5 U706 ( .A1(n410), .A2(n492), .A3(n533), .A4(n409), .X(n411) );
  STQ_OAI22_0P5 U707 ( .A1(n412), .A2(n546), .B1(n411), .B2(n678), .X(n413) );
  STQ_OAOI211_0P5 U708 ( .A1(n415), .A2(n414), .B(n673), .C(n413), .X(n416) );
  STQ_AOAI211_0P75 U709 ( .A1(n418), .A2(n417), .B(n686), .C(n416), .X(
        \gfexp_00/n358 ) );
  STQ_NR4B_1 U710 ( .A(n758), .B1(n420), .B2(n419), .B3(n711), .X(n465) );
  STQ_ND4_MM_1 U711 ( .A1(n766), .A2(n712), .A3(n616), .A4(n759), .X(n573) );
  STQ_ND2_S_0P8 U712 ( .A1(Syndrome_in[9]), .A2(Syndrome_in[11]), .X(n425) );
  STQ_NR4_0P5 U713 ( .A1(n574), .A2(n422), .A3(n449), .A4(n421), .X(n424) );
  STQ_OAI211_0P5 U714 ( .A1(n426), .A2(n425), .B1(n424), .B2(n423), .X(n463)
         );
  STQ_OAI211_0P5 U715 ( .A1(n429), .A2(n428), .B1(n427), .B2(n724), .X(n432)
         );
  STQ_ND4B_1 U716 ( .A(n432), .B1(n568), .B2(n431), .B3(n430), .X(n777) );
  STQ_AOI211_0P75 U717 ( .A1(n435), .A2(n593), .B1(n434), .B2(n433), .X(n437)
         );
  STQ_ND4_MM_1 U718 ( .A1(n438), .A2(n437), .A3(n745), .A4(n436), .X(n439) );
  STQ_NR3_G_0P65 U719 ( .A1(n599), .A2(n777), .A3(n439), .X(n461) );
  STQ_NR4_0P5 U720 ( .A1(n442), .A2(n441), .A3(n791), .A4(n440), .X(n443) );
  STQ_OAI21_0P5 U721 ( .A1(n445), .A2(n444), .B(n443), .X(n734) );
  STQ_ND2_S_0P8 U722 ( .A1(n447), .A2(n446), .X(n448) );
  STQ_NR4_0P5 U723 ( .A1(n772), .A2(n450), .A3(n449), .A4(n448), .X(n619) );
  STQ_ND4_MM_1 U724 ( .A1(n619), .A2(n746), .A3(n705), .A4(n701), .X(n458) );
  STQ_INV_S_0P65 U725 ( .A(n722), .X(n600) );
  STQ_AOI211_0P75 U726 ( .A1(n453), .A2(n452), .B1(n600), .B2(n451), .X(n783)
         );
  STQ_NR3_G_0P65 U727 ( .A1(n601), .A2(n707), .A3(n454), .X(n456) );
  STQ_ND4_MM_1 U728 ( .A1(n783), .A2(n456), .A3(n712), .A4(n455), .X(n457) );
  STQ_NR4_0P5 U729 ( .A1(n459), .A2(n734), .A3(n458), .A4(n457), .X(n460) );
  STQ_OAI22_0P5 U730 ( .A1(n461), .A2(n622), .B1(n460), .B2(n799), .X(n462) );
  STQ_OAOI211_0P5 U731 ( .A1(n573), .A2(n463), .B(n785), .C(n462), .X(n464) );
  STQ_AOAI211_0P75 U732 ( .A1(n466), .A2(n465), .B(n737), .C(n464), .X(n814)
         );
  STQ_INV_S_0P65 U733 ( .A(n684), .X(n540) );
  STQ_INV_S_0P65 U734 ( .A(n510), .X(n657) );
  STQ_ND3_0P5 U735 ( .A1(n650), .A2(n468), .A3(n467), .X(n469) );
  STQ_NR3_G_0P65 U736 ( .A1(n470), .A2(n641), .A3(n469), .X(n530) );
  STQ_NR4_0P5 U737 ( .A1(n474), .A2(n518), .A3(n473), .A4(n472), .X(n509) );
  STQ_ND2_S_0P8 U738 ( .A1(n476), .A2(n475), .X(n479) );
  STQ_ND2_S_0P8 U739 ( .A1(n649), .A2(n477), .X(n478) );
  STQ_AOI211_0P75 U740 ( .A1(n481), .A2(n480), .B1(n479), .B2(n478), .X(n483)
         );
  STQ_ND4_MM_1 U741 ( .A1(n688), .A2(n484), .A3(n483), .A4(n482), .X(n499) );
  STQ_INV_S_0P65 U742 ( .A(n485), .X(n655) );
  STQ_ND4_MM_1 U743 ( .A1(n487), .A2(n663), .A3(n486), .A4(n655), .X(n488) );
  STQ_NR4_0P5 U744 ( .A1(n490), .A2(n518), .A3(n489), .A4(n488), .X(n496) );
  STQ_NR4_0P5 U745 ( .A1(n493), .A2(n534), .A3(n492), .A4(n491), .X(n494) );
  STQ_AOI31_0P5 U746 ( .A1(n496), .A2(n495), .A3(n494), .B(n686), .X(n497) );
  STQ_OAOI211_0P5 U747 ( .A1(n500), .A2(n499), .B(n498), .C(n497), .X(n508) );
  STQ_NR4_0P5 U748 ( .A1(n501), .A2(n534), .A3(n661), .A4(n514), .X(n502) );
  STQ_ND3_0P5 U749 ( .A1(n504), .A2(n503), .A3(n502), .X(n505) );
  STQ_OAI31_G_0P5 U750 ( .A1(n506), .A2(n639), .A3(n505), .B(n682), .X(n507)
         );
  STQ_OAI211_0P5 U751 ( .A1(n509), .A2(n553), .B1(n508), .B2(n507), .X(
        \gfexp_00/n354 ) );
  STQ_OAOI211_0P5 U752 ( .A1(n513), .A2(n512), .B(n511), .C(n510), .X(n555) );
  STQ_NR4_0P5 U753 ( .A1(n517), .A2(n516), .A3(n515), .A4(n514), .X(n554) );
  STQ_NR4_0P5 U754 ( .A1(n521), .A2(n520), .A3(n519), .A4(n518), .X(n528) );
  STQ_OAOI211_0P5 U755 ( .A1(n4), .A2(n56), .B(n523), .C(n522), .X(n660) );
  STQ_NR4_0P5 U756 ( .A1(n526), .A2(n525), .A3(n660), .A4(n524), .X(n527) );
  STQ_ND4_MM_1 U757 ( .A1(n531), .A2(n530), .A3(n537), .A4(n635), .X(n532) );
  STQ_NR4B_1 U758 ( .A(n535), .B1(n534), .B2(n533), .B3(n532), .X(n548) );
  STQ_ND2_S_0P8 U759 ( .A1(n536), .A2(n670), .X(n543) );
  STQ_AN2_S_0P5 U760 ( .A1(n538), .A2(n537), .X(n539) );
  STQ_ND4_MM_1 U761 ( .A1(n541), .A2(n540), .A3(n657), .A4(n539), .X(n542) );
  STQ_NR4_0P5 U762 ( .A1(n545), .A2(n544), .A3(n543), .A4(n542), .X(n547) );
  STQ_OAI22_0P5 U763 ( .A1(n548), .A2(n678), .B1(n547), .B2(n546), .X(n549) );
  STQ_AOI21_0P75 U764 ( .A1(n551), .A2(n550), .B(n549), .X(n552) );
  STQ_AOAI211_0P75 U765 ( .A1(n555), .A2(n554), .B(n553), .C(n552), .X(
        \gfexp_00/n355 ) );
  STQ_INV_S_0P65 U766 ( .A(n742), .X(n618) );
  STQ_INV_S_0P65 U767 ( .A(n592), .X(n717) );
  STQ_ND3B_0P5 U768 ( .A(n557), .B1(n556), .B2(n729), .X(n698) );
  STQ_ND3_0P5 U769 ( .A1(n712), .A2(n559), .A3(n558), .X(n560) );
  STQ_NR3_G_0P65 U770 ( .A1(n698), .A2(n697), .A3(n560), .X(n609) );
  STQ_ND4_MM_1 U771 ( .A1(n618), .A2(n717), .A3(n609), .A4(n706), .X(n561) );
  STQ_NR4_0P5 U772 ( .A1(n749), .A2(n600), .A3(n562), .A4(n561), .X(n591) );
  STQ_ND2_S_0P8 U773 ( .A1(n564), .A2(n563), .X(n566) );
  STQ_ND2_S_0P8 U774 ( .A1(n759), .A2(n758), .X(n565) );
  STQ_AOI211_0P75 U775 ( .A1(n774), .A2(n567), .B1(n566), .B2(n565), .X(n569)
         );
  STQ_ND4_MM_1 U776 ( .A1(n745), .A2(n783), .A3(n569), .A4(n568), .X(n582) );
  STQ_INV_S_0P65 U777 ( .A(n699), .X(n716) );
  STQ_ND4_MM_1 U778 ( .A1(n571), .A2(n723), .A3(n570), .A4(n716), .X(n572) );
  STQ_NR4_0P5 U779 ( .A1(n574), .A2(n600), .A3(n573), .A4(n572), .X(n580) );
  STQ_NR4_0P5 U780 ( .A1(n577), .A2(n612), .A3(n576), .A4(n575), .X(n578) );
  STQ_AOI31_0P5 U781 ( .A1(n580), .A2(n579), .A3(n578), .B(n799), .X(n581) );
  STQ_OAOI211_0P5 U782 ( .A1(n583), .A2(n582), .B(n792), .C(n581), .X(n590) );
  STQ_NR4_0P5 U783 ( .A1(n584), .A2(n612), .A3(n721), .A4(n596), .X(n585) );
  STQ_ND3_0P5 U784 ( .A1(n587), .A2(n586), .A3(n585), .X(n588) );
  STQ_OAI31_G_0P5 U785 ( .A1(n773), .A2(n695), .A3(n588), .B(n787), .X(n589)
         );
  STQ_OAI211_0P5 U786 ( .A1(n591), .A2(n629), .B1(n590), .B2(n589), .X(n812)
         );
  STQ_OAOI211_0P5 U787 ( .A1(n595), .A2(n594), .B(n593), .C(n592), .X(n631) );
  STQ_NR4_0P5 U788 ( .A1(n599), .A2(n598), .A3(n597), .A4(n596), .X(n630) );
  STQ_NR4_0P5 U789 ( .A1(n601), .A2(n772), .A3(n689), .A4(n600), .X(n607) );
  STQ_OAOI211_0P5 U790 ( .A1(Syndrome_in[8]), .A2(Syndrome_in[11]), .B(n603), 
        .C(n602), .X(n720) );
  STQ_NR4_0P5 U791 ( .A1(n704), .A2(n605), .A3(n720), .A4(n604), .X(n606) );
  STQ_ND4_MM_1 U792 ( .A1(n732), .A2(n608), .A3(n607), .A4(n606), .X(n626) );
  STQ_ND4_MM_1 U793 ( .A1(n610), .A2(n609), .A3(n615), .A4(n788), .X(n611) );
  STQ_NR4B_1 U794 ( .A(n613), .B1(n612), .B2(n756), .B3(n611), .X(n624) );
  STQ_ND2_S_0P8 U795 ( .A1(n614), .A2(n730), .X(n621) );
  STQ_AN2_S_0P5 U796 ( .A1(n616), .A2(n615), .X(n617) );
  STQ_ND4_MM_1 U797 ( .A1(n619), .A2(n618), .A3(n717), .A4(n617), .X(n620) );
  STQ_NR4_0P5 U798 ( .A1(n752), .A2(n762), .A3(n621), .A4(n620), .X(n623) );
  STQ_OAI22_0P5 U799 ( .A1(n624), .A2(n737), .B1(n623), .B2(n622), .X(n625) );
  STQ_AOI21_0P75 U800 ( .A1(n627), .A2(n626), .B(n625), .X(n628) );
  STQ_AOAI211_0P75 U801 ( .A1(n631), .A2(n630), .B(n629), .C(n628), .X(n813)
         );
  STQ_AN4B_0P5 U802 ( .B1(n634), .B2(n633), .B3(n655), .A(n632), .X(n636) );
  STQ_ND4_MM_1 U803 ( .A1(n637), .A2(n636), .A3(n670), .A4(n635), .X(n638) );
  STQ_NR4_0P5 U804 ( .A1(n641), .A2(n640), .A3(n639), .A4(n638), .X(n687) );
  STQ_NR4_0P5 U805 ( .A1(n644), .A2(n652), .A3(n643), .A4(n642), .X(n645) );
  STQ_ND4B_1 U806 ( .A(n648), .B1(n647), .B2(n646), .B3(n645), .X(n683) );
  STQ_ND2_S_0P8 U807 ( .A1(n650), .A2(n649), .X(n651) );
  STQ_NR4_0P5 U808 ( .A1(n654), .A2(n653), .A3(n652), .A4(n651), .X(n680) );
  STQ_ND4_MM_1 U809 ( .A1(n658), .A2(n657), .A3(n656), .A4(n655), .X(n676) );
  STQ_NR4_0P5 U810 ( .A1(n676), .A2(n661), .A3(n660), .A4(n659), .X(n679) );
  STQ_ND4_MM_1 U811 ( .A1(n665), .A2(n664), .A3(n663), .A4(n662), .X(n666) );
  STQ_AOI21_0P75 U812 ( .A1(n668), .A2(n667), .B(n666), .X(n671) );
  STQ_ND4_MM_1 U813 ( .A1(n672), .A2(n671), .A3(n670), .A4(n669), .X(n674) );
  STQ_OAI31_G_0P5 U814 ( .A1(n676), .A2(n675), .A3(n674), .B(n673), .X(n677)
         );
  STQ_AOAI211_0P75 U815 ( .A1(n680), .A2(n679), .B(n678), .C(n677), .X(n681)
         );
  STQ_OAOI211_0P5 U816 ( .A1(n684), .A2(n683), .B(n682), .C(n681), .X(n685) );
  STQ_AOAI211_0P75 U817 ( .A1(n688), .A2(n687), .B(n686), .C(n685), .X(
        \gfexp_00/n361 ) );
  STQ_NR2_G_0P5 U818 ( .A1(n689), .A2(n704), .X(n760) );
  STQ_AN4B_0P5 U819 ( .B1(n692), .B2(n691), .B3(n716), .A(n690), .X(n693) );
  STQ_ND4_MM_1 U820 ( .A1(n760), .A2(n693), .A3(n730), .A4(n788), .X(n694) );
  STQ_NR4_0P5 U821 ( .A1(n697), .A2(n696), .A3(n695), .A4(n694), .X(n744) );
  STQ_NR4_0P5 U822 ( .A1(n770), .A2(n700), .A3(n699), .A4(n698), .X(n702) );
  STQ_ND4B_1 U823 ( .A(n704), .B1(n703), .B2(n702), .B3(n701), .X(n794) );
  STQ_ND3_0P5 U824 ( .A1(n706), .A2(n705), .A3(n758), .X(n751) );
  STQ_NR4_0P5 U825 ( .A1(n707), .A2(n714), .A3(n794), .A4(n751), .X(n708) );
  STQ_ND4B_1 U826 ( .A(n711), .B1(n710), .B2(n709), .B3(n708), .X(n741) );
  STQ_ND2_S_0P8 U827 ( .A1(n712), .A2(n759), .X(n713) );
  STQ_NR4_0P5 U828 ( .A1(n715), .A2(n778), .A3(n714), .A4(n713), .X(n739) );
  STQ_ND4_MM_1 U829 ( .A1(n718), .A2(n717), .A3(n779), .A4(n716), .X(n735) );
  STQ_ND2_S_0P8 U830 ( .A1(n719), .A2(n788), .X(n747) );
  STQ_NR4_0P5 U831 ( .A1(n735), .A2(n721), .A3(n720), .A4(n747), .X(n738) );
  STQ_ND4_MM_1 U832 ( .A1(n725), .A2(n724), .A3(n723), .A4(n722), .X(n726) );
  STQ_AOI21_0P75 U833 ( .A1(n728), .A2(n727), .B(n726), .X(n731) );
  STQ_OAI31_G_0P5 U834 ( .A1(n735), .A2(n734), .A3(n733), .B(n785), .X(n736)
         );
  STQ_AOAI211_0P75 U835 ( .A1(n739), .A2(n738), .B(n737), .C(n736), .X(n740)
         );
  STQ_OAOI211_0P5 U836 ( .A1(n742), .A2(n741), .B(n787), .C(n740), .X(n743) );
  STQ_AOAI211_0P75 U837 ( .A1(n745), .A2(n744), .B(n799), .C(n743), .X(n819)
         );
  STQ_OR4B_1 U838 ( .B1(n749), .B2(n748), .B3(n747), .A(n746), .X(n755) );
  STQ_OR4B_1 U839 ( .B1(n753), .B2(n752), .B3(n751), .A(n750), .X(n754) );
  STQ_NR4_0P5 U840 ( .A1(n757), .A2(n756), .A3(n755), .A4(n754), .X(n798) );
  STQ_ND3_0P5 U841 ( .A1(n760), .A2(n759), .A3(n758), .X(n761) );
  STQ_NR4_0P5 U842 ( .A1(n764), .A2(n763), .A3(n762), .A4(n761), .X(n767) );
  STQ_NR4_0P5 U843 ( .A1(n772), .A2(n771), .A3(n770), .A4(n769), .X(n782) );
  STQ_AOI21_0P75 U844 ( .A1(n775), .A2(n774), .B(n773), .X(n781) );
  STQ_NR4B_1 U845 ( .A(n779), .B1(n778), .B2(n777), .B3(n776), .X(n780) );
  STQ_ND4_MM_1 U846 ( .A1(n783), .A2(n782), .A3(n781), .A4(n780), .X(n784) );
  STQ_AOI22_0P75 U847 ( .A1(n787), .A2(n786), .B1(n785), .B2(n784), .X(n797)
         );
  STQ_OR4B_1 U848 ( .B1(n791), .B2(n790), .B3(n789), .A(n788), .X(n793) );
  STQ_OAI31_G_0P5 U849 ( .A1(n795), .A2(n794), .A3(n793), .B(n792), .X(n796)
         );
  STQ_OAI211_0P5 U850 ( .A1(n799), .A2(n798), .B1(n797), .B2(n796), .X(n815)
         );
endmodule


module AMDCHIPKILL_DECODER ( codeword_in, Error_location_out, 
        Decode_result_out, data_out );
  input [79:0] codeword_in;
  output [3:0] Error_location_out;
  output [1:0] Decode_result_out;
  output [63:0] data_out;
  wire   n158, n159, n160, n161, n162, n163, n164, n165, n166, n167, n168,
         n169, n170, n171, n172, n173, n174, n175, n176, n177, n178, n179,
         n180, n181, n182, n183, n184, n185, n186, n187, n188, n189, n190,
         n191, n192, n193, n194, n195, n196, n197, n198, n199, n200, n201,
         n202, n203, n204, n205, n206, n207, n208, n209, n210, n211, n212,
         n213, n214, n215, n216, n217, n218, n219, n220, n221, n222, n223,
         n224, n225, n226, n227, n228, n229, n230, n231, n232, n233, n234,
         n235, n236, n237, n238, n239, n240, n241, n242, n243, n244, n245,
         n246, n247, n248, n249, n250, n251, n252, n253, n254, n255, n256,
         n257, n258, n259, n260, n261, n262, n263, n264, n265, n266, n267,
         n268, n269, n270, n271, n272, n273, n274, n275, n276, n277, n278,
         n279, n280, n281, n282, n283, n284, n285, n286, n287, n288, n289,
         n290, n291, n292, n293, n294, n295, n296, n297, n298, n299, n300,
         n301, n302, n303, n304, n305, n306, n307, n308, n309, n310, n311,
         n312, n313, n314, n315, n316, n317, n318, n319, n320, n321, n322,
         n323, n324, n325, n326, n327, n328, n329, n330, n331, n332, n333,
         n334, n335, n336, n337, n338, n339, n340, n341, n342, n343, n344,
         n345, n346, n347, n348, n349, n350, n351, n352, n353, n354, n355,
         n356, n357, n358, n359, n360, n361, n362, n363, n364, n365, n366,
         n367, n368, n369, n370, n371, n372, n373, n374, n375, n376, n377,
         n378, n379, n380, n381, n382, n383, n384, n385, n386, n387, n388,
         n389, n390, n391, n392, n393, n394, n395, n396, n397, n398, n399;
  wire   [15:0] syndrome;
  wire   [7:0] error_value;

  ERROR_INFORMATION error_information ( .Syndrome_in(syndrome), 
        .Error_location_out(Error_location_out), .Error_value_out(error_value), 
        .Decode_result_out(Decode_result_out) );
  STQ_ND2_S_3 U240 ( .A1(n372), .A2(n192), .X(n225) );
  STQ_INV_S_0P65 U241 ( .A(codeword_in[24]), .X(n305) );
  STQ_INV_S_0P65 U242 ( .A(codeword_in[74]), .X(n240) );
  STQ_INV_S_0P65 U243 ( .A(codeword_in[25]), .X(n307) );
  STQ_INV_S_0P65 U244 ( .A(codeword_in[57]), .X(n367) );
  STQ_INV_S_0P65 U245 ( .A(codeword_in[27]), .X(n274) );
  STQ_INV_S_0P65 U246 ( .A(codeword_in[21]), .X(n262) );
  STQ_INV_S_0P65 U247 ( .A(codeword_in[23]), .X(n260) );
  STQ_INV_S_0P65 U248 ( .A(codeword_in[20]), .X(n270) );
  STQ_INV_S_0P65 U249 ( .A(codeword_in[58]), .X(n370) );
  STQ_INV_S_0P65 U250 ( .A(codeword_in[30]), .X(n312) );
  STQ_INV_S_0P65 U251 ( .A(codeword_in[72]), .X(n236) );
  STQ_INV_S_0P65 U252 ( .A(codeword_in[55]), .X(n319) );
  STQ_INV_S_0P65 U253 ( .A(codeword_in[54]), .X(n336) );
  STQ_INV_S_0P65 U254 ( .A(codeword_in[19]), .X(n268) );
  STQ_INV_S_0P65 U255 ( .A(codeword_in[60]), .X(n254) );
  STQ_INV_S_0P65 U256 ( .A(codeword_in[32]), .X(n228) );
  STQ_INV_S_0P65 U257 ( .A(codeword_in[59]), .X(n252) );
  STQ_INV_S_0P65 U258 ( .A(codeword_in[28]), .X(n276) );
  STQ_INV_S_0P65 U259 ( .A(codeword_in[53]), .X(n321) );
  STQ_INV_S_0P65 U260 ( .A(codeword_in[76]), .X(n258) );
  STQ_INV_S_0P65 U261 ( .A(codeword_in[34]), .X(n232) );
  STQ_INV_S_0P65 U262 ( .A(codeword_in[77]), .X(n226) );
  STQ_INV_S_0P65 U263 ( .A(codeword_in[73]), .X(n238) );
  STQ_INV_S_0P65 U264 ( .A(codeword_in[61]), .X(n361) );
  STQ_INV_S_0P65 U265 ( .A(codeword_in[44]), .X(n287) );
  STQ_INV_S_0P65 U266 ( .A(codeword_in[45]), .X(n289) );
  STQ_INV_S_0P65 U267 ( .A(codeword_in[43]), .X(n285) );
  STQ_INV_S_0P65 U268 ( .A(codeword_in[46]), .X(n291) );
  STQ_INV_S_0P65 U269 ( .A(codeword_in[42]), .X(n283) );
  STQ_INV_S_0P65 U270 ( .A(codeword_in[47]), .X(n294) );
  STQ_INV_S_0P65 U271 ( .A(codeword_in[40]), .X(n279) );
  STQ_INV_S_0P65 U272 ( .A(codeword_in[49]), .X(n325) );
  STQ_INV_S_0P65 U273 ( .A(codeword_in[79]), .X(n245) );
  STQ_INV_S_0P65 U274 ( .A(codeword_in[39]), .X(n188) );
  STQ_INV_S_0P65 U275 ( .A(codeword_in[62]), .X(n373) );
  STQ_INV_S_0P65 U276 ( .A(codeword_in[50]), .X(n327) );
  STQ_INV_S_0P65 U277 ( .A(codeword_in[38]), .X(n234) );
  STQ_INV_S_0P65 U278 ( .A(codeword_in[52]), .X(n333) );
  STQ_INV_S_0P65 U279 ( .A(codeword_in[51]), .X(n330) );
  STQ_INV_S_0P65 U280 ( .A(codeword_in[36]), .X(n250) );
  STQ_INV_S_0P65 U281 ( .A(codeword_in[17]), .X(n186) );
  STQ_INV_S_0P65 U282 ( .A(codeword_in[75]), .X(n314) );
  STQ_NR2_G_4 U283 ( .A1(n210), .A2(n182), .X(n369) );
  STQ_EO3_1 U284 ( .A1(n383), .A2(n382), .A3(n381), .X(n385) );
  STQ_BUF_U_1 U285 ( .A(n384), .X(n171) );
  STQ_INV_S_0P65 U286 ( .A(n341), .X(n160) );
  STQ_EO3_1 U287 ( .A1(n393), .A2(codeword_in[31]), .A3(codeword_in[47]), .X(
        n396) );
  STQ_EO2_S_0P5 U288 ( .A1(codeword_in[21]), .A2(codeword_in[29]), .X(n392) );
  STQ_EN2_6 U289 ( .A1(codeword_in[61]), .A2(codeword_in[37]), .X(n181) );
  STQ_INV_2 U290 ( .A(codeword_in[69]), .X(n217) );
  STQ_EO2_1 U291 ( .A1(codeword_in[18]), .A2(codeword_in[26]), .X(n345) );
  STQ_EO3_2 U292 ( .A1(n296), .A2(codeword_in[32]), .A3(codeword_in[40]), .X(
        n300) );
  STQ_EN3_1 U293 ( .A1(n166), .A2(codeword_in[42]), .A3(codeword_in[50]), .X(
        n346) );
  STQ_EO2_1 U294 ( .A1(codeword_in[16]), .A2(codeword_in[24]), .X(n299) );
  STQ_EO2_1 U295 ( .A1(codeword_in[22]), .A2(codeword_in[30]), .X(n350) );
  STQ_INV_S_0P65 U296 ( .A(n388), .X(n201) );
  STQ_INV_2 U297 ( .A(codeword_in[64]), .X(n297) );
  STQ_INV_2 U298 ( .A(codeword_in[70]), .X(n348) );
  STQ_EO3_1 U299 ( .A1(n187), .A2(codeword_in[31]), .A3(codeword_in[72]), .X(
        n386) );
  STQ_EO3_2 U300 ( .A1(n185), .A2(codeword_in[9]), .A3(codeword_in[41]), .X(
        n184) );
  STQ_EN3_2 U301 ( .A1(n177), .A2(codeword_in[43]), .A3(codeword_in[51]), .X(
        n317) );
  STQ_INV_2 U302 ( .A(codeword_in[66]), .X(n343) );
  STQ_INV_2 U303 ( .A(codeword_in[68]), .X(n353) );
  STQ_EO2_1 U304 ( .A1(codeword_in[19]), .A2(codeword_in[27]), .X(n316) );
  STQ_EO2_1 U305 ( .A1(codeword_in[17]), .A2(codeword_in[25]), .X(n391) );
  STQ_EO2_S_0P5 U306 ( .A1(codeword_in[49]), .A2(codeword_in[58]), .X(n215) );
  STQ_INV_2 U307 ( .A(codeword_in[65]), .X(n390) );
  STQ_INV_S_1 U308 ( .A(codeword_in[37]), .X(n339) );
  STQ_INV_3P5 U309 ( .A(codeword_in[30]), .X(n173) );
  STQ_INV_S_1 U310 ( .A(codeword_in[67]), .X(n213) );
  STQ_INV_S_1 U311 ( .A(codeword_in[29]), .X(n167) );
  STQ_EO2_S_2 U312 ( .A1(codeword_in[54]), .A2(codeword_in[63]), .X(n165) );
  STQ_INV_S_5 U313 ( .A(codeword_in[31]), .X(n168) );
  STQ_INV_3 U314 ( .A(codeword_in[71]), .X(n204) );
  STQ_NR2_6 U315 ( .A1(n182), .A2(n206), .X(n366) );
  STQ_NR2_8 U316 ( .A1(n207), .A2(n182), .X(n372) );
  STQ_NR2_G_5 U317 ( .A1(n178), .A2(n220), .X(n375) );
  STQ_ND2_S_10 U318 ( .A1(n219), .A2(Error_location_out[2]), .X(n178) );
  STQ_INV_7P5 U319 ( .A(n161), .X(n318) );
  STQ_INV_1P5 U320 ( .A(error_value[5]), .X(n205) );
  STQ_INV_1P5 U321 ( .A(error_value[6]), .X(n207) );
  STQ_INV_1P5 U322 ( .A(error_value[0]), .X(n209) );
  STQ_INV_1P5 U323 ( .A(error_value[7]), .X(n208) );
  STQ_INV_1P5 U324 ( .A(error_value[2]), .X(n210) );
  STQ_INV_4 U325 ( .A(Error_location_out[3]), .X(n219) );
  STQ_ND2B_6 U326 ( .A(Error_location_out[1]), .B(Error_location_out[0]), .X(
        n220) );
  STQ_EO2_3 U327 ( .A1(codeword_in[48]), .A2(codeword_in[56]), .X(n296) );
  STQ_EO2_S_2 U328 ( .A1(codeword_in[20]), .A2(codeword_in[28]), .X(n355) );
  STQ_EO2_3 U329 ( .A1(codeword_in[55]), .A2(codeword_in[63]), .X(n393) );
  STQ_EO3_1 U330 ( .A1(n181), .A2(codeword_in[45]), .A3(codeword_in[53]), .X(
        n180) );
  STQ_INV_S_1 U331 ( .A(codeword_in[16]), .X(n264) );
  STQ_INV_S_1 U332 ( .A(codeword_in[18]), .X(n266) );
  STQ_INV_S_1 U333 ( .A(codeword_in[26]), .X(n309) );
  STQ_INV_S_1 U334 ( .A(codeword_in[33]), .X(n230) );
  STQ_INV_S_1 U335 ( .A(codeword_in[41]), .X(n281) );
  STQ_INV_S_1 U336 ( .A(codeword_in[48]), .X(n323) );
  STQ_INV_S_1 U337 ( .A(codeword_in[56]), .X(n364) );
  STQ_INV_S_1 U338 ( .A(codeword_in[63]), .X(n398) );
  STQ_INV_S_1 U339 ( .A(codeword_in[78]), .X(n242) );
  STQ_INV_6P5 U340 ( .A(codeword_in[22]), .X(n187) );
  STQ_EO3_2 U341 ( .A1(n347), .A2(codeword_in[38]), .A3(codeword_in[46]), .X(
        n351) );
  STQ_EO3_2 U342 ( .A1(n352), .A2(codeword_in[36]), .A3(codeword_in[44]), .X(
        n356) );
  STQ_EO3_2 U343 ( .A1(n377), .A2(codeword_in[48]), .A3(codeword_in[57]), .X(
        n378) );
  STQ_EN2_4 U344 ( .A1(codeword_in[19]), .A2(codeword_in[28]), .X(n338) );
  STQ_EO2_S_0P5 U345 ( .A1(n247), .A2(n213), .X(data_out[51]) );
  STQ_EO2_S_0P5 U346 ( .A1(n224), .A2(n343), .X(data_out[50]) );
  STQ_EO2_S_0P5 U347 ( .A1(n248), .A2(n353), .X(data_out[52]) );
  STQ_EO2_S_0P5 U348 ( .A1(n374), .A2(n373), .X(data_out[46]) );
  STQ_EO2_S_0P5 U349 ( .A1(n223), .A2(n390), .X(data_out[49]) );
  STQ_EO2_S_0P5 U350 ( .A1(n399), .A2(n398), .X(data_out[47]) );
  STQ_EO2_S_0P5 U351 ( .A1(n368), .A2(n367), .X(data_out[41]) );
  STQ_EO2_S_0P5 U352 ( .A1(n362), .A2(n361), .X(data_out[45]) );
  STQ_EO2_S_0P5 U353 ( .A1(n365), .A2(n364), .X(data_out[40]) );
  STQ_EO2_S_0P5 U354 ( .A1(n371), .A2(n370), .X(data_out[42]) );
  STQ_EO3_2 U355 ( .A1(n340), .A2(n339), .A3(n338), .X(n387) );
  STQ_EN2_8 U356 ( .A1(codeword_in[49]), .A2(codeword_in[57]), .X(n185) );
  STQ_EN2_S_2 U357 ( .A1(codeword_in[59]), .A2(codeword_in[35]), .X(n177) );
  STQ_EN2_4 U358 ( .A1(codeword_in[41]), .A2(codeword_in[59]), .X(n159) );
  STQ_EN2_4 U359 ( .A1(codeword_in[50]), .A2(codeword_in[32]), .X(n158) );
  STQ_EN2_4 U360 ( .A1(codeword_in[69]), .A2(codeword_in[78]), .X(n198) );
  STQ_EN3_3 U361 ( .A1(n160), .A2(n159), .A3(n158), .X(n342) );
  STQ_NR2_G_4 U362 ( .A1(Error_location_out[3]), .A2(Error_location_out[2]), 
        .X(n161) );
  STQ_EO2_3 U363 ( .A1(codeword_in[34]), .A2(codeword_in[43]), .X(n380) );
  STQ_NR2_G_4 U364 ( .A1(n178), .A2(n162), .X(n358) );
  STQ_NR2_G_4 U365 ( .A1(n318), .A2(n162), .X(n335) );
  STQ_ND2_S_5 U366 ( .A1(Error_location_out[1]), .A2(Error_location_out[0]), 
        .X(n162) );
  STQ_INV_3P5 U367 ( .A(Decode_result_out[1]), .X(n216) );
  STQ_INV_4 U368 ( .A(n175), .X(n163) );
  STQ_EN3_3 U369 ( .A1(n387), .A2(n386), .A3(n164), .X(syndrome[0]) );
  STQ_EN3_3 U370 ( .A1(n163), .A2(n194), .A3(n195), .X(n164) );
  STQ_EN3_3 U371 ( .A1(n201), .A2(n197), .A3(n164), .X(syndrome[6]) );
  STQ_ND2_S_1P5 U372 ( .A1(n192), .A2(n366), .X(n223) );
  STQ_ND2_S_1P5 U373 ( .A1(n192), .A2(n369), .X(n224) );
  STQ_ND2_S_1P5 U374 ( .A1(n192), .A2(n332), .X(n248) );
  STQ_ND2_S_1P5 U375 ( .A1(n192), .A2(n329), .X(n247) );
  STQ_EN2_8 U376 ( .A1(codeword_in[60]), .A2(codeword_in[33]), .X(n200) );
  STQ_EN3_6 U377 ( .A1(n390), .A2(codeword_in[33]), .A3(codeword_in[73]), .X(
        n183) );
  STQ_EN2_S_2 U378 ( .A1(codeword_in[58]), .A2(codeword_in[34]), .X(n166) );
  STQ_ND2_S_2 U379 ( .A1(n191), .A2(n329), .X(n253) );
  STQ_ND2_S_2 U380 ( .A1(n191), .A2(n332), .X(n255) );
  STQ_EO2_3 U381 ( .A1(codeword_in[65]), .A2(codeword_in[74]), .X(n301) );
  STQ_EO3_3 U382 ( .A1(n202), .A2(n167), .A3(codeword_in[20]), .X(n388) );
  STQ_ND2_S_3 U383 ( .A1(n397), .A2(n192), .X(n244) );
  STQ_ND2_S_3 U384 ( .A1(n360), .A2(n192), .X(n218) );
  STQ_EN3_3 U385 ( .A1(n203), .A2(n187), .A3(n168), .X(n202) );
  STQ_EN2_8 U386 ( .A1(codeword_in[62]), .A2(codeword_in[17]), .X(n195) );
  STQ_EN3_3 U387 ( .A1(n204), .A2(n169), .A3(n170), .X(n196) );
  STQ_INV_S_24 U388 ( .A(codeword_in[26]), .X(n169) );
  STQ_INV_S_24 U389 ( .A(codeword_in[35]), .X(n170) );
  STQ_EN2_8 U390 ( .A1(codeword_in[27]), .A2(codeword_in[45]), .X(n172) );
  STQ_EO3_3 U391 ( .A1(n395), .A2(codeword_in[21]), .A3(n173), .X(n384) );
  STQ_EN2_8 U392 ( .A1(codeword_in[36]), .A2(codeword_in[18]), .X(n174) );
  STQ_EN3_6 U393 ( .A1(n204), .A2(codeword_in[26]), .A3(codeword_in[35]), .X(
        n175) );
  STQ_EN3_3 U394 ( .A1(n165), .A2(n174), .A3(n172), .X(n176) );
  STQ_EN3_3 U395 ( .A1(n165), .A2(n211), .A3(n212), .X(n193) );
  STQ_EN3_3 U396 ( .A1(n196), .A2(n195), .A3(n194), .X(n389) );
  STQ_NR2_G_6 U397 ( .A1(n318), .A2(n273), .X(n191) );
  STQ_ND2_S_3 U398 ( .A1(n363), .A2(n192), .X(n222) );
  STQ_NR2B_V1DG_4 U399 ( .A(error_value[3]), .B(n182), .X(n329) );
  STQ_NR2B_V1DG_4 U400 ( .A(error_value[4]), .B(n182), .X(n332) );
  STQ_NR2_G_4 U401 ( .A1(n208), .A2(n182), .X(n397) );
  STQ_NR2_G_4 U402 ( .A1(n205), .A2(n182), .X(n360) );
  STQ_NR2_G_4 U403 ( .A1(n209), .A2(n182), .X(n363) );
  STQ_ND2B_MM_8 U404 ( .A(Error_location_out[0]), .B(Error_location_out[1]), 
        .X(n273) );
  STQ_NR2_G_4 U405 ( .A1(n273), .A2(n178), .X(n311) );
  STQ_NR2_G_4 U406 ( .A1(n278), .A2(n178), .X(n293) );
  STQ_ND2_S_16 U407 ( .A1(Decode_result_out[0]), .A2(n216), .X(n182) );
  STQ_OR2_4 U408 ( .A1(Error_location_out[1]), .A2(Error_location_out[0]), .X(
        n278) );
  STQ_EN3_6 U409 ( .A1(n348), .A2(codeword_in[78]), .A3(codeword_in[14]), .X(
        n349) );
  STQ_EN3_6 U410 ( .A1(n297), .A2(codeword_in[72]), .A3(codeword_in[8]), .X(
        n298) );
  STQ_EN3_6 U411 ( .A1(n353), .A2(codeword_in[76]), .A3(codeword_in[12]), .X(
        n354) );
  STQ_EN3_3 U412 ( .A1(n180), .A2(n392), .A3(n179), .X(syndrome[13]) );
  STQ_EN3_3 U413 ( .A1(n217), .A2(codeword_in[13]), .A3(codeword_in[77]), .X(
        n179) );
  STQ_EN3_3 U414 ( .A1(n184), .A2(n391), .A3(n183), .X(syndrome[9]) );
  STQ_EO2_S_0P5 U415 ( .A1(n357), .A2(n186), .X(data_out[1]) );
  STQ_EO2_S_0P5 U416 ( .A1(n359), .A2(n187), .X(data_out[6]) );
  STQ_EO2_S_0P5 U417 ( .A1(n376), .A2(n188), .X(data_out[23]) );
  STQ_EN3_3 U418 ( .A1(n189), .A2(n338), .A3(n340), .X(n272) );
  STQ_EO2_3 U419 ( .A1(codeword_in[46]), .A2(codeword_in[55]), .X(n340) );
  STQ_EO3_3 U420 ( .A1(n190), .A2(codeword_in[37]), .A3(codeword_in[23]), .X(
        n189) );
  STQ_EN2_6 U421 ( .A1(codeword_in[64]), .A2(codeword_in[73]), .X(n190) );
  STQ_EN3_3 U422 ( .A1(n213), .A2(codeword_in[76]), .A3(codeword_in[40]), .X(
        n214) );
  STQ_EO2_2 U423 ( .A1(n222), .A2(n297), .X(data_out[48]) );
  STQ_EO2_2 U424 ( .A1(n225), .A2(n348), .X(data_out[54]) );
  STQ_EO2_2 U425 ( .A1(n244), .A2(n204), .X(data_out[55]) );
  STQ_EN2_8 U426 ( .A1(codeword_in[38]), .A2(codeword_in[47]), .X(n203) );
  STQ_ND2_G_2 U427 ( .A1(n191), .A2(n360), .X(n362) );
  STQ_ND2_G_2 U428 ( .A1(n191), .A2(n363), .X(n365) );
  STQ_ND2_G_2 U429 ( .A1(n191), .A2(n366), .X(n368) );
  STQ_ND2_G_2 U430 ( .A1(n191), .A2(n369), .X(n371) );
  STQ_ND2_G_2 U431 ( .A1(n191), .A2(n372), .X(n374) );
  STQ_ND2_G_2 U432 ( .A1(n191), .A2(n397), .X(n399) );
  STQ_NR2_6 U433 ( .A1(n318), .A2(n220), .X(n192) );
  STQ_EO2_S_8 U434 ( .A1(n389), .A2(n193), .X(n379) );
  STQ_EN3_3 U435 ( .A1(n387), .A2(n176), .A3(n342), .X(syndrome[5]) );
  STQ_EN3_3 U436 ( .A1(n385), .A2(n176), .A3(n171), .X(syndrome[7]) );
  STQ_EN2_8 U437 ( .A1(codeword_in[44]), .A2(codeword_in[53]), .X(n194) );
  STQ_EN3_3 U438 ( .A1(n199), .A2(codeword_in[24]), .A3(n198), .X(n197) );
  STQ_EO3_3 U439 ( .A1(n200), .A2(codeword_in[42]), .A3(codeword_in[51]), .X(
        n199) );
  STQ_EN3_6 U440 ( .A1(n343), .A2(codeword_in[10]), .A3(codeword_in[74]), .X(
        n344) );
  STQ_EN3_6 U441 ( .A1(codeword_in[67]), .A2(codeword_in[75]), .A3(
        codeword_in[11]), .X(n315) );
  STQ_INV_1P5 U442 ( .A(error_value[1]), .X(n206) );
  STQ_EO3_3 U443 ( .A1(n379), .A2(n384), .A3(n378), .X(syndrome[3]) );
  STQ_EO2_3 U444 ( .A1(codeword_in[68]), .A2(codeword_in[77]), .X(n341) );
  STQ_EN2_8 U445 ( .A1(codeword_in[27]), .A2(codeword_in[45]), .X(n212) );
  STQ_EN2_8 U446 ( .A1(codeword_in[36]), .A2(codeword_in[18]), .X(n211) );
  STQ_EO3_3 U447 ( .A1(n379), .A2(n215), .A3(n214), .X(syndrome[4]) );
  STQ_EO2_2 U448 ( .A1(n218), .A2(n217), .X(data_out[53]) );
  STQ_ND2_S_0P8 U449 ( .A1(n360), .A2(n375), .X(n221) );
  STQ_EO2_S_0P5 U450 ( .A1(n221), .A2(n339), .X(data_out[21]) );
  STQ_NR2_G_4 U451 ( .A1(n318), .A2(n278), .X(n257) );
  STQ_ND2_S_0P8 U452 ( .A1(n360), .A2(n257), .X(n227) );
  STQ_EO2_S_0P5 U453 ( .A1(n227), .A2(n226), .X(data_out[61]) );
  STQ_ND2_S_0P8 U454 ( .A1(n363), .A2(n375), .X(n229) );
  STQ_EO2_S_0P5 U455 ( .A1(n229), .A2(n228), .X(data_out[16]) );
  STQ_ND2_S_0P8 U456 ( .A1(n366), .A2(n375), .X(n231) );
  STQ_EO2_S_0P5 U457 ( .A1(n231), .A2(n230), .X(data_out[17]) );
  STQ_ND2_S_0P8 U458 ( .A1(n369), .A2(n375), .X(n233) );
  STQ_EO2_S_0P5 U459 ( .A1(n233), .A2(n232), .X(data_out[18]) );
  STQ_ND2_S_0P8 U460 ( .A1(n372), .A2(n375), .X(n235) );
  STQ_EO2_S_0P5 U461 ( .A1(n235), .A2(n234), .X(data_out[22]) );
  STQ_ND2_S_0P8 U462 ( .A1(n363), .A2(n257), .X(n237) );
  STQ_EO2_S_0P5 U463 ( .A1(n237), .A2(n236), .X(data_out[56]) );
  STQ_ND2_S_0P8 U464 ( .A1(n366), .A2(n257), .X(n239) );
  STQ_EO2_S_0P5 U465 ( .A1(n239), .A2(n238), .X(data_out[57]) );
  STQ_ND2_S_0P8 U466 ( .A1(n369), .A2(n257), .X(n241) );
  STQ_EO2_S_0P5 U467 ( .A1(n241), .A2(n240), .X(data_out[58]) );
  STQ_ND2_S_0P8 U468 ( .A1(n372), .A2(n257), .X(n243) );
  STQ_EO2_S_0P5 U469 ( .A1(n243), .A2(n242), .X(data_out[62]) );
  STQ_ND2_S_0P8 U470 ( .A1(n397), .A2(n257), .X(n246) );
  STQ_EO2_S_0P5 U471 ( .A1(n246), .A2(n245), .X(data_out[63]) );
  STQ_ND2_S_0P8 U472 ( .A1(n329), .A2(n375), .X(n249) );
  STQ_EO2_S_0P5 U473 ( .A1(n249), .A2(n170), .X(data_out[19]) );
  STQ_ND2_S_0P8 U474 ( .A1(n332), .A2(n375), .X(n251) );
  STQ_EO2_S_0P5 U475 ( .A1(n251), .A2(n250), .X(data_out[20]) );
  STQ_EO2_S_0P5 U476 ( .A1(n253), .A2(n252), .X(data_out[43]) );
  STQ_EO2_S_0P5 U477 ( .A1(n255), .A2(n254), .X(data_out[44]) );
  STQ_ND2_S_0P8 U478 ( .A1(n329), .A2(n257), .X(n256) );
  STQ_EO2_S_0P5 U479 ( .A1(n256), .A2(n314), .X(data_out[59]) );
  STQ_ND2_S_0P8 U480 ( .A1(n332), .A2(n257), .X(n259) );
  STQ_EO2_S_0P5 U481 ( .A1(n259), .A2(n258), .X(data_out[60]) );
  STQ_ND2_S_0P8 U482 ( .A1(n397), .A2(n358), .X(n261) );
  STQ_EO2_S_0P5 U483 ( .A1(n261), .A2(n260), .X(data_out[7]) );
  STQ_ND2_S_0P8 U484 ( .A1(n360), .A2(n358), .X(n263) );
  STQ_EO2_S_0P5 U485 ( .A1(n263), .A2(n262), .X(data_out[5]) );
  STQ_ND2_S_0P8 U486 ( .A1(n363), .A2(n358), .X(n265) );
  STQ_EO2_S_0P5 U487 ( .A1(n265), .A2(n264), .X(data_out[0]) );
  STQ_ND2_S_0P8 U488 ( .A1(n369), .A2(n358), .X(n267) );
  STQ_EO2_S_0P5 U489 ( .A1(n267), .A2(n266), .X(data_out[2]) );
  STQ_ND2_S_0P8 U490 ( .A1(n329), .A2(n358), .X(n269) );
  STQ_EO2_S_0P5 U491 ( .A1(n269), .A2(n268), .X(data_out[3]) );
  STQ_ND2_S_0P8 U492 ( .A1(n332), .A2(n358), .X(n271) );
  STQ_EO2_S_0P5 U493 ( .A1(n271), .A2(n270), .X(data_out[4]) );
  STQ_EO3_3 U494 ( .A1(n379), .A2(n388), .A3(n272), .X(syndrome[1]) );
  STQ_ND2_S_0P8 U495 ( .A1(n329), .A2(n311), .X(n275) );
  STQ_EO2_S_0P5 U496 ( .A1(n275), .A2(n274), .X(data_out[11]) );
  STQ_ND2_S_0P8 U497 ( .A1(n332), .A2(n311), .X(n277) );
  STQ_EO2_S_0P5 U498 ( .A1(n277), .A2(n276), .X(data_out[12]) );
  STQ_ND2_S_0P8 U499 ( .A1(n363), .A2(n293), .X(n280) );
  STQ_EO2_S_0P5 U500 ( .A1(n280), .A2(n279), .X(data_out[24]) );
  STQ_ND2_S_0P8 U501 ( .A1(n366), .A2(n293), .X(n282) );
  STQ_EO2_S_0P5 U502 ( .A1(n282), .A2(n281), .X(data_out[25]) );
  STQ_ND2_S_0P8 U503 ( .A1(n369), .A2(n293), .X(n284) );
  STQ_EO2_S_0P5 U504 ( .A1(n284), .A2(n283), .X(data_out[26]) );
  STQ_ND2_S_0P8 U505 ( .A1(n329), .A2(n293), .X(n286) );
  STQ_EO2_S_0P5 U506 ( .A1(n286), .A2(n285), .X(data_out[27]) );
  STQ_ND2_S_0P8 U507 ( .A1(n332), .A2(n293), .X(n288) );
  STQ_EO2_S_0P5 U508 ( .A1(n288), .A2(n287), .X(data_out[28]) );
  STQ_ND2_S_0P8 U509 ( .A1(n360), .A2(n293), .X(n290) );
  STQ_EO2_S_0P5 U510 ( .A1(n290), .A2(n289), .X(data_out[29]) );
  STQ_ND2_S_0P8 U511 ( .A1(n372), .A2(n293), .X(n292) );
  STQ_EO2_S_0P5 U512 ( .A1(n292), .A2(n291), .X(data_out[30]) );
  STQ_ND2_S_0P8 U513 ( .A1(n397), .A2(n293), .X(n295) );
  STQ_EO2_S_0P5 U514 ( .A1(n295), .A2(n294), .X(data_out[31]) );
  STQ_EO3_3 U515 ( .A1(n300), .A2(n299), .A3(n298), .X(syndrome[8]) );
  STQ_EN2_8 U516 ( .A1(codeword_in[23]), .A2(codeword_in[39]), .X(n395) );
  STQ_EO3_3 U517 ( .A1(n384), .A2(n364), .A3(n301), .X(n302) );
  STQ_EO3_3 U518 ( .A1(n379), .A2(n388), .A3(n302), .X(syndrome[2]) );
  STQ_ND2_S_0P8 U519 ( .A1(n397), .A2(n311), .X(n303) );
  STQ_EO2_S_0P5 U520 ( .A1(n303), .A2(n168), .X(data_out[15]) );
  STQ_ND2_S_0P8 U521 ( .A1(n360), .A2(n311), .X(n304) );
  STQ_EO2_S_0P5 U522 ( .A1(n304), .A2(n167), .X(data_out[13]) );
  STQ_ND2_S_0P8 U523 ( .A1(n363), .A2(n311), .X(n306) );
  STQ_EO2_S_0P5 U524 ( .A1(n306), .A2(n305), .X(data_out[8]) );
  STQ_ND2_S_0P8 U525 ( .A1(n366), .A2(n311), .X(n308) );
  STQ_EO2_S_0P5 U526 ( .A1(n308), .A2(n307), .X(data_out[9]) );
  STQ_ND2_S_0P8 U527 ( .A1(n369), .A2(n311), .X(n310) );
  STQ_EO2_S_0P5 U528 ( .A1(n310), .A2(n309), .X(data_out[10]) );
  STQ_ND2_S_0P8 U529 ( .A1(n372), .A2(n311), .X(n313) );
  STQ_EO2_S_0P5 U530 ( .A1(n313), .A2(n312), .X(data_out[14]) );
  STQ_EN3_3 U531 ( .A1(n317), .A2(n316), .A3(n315), .X(syndrome[11]) );
  STQ_ND2_S_0P8 U532 ( .A1(n397), .A2(n335), .X(n320) );
  STQ_EO2_S_0P5 U533 ( .A1(n320), .A2(n319), .X(data_out[39]) );
  STQ_ND2_S_0P8 U534 ( .A1(n360), .A2(n335), .X(n322) );
  STQ_EO2_S_0P5 U535 ( .A1(n322), .A2(n321), .X(data_out[37]) );
  STQ_ND2_S_0P8 U536 ( .A1(n363), .A2(n335), .X(n324) );
  STQ_EO2_S_0P5 U537 ( .A1(n324), .A2(n323), .X(data_out[32]) );
  STQ_ND2_S_0P8 U538 ( .A1(n366), .A2(n335), .X(n326) );
  STQ_EO2_S_0P5 U539 ( .A1(n326), .A2(n325), .X(data_out[33]) );
  STQ_ND2_S_0P8 U540 ( .A1(n369), .A2(n335), .X(n328) );
  STQ_EO2_S_0P5 U541 ( .A1(n328), .A2(n327), .X(data_out[34]) );
  STQ_ND2_S_0P8 U542 ( .A1(n329), .A2(n335), .X(n331) );
  STQ_EO2_S_0P5 U543 ( .A1(n331), .A2(n330), .X(data_out[35]) );
  STQ_ND2_S_0P8 U544 ( .A1(n332), .A2(n335), .X(n334) );
  STQ_EO2_S_0P5 U545 ( .A1(n334), .A2(n333), .X(data_out[36]) );
  STQ_ND2_S_0P8 U546 ( .A1(n372), .A2(n335), .X(n337) );
  STQ_EO2_S_0P5 U547 ( .A1(n337), .A2(n336), .X(data_out[38]) );
  STQ_EO3_3 U548 ( .A1(n346), .A2(n345), .A3(n344), .X(syndrome[10]) );
  STQ_EO2_S_2 U549 ( .A1(codeword_in[54]), .A2(codeword_in[62]), .X(n347) );
  STQ_EO3_3 U550 ( .A1(n351), .A2(n350), .A3(n349), .X(syndrome[14]) );
  STQ_EO2_S_2 U551 ( .A1(codeword_in[52]), .A2(codeword_in[60]), .X(n352) );
  STQ_EO3_3 U552 ( .A1(n356), .A2(n355), .A3(n354), .X(syndrome[12]) );
  STQ_ND2_S_0P8 U553 ( .A1(n366), .A2(n358), .X(n357) );
  STQ_ND2_S_0P8 U554 ( .A1(n372), .A2(n358), .X(n359) );
  STQ_ND2_S_0P8 U555 ( .A1(n397), .A2(n375), .X(n376) );
  STQ_EO2_2 U556 ( .A1(codeword_in[66]), .A2(codeword_in[75]), .X(n377) );
  STQ_EO3_3 U557 ( .A1(n380), .A2(codeword_in[16]), .A3(codeword_in[25]), .X(
        n383) );
  STQ_EO2_S_2 U558 ( .A1(codeword_in[70]), .A2(codeword_in[79]), .X(n382) );
  STQ_EO2_S_2 U559 ( .A1(codeword_in[52]), .A2(codeword_in[61]), .X(n381) );
  STQ_EN3_6 U560 ( .A1(codeword_in[71]), .A2(codeword_in[79]), .A3(
        codeword_in[15]), .X(n394) );
  STQ_EO3_2 U561 ( .A1(n396), .A2(n395), .A3(n394), .X(syndrome[15]) );
endmodule

