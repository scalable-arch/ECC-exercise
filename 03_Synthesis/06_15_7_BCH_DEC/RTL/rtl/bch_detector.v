module bch_detector(received, syndrome1, syndrome2, syndrome3, detection);
  input [14:0] received;
  output [3:0] syndrome1;
  output [3:0] syndrome2;
  output [3:0] syndrome3;
  output detection;

  bch_syndromes syndromes(received, syndrome1, syndrome2, syndrome3);
  assign detection = (| syndrome1) | (| syndrome2) | (| syndrome3);
endmodule
