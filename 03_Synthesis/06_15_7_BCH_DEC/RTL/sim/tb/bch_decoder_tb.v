module decoder_tb;
  reg [14:0] received;
  wire [14:0] codeword;
  wire [6:0] message;
  wire detection;
  integer failures;

  bch_decoder decoder(received, codeword, message, detection);

  initial
  begin
    failures = 0;

    received <= 15'b110100010000001;
    #1;
    if (message != 7'b1101000 || detection)
      failures = failures+1;

    received <= 15'b000001110100010;
    #1;
    if (message != 7'b0000011 || detection)
      failures = failures+1;

    received <= 15'b000100111001100;
    #1;
    if (message != 7'b0001001 || detection)
      failures = failures+1;

    received <= 15'b000001110100010;
    #1;
    if (message != 7'b0000011 || detection)
      failures = failures+1;

    received <= 15'b100010000001110;
    #1;
    if (message != 7'b1000100 || detection)
      failures = failures+1;

    received <= 15'b011101000100000;
    #1;
    if (message != 7'b0111010 || detection)
      failures = failures+1;

    received <= 15'b101001101110000;
    #1;
    if (message != 7'b1010011 || detection)
      failures = failures+1;

    received <= 15'b011000001001110;
    #1;
    if (message != 7'b0110000 || detection)
      failures = failures+1;

    received <= 15'b111110110001100;
    #1;
    if (message != 7'b1111101 || detection)
      failures = failures+1;

    received <= 15'b101111110001011;
    #1;
    if (message != 7'b1011111 || detection)
      failures = failures+1;

    received <= 15'b000010011100110;
    #1;
    if (message != 7'b0000100 || detection)
      failures = failures+1;

    received <= 15'b000010011100110;
    #1;
    if (message != 7'b0000100 || detection)
      failures = failures+1;

    received <= 15'b110000101001101;
    #1;
    if (message != 7'b1100001 || detection)
      failures = failures+1;

    received <= 15'b011000001001110;
    #1;
    if (message != 7'b0110000 || detection)
      failures = failures+1;

    received <= 15'b010010101000011;
    #1;
    if (message != 7'b0100101 || detection)
      failures = failures+1;

    received <= 15'b101001101110000;
    #1;
    if (message != 7'b1010011 || detection)
      failures = failures+1;

    received <= 15'b100110000010011;
    #1;
    if (message != 7'b1001100 || detection)
      failures = failures+1;

    received <= 15'b101110000101001;
    #1;
    if (message != 7'b1011100 || detection)
      failures = failures+1;

    received <= 15'b010101000011010;
    #1;
    if (message != 7'b0101010 || detection)
      failures = failures+1;

    received <= 15'b111101011001000;
    #1;
    if (message != 7'b1111010 || detection)
      failures = failures+1;

    received <= 15'b011011100001110;
    #1;
    if (message != 7'b0110111 || !detection)
      failures = failures+1;

    received <= 15'b111010001111010;
    #1;
    if (message != 7'b1100100 || !detection)
      failures = failures+1;

    received <= 15'b101001011010101;
    #1;
    if (message != 7'b1110010 || !detection)
      failures = failures+1;

    received <= 15'b101110101111000;
    #1;
    if (message != 7'b1011101 || !detection)
      failures = failures+1;

    received <= 15'b101001011010101;
    #1;
    if (message != 7'b1110010 || !detection)
      failures = failures+1;

    received <= 15'b001100011110110;
    #1;
    if (message != 7'b0011001 || !detection)
      failures = failures+1;

    received <= 15'b100001011101111;
    #1;
    if (message != 7'b1100010 || !detection)
      failures = failures+1;

    received <= 15'b000011010011101;
    #1;
    if (message != 7'b0000110 || !detection)
      failures = failures+1;

    received <= 15'b001101001000100;
    #1;
    if (message != 7'b0011010 || !detection)
      failures = failures+1;

    received <= 15'b110100101101010;
    #1;
    if (message != 7'b1111001 || !detection)
      failures = failures+1;

    received <= 15'b011100001010010;
    #1;
    if (message != 7'b0111000 || !detection)
      failures = failures+1;

    received <= 15'b001000001001110;
    #1;
    if (message != 7'b0110000 || !detection)
      failures = failures+1;

    received <= 15'b100000100100100;
    #1;
    if (message != 7'b1001001 || !detection)
      failures = failures+1;

    received <= 15'b111010110010011;
    #1;
    if (message != 7'b1110101 || !detection)
      failures = failures+1;

    received <= 15'b100000011010010;
    #1;
    if (message != 7'b1010000 || !detection)
      failures = failures+1;

    received <= 15'b101011101111110;
    #1;
    if (message != 7'b0010111 || !detection)
      failures = failures+1;

    received <= 15'b001101110000100;
    #1;
    if (message != 7'b0011011 || !detection)
      failures = failures+1;

    received <= 15'b100010000010011;
    #1;
    if (message != 7'b1001100 || !detection)
      failures = failures+1;

    received <= 15'b000101110111110;
    #1;
    if (message != 7'b0001011 || !detection)
      failures = failures+1;

    received <= 15'b100101100100011;
    #1;
    if (message != 7'b1101011 || !detection)
      failures = failures+1;

    received <= 15'b101101110100101;
    #1;
    if (message != 7'b0011011 || !detection)
      failures = failures+1;

    received <= 15'b010010110101101;
    #1;
    if (message != 7'b0100001 || !detection)
      failures = failures+1;

    received <= 15'b001100000111101;
    #1;
    if (message != 7'b0001000 || !detection)
      failures = failures+1;

    received <= 15'b111010001110100;
    #1;
    if (message != 7'b1010100 || !detection)
      failures = failures+1;

    received <= 15'b110011111000100;
    #1;
    if (message != 7'b1101111 || !detection)
      failures = failures+1;

    received <= 15'b100101100101100;
    #1;
    if (message != 7'b1001001 || !detection)
      failures = failures+1;

    received <= 15'b101101100101111;
    #1;
    if (message != 7'b1011011 || !detection)
      failures = failures+1;

    received <= 15'b000110101001010;
    #1;
    if (message != 7'b0001101 || !detection)
      failures = failures+1;

    received <= 15'b011100110111011;
    #1;
    if (message != 7'b1111000 || !detection)
      failures = failures+1;

    received <= 15'b000111101110011;
    #1;
    if (message != 7'b0011111 || !detection)
      failures = failures+1;

    received <= 15'b011100100001010;
    #1;
    if (message != 7'b0111001 || !detection)
      failures = failures+1;

    received <= 15'b001001101011001;
    #1;
    if (message != 7'b0010010 || !detection)
      failures = failures+1;

    received <= 15'b010100110001111;
    #1;
    if (message != 7'b0101100 || !detection)
      failures = failures+1;

    received <= 15'b001011100001001;
    #1;
    if (message != 7'b0010101 || !detection)
      failures = failures+1;

    received <= 15'b100110011000110;
    #1;
    if (message != 7'b1001101 || !detection)
      failures = failures+1;

    received <= 15'b100111010001011;
    #1;
    if (message != 7'b1011111 || !detection)
      failures = failures+1;

    received <= 15'b110010001010000;
    #1;
    if (message != 7'b1110100 || !detection)
      failures = failures+1;

    received <= 15'b000001110110000;
    #1;
    if (message != 7'b0000011 || !detection)
      failures = failures+1;

    received <= 15'b111101110011000;
    #1;
    if (message != 7'b1111011 || !detection)
      failures = failures+1;

    received <= 15'b010011101111000;
    #1;
    if (message != 7'b0100111 || !detection)
      failures = failures+1;

    received <= 15'b010111101100100;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b110110111001011;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b111100001110100;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b111101000111000;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b111110000010010;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b111011100001111;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b011110010111010;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b000100010111011;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b001010101011100;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b100111001111011;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b010110101100010;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b110101100000111;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b110010001110101;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b001110010001011;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b010010000100010;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b011010000111011;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b000010110100011;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b001111000000000;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b101100100011011;
    #1;
    if (!detection)
      failures = failures+1;

    received <= 15'b011001001011011;
    #1;
    if (!detection)
      failures = failures+1;

    $display("\n==============================");
    if (!failures)
      $display("\nAll decoding tests passed\n");
    else
      $display("Failed %d decoding test(s)", failures);
    $display("==============================\n");
  end
endmodule
