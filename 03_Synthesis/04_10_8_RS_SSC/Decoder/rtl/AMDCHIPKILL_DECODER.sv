module AMDCHIPKILL_DECODER(input [79:0] codeword_in,
                      output [3:0] Error_location_out,
                      output [1:0] Decode_result_out,
                      output [63:0] data_out
                      );
  // codeword_out: 80-bit RS codeword output


  /*
    G-Matrix

    1 0 0 0 0 0 0 0 1 1
    0 1 0 0 0 0 0 0 1 a^1
    0 0 1 0 0 0 0 0 1 a^2
    0 0 0 1 0 0 0 0 1 a^3
    0 0 0 0 1 0 0 0 1 a^4
    0 0 0 0 0 1 0 0 1 a^5
    0 0 0 0 0 0 1 0 1 a^6
    0 0 0 0 0 0 0 1 1 a^7

    H-Matrix

    1 1   1   1   1   1   1   1   1 0 
    1 a^1 a^2 a^3 a^4 a^5 a^6 a^7 0 1 

  */
  wire [15:0] syndrome;
  wire [3:0] error_location;
  wire [7:0] error_value;
  wire [1:0] decode_result;
  reg [79:0] codeword;
  reg [63:0] data;


  // Syndrome generation
  SYNDROME_GENERATOR syndrome_generator(codeword_in,syndrome);
  ERROR_INFORMATION error_information(syndrome, error_location, error_value, decode_result);
  //ERROR_CORRECTION error_correction(codeword_in, error_location, error_value, decode_result, data);
  // error correction
  // NE 'or' DUE: no error correction, extract data => Decode result = NE(00) 'or' DUE(10)
  // CE: implement error correction, forward Error location value => Decode result = 01 (CE)

    always_comb begin    
      // DUE 'or' NE
      if(decode_result != 2'b01) begin
         data=codeword_in[79:16];
      end 
      if(decode_result == 2'b01) begin
         codeword=codeword_in;
         case(error_location)
            4'b0000: codeword[79:72]^=error_value;
            4'b0001: codeword[71:64]^=error_value;
            4'b0010: codeword[63:56]^=error_value;
            4'b0011: codeword[55:48]^=error_value;
            4'b0100: codeword[47:40]^=error_value;
            4'b0101: codeword[39:32]^=error_value;
            4'b0110: codeword[31:24]^=error_value;
            4'b0111: codeword[23:16]^=error_value;
            4'b1000: codeword[15:8] ^=error_value;
            4'b1001: codeword[7:0]  ^=error_value;
            default: codeword=codeword;
         endcase
         //$display("after codeword : %b", codeword);
         data=codeword[79:16];
      end
   end


  assign data_out = data; // error location : 0 > 79~72, error location : 1 > 71~64
  assign Decode_result_out = decode_result; // NE/CE/DUE
  assign Error_location_out = error_location; // 0000~1001
  //assign error_value_out = error_value; // for debug
  //assign syndrome0_out = syndrome[15:8]; // for debug
  //assign syndrome1_out = syndrome[7:0]; // for debug

endmodule
