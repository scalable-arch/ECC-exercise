module bch_decoder(received, codeword, message, detection);
  input [14:0] received;
  output [14:0] codeword;
  output [6:0] message;
  output detection;

  wire [3:0] syndrome1;
  wire [3:0] syndrome2;
  wire [3:0] syndrome3;

  bch_detector detector(received, syndrome1, syndrome2, syndrome3, detection);
  bch_corrector corrector(received, syndrome1, syndrome2, syndrome3, codeword, message);

  assign message = codeword[14:8];
endmodule
