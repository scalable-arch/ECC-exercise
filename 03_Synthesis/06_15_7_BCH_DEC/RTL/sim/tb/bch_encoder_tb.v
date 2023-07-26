module encoder_tb;
  reg [6:0] message;
  wire [14:0] codeword;
  integer failures;

  bch_encoder encoder(message, codeword);

  initial
  begin
    failures = 0;

    message <= 7'b1101100;
    #1;
    if (codeword != 15'b110110001100111)
      failures = failures+1;

    message <= 7'b1110110;
    #1;
    if (codeword != 15'b111011000110011)
      failures = failures+1;

    message <= 7'b1001111;
    #1;
    if (codeword != 15'b100111110110001)
      failures = failures+1;

    message <= 7'b0111110;
    #1;
    if (codeword != 15'b011111011000110)
      failures = failures+1;

    message <= 7'b1010000;
    #1;
    if (codeword != 15'b101000011010010)
      failures = failures+1;

    message <= 7'b1101000;
    #1;
    if (codeword != 15'b110100010000001)
      failures = failures+1;

    message <= 7'b1100011;
    #1;
    if (codeword != 15'b110001100111110)
      failures = failures+1;

    message <= 7'b1011000;
    #1;
    if (codeword != 15'b101100011001111)
      failures = failures+1;

    message <= 7'b1010101;
    #1;
    if (codeword != 15'b101010111100101)
      failures = failures+1;

    message <= 7'b1111000;
    #1;
    if (codeword != 15'b111100010111011)
      failures = failures+1;

    message <= 7'b1010100;
    #1;
    if (codeword != 15'b101010000110100)
      failures = failures+1;

    message <= 7'b0100111;
    #1;
    if (codeword != 15'b010011100110000)
      failures = failures+1;

    message <= 7'b1011010;
    #1;
    if (codeword != 15'b101101010111100)
      failures = failures+1;

    message <= 7'b0111010;
    #1;
    if (codeword != 15'b011101000100000)
      failures = failures+1;

    message <= 7'b0001010;
    #1;
    if (codeword != 15'b000101001101110)
      failures = failures+1;

    message <= 7'b1011100;
    #1;
    if (codeword != 15'b101110000101001)
      failures = failures+1;

    message <= 7'b0101110;
    #1;
    if (codeword != 15'b010111011111100)
      failures = failures+1;

    message <= 7'b0010111;
    #1;
    if (codeword != 15'b001011101111110)
      failures = failures+1;

    message <= 7'b0001010;
    #1;
    if (codeword != 15'b000101001101110)
      failures = failures+1;

    message <= 7'b0001110;
    #1;
    if (codeword != 15'b000111010001000)
      failures = failures+1;

    $display("\n==============================");
    if (!failures)
      $display("\nAll encoding tests passed\n");
    else
      $display("Failed %d encoding test(s)", failures);
    $display("==============================\n");
  end
endmodule
