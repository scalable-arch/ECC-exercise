module bch_corrector(received, syndrome1, syndrome2, syndrome3, syndrome4, syndrome5, codeword);
  input [541:0] received;
  input [9:0] syndrome1;
  input [9:0] syndrome2;
  input [9:0] syndrome3;
  input [9:0] syndrome4;
  input [9:0] syndrome5;
  output [541:0] codeword;
  // output [511:0] message;

  wire [9:0] locator0;
  wire [9:0] locator1;
  wire [9:0] locator2;
  wire [9:0] locator3;

  bch_ibm ibm(syndrome1, syndrome2, syndrome3, syndrome4, syndrome5, locator0, locator1, locator2, locator3);
  bch_chien chien(received, locator0, locator1, locator2, locator3, codeword);

  // assign message = codeword[541:30];
endmodule
