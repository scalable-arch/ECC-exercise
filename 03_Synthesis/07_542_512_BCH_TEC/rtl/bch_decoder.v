module bch_decoder(received, bypass, codeword, detection);
  input [541:0] received;
  input bypass;
  output [543:0] codeword;
  output detection;

  wire [9:0] syndrome1;
  wire [9:0] syndrome2;
  wire [9:0] syndrome3;
  wire [9:0] syndrome4;
  wire [9:0] syndrome5;
  wire [541:0] _codeword;

  bch_detector detector(received, syndrome1, syndrome2, syndrome3, syndrome4, syndrome5, detection);
  bch_corrector corrector(
    .received   (received   ),
    .syndrome1  (syndrome1  ),
    .syndrome2  (syndrome2  ),
    .syndrome3  (syndrome3  ),
    .syndrome4  (syndrome4  ),
    .syndrome5  (syndrome5  ),
    .codeword   (_codeword  )
  ); 

  // assign message  = bypass ? received[541:30] : codeword[541:30];
  assign codeword = bypass ? {2'b00, 
                              received[29:24], received[541:414], 
                              received[23:16], received[413:286], 
                              received[15:8],  received[285:158], 
                              received[7:0],   received[157:30] } :
                             {2'b00, 
                              _codeword[29:24], _codeword[541:414], 
                              _codeword[23:16], _codeword[413:286], 
                              _codeword[15:8],  _codeword[285:158], 
                              _codeword[7:0],   _codeword[157:30] };

endmodule
