module bch_syndromes(received, syndrome1, syndrome2, syndrome3);
  input [14:0] received;
  output [3:0] syndrome1;
  output [3:0] syndrome2;
  output [3:0] syndrome3;

  assign syndrome1 = ({4{received[0]}}:q & 4'b0001) ^ ({4{received[1]}}:q & 4'b0010) ^ ({4{received[2]}}:q & 4'b0100) ^ ({4{received[3]}}:q & 4'b1000) ^ ({4{received[4]}}:q & 4'b0011) ^ ({4{received[5]}}:q & 4'b0110) ^ ({4{received[6]}}:q & 4'b1100) ^ ({4{received[7]}}:q & 4'b1011) ^ ({4{received[8]}}:q & 4'b0101) ^ ({4{received[9]}}:q & 4'b1010) ^ ({4{received[10]}}:q & 4'b0111) ^ ({4{received[11]}}:q & 4'b1110) ^ ({4{received[12]}}:q & 4'b1111) ^ ({4{received[13]}}:q & 4'b1101) ^ ({4{received[14]}}:q & 4'b1001);
  assign syndrome2 = ({4{received[0]}}:q & 4'b0001) ^ ({4{received[1]}}:q & 4'b0100) ^ ({4{received[2]}}:q & 4'b0011) ^ ({4{received[3]}}:q & 4'b1100) ^ ({4{received[4]}}:q & 4'b0101) ^ ({4{received[5]}}:q & 4'b0111) ^ ({4{received[6]}}:q & 4'b1111) ^ ({4{received[7]}}:q & 4'b1001) ^ ({4{received[8]}}:q & 4'b0010) ^ ({4{received[9]}}:q & 4'b1000) ^ ({4{received[10]}}:q & 4'b0110) ^ ({4{received[11]}}:q & 4'b1011) ^ ({4{received[12]}}:q & 4'b1010) ^ ({4{received[13]}}:q & 4'b1110) ^ ({4{received[14]}}:q & 4'b1101);
  assign syndrome3 = ({4{received[0]}}:q & 4'b0001) ^ ({4{received[1]}}:q & 4'b1000) ^ ({4{received[2]}}:q & 4'b1100) ^ ({4{received[3]}}:q & 4'b1010) ^ ({4{received[4]}}:q & 4'b1111) ^ ({4{received[5]}}:q & 4'b0001) ^ ({4{received[6]}}:q & 4'b1000) ^ ({4{received[7]}}:q & 4'b1100) ^ ({4{received[8]}}:q & 4'b1010) ^ ({4{received[9]}}:q & 4'b1111) ^ ({4{received[10]}}:q & 4'b0001) ^ ({4{received[11]}}:q & 4'b1000) ^ ({4{received[12]}}:q & 4'b1100) ^ ({4{received[13]}}:q & 4'b1010) ^ ({4{received[14]}}:q & 4'b1111);
endmodule
