module bch_detector(received, syndrome1, syndrome2, syndrome3, syndrome4, syndrome5, detection);
  input [541:0] received;
  output [9:0] syndrome1;
  output [9:0] syndrome2;
  output [9:0] syndrome3;
  output [9:0] syndrome4;
  output [9:0] syndrome5;
  output detection;

  bch_syndromes syndromes(received, syndrome1, syndrome2, syndrome3, syndrome4, syndrome5);
  assign detection = (| syndrome1) | (| syndrome2) | (| syndrome3) | (| syndrome4) | (| syndrome5);
endmodule
