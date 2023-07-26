module bch_encoder(message, codeword);
  input [6:0] message;
  output [14:0] codeword;

  assign codeword[0] = message[0] ^ message[1] ^ message[3];
  assign codeword[1] = message[1] ^ message[2] ^ message[4];
  assign codeword[2] = message[2] ^ message[3] ^ message[5];
  assign codeword[3] = message[3] ^ message[4] ^ message[6];
  assign codeword[4] = message[0] ^ message[1] ^ message[3] ^ message[4] ^ message[5];
  assign codeword[5] = message[1] ^ message[2] ^ message[4] ^ message[5] ^ message[6];
  assign codeword[6] = message[0] ^ message[1] ^ message[2] ^ message[5] ^ message[6];
  assign codeword[7] = message[0] ^ message[2] ^ message[6];
  assign codeword[8] = message[0];
  assign codeword[9] = message[1];
  assign codeword[10] = message[2];
  assign codeword[11] = message[3];
  assign codeword[12] = message[4];
  assign codeword[13] = message[5];
  assign codeword[14] = message[6];
endmodule
