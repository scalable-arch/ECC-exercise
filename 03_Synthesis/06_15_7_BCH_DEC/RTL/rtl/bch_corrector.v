module bch_corrector(received, syndrome1, syndrome2, syndrome3, codeword, message);
  input [14:0] received;
  input [3:0] syndrome1;
  input [3:0] syndrome2;
  input [3:0] syndrome3;
  output [14:0] codeword;
  output [6:0] message;

  wire [3:0] locator0;
  wire [3:0] locator1;
  wire [3:0] locator2;

  bch_ibm ibm(syndrome1, syndrome2, syndrome3, locator0, locator1, locator2);
  bch_chien chien(received, locator0, locator1, locator2, codeword);

  assign message = codeword[14:8];
endmodule
