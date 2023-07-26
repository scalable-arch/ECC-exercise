module RS_SSC_DSD_DECODER(input [311:0] codeword_in,
                      output [1:0] Decode_result_out,
                      output [287:0] data_out
                      );

  // GF(2^8)에서의 primitive polynomial 기반 systematic-decoding 진행
  // primitive polynomial = x^8 + x6 + x^4 + x^3 + x^2 + x + 1 => Unity ECC와 같다.

  /*
    G-Matrix는 아래와 같다. (36개 row, 39개 column [symbol 모양])

    1 0 0 0 0 0 0 0 0 0 0 ... 0 1 1    1
    0 1 0 0 0 0 0 0 0 0 0 ... 0 1 a^1  a^2
    0 0 1 0 0 0 0 0 0 0 0 ... 0 1 a^2  a^4
    0 0 0 1 0 0 0 0 0 0 0 ... 0 1 a^3  a^6
    0 0 0 0 1 0 0 0 0 0 0 ... 0 1 a^4  a^8
    0 0 0 0 0 1 0 0 0 0 0 ... 0 1 a^5  a^10
    0 0 0 0 0 0 1 0 0 0 0 ... 0 1 a^6  a^12
    0 0 0 0 0 0 0 1 0 0 0 ... 0 1 a^7  a^14
    ...                       ...
    0 0 0 0 0 0 0 0 0 0 0 ... 1 1 a^35 a^70

    H-Matrix는 아래와 같다. (3개 row, 39개 column [symbol 모양])

    1 1   1   1   1   1    1    1    1    ... 1    1 0 0 
    1 a^1 a^2 a^3 a^4 a^5  a^6  a^7  a^8  ... a^35 0 1 0 
    1 a^2 a^4 a^6 a^8 a^10 a^12 a^14 a^16 ... a^70 0 0 1 

  */

  wire [7:0] syndrome0, syndrome1, syndrome2;
  wire [5:0] error_location;
  wire [7:0] error_value;
  wire [1:0] decode_result;
  reg [311:0] codeword;
  reg [287:0] data;


  // Syndrome generation
  SYNDROME_GENERATOR syndrome_generator(codeword_in,syndrome0, syndrome1, syndrome2);
  ERROR_INFORMATION error_information(syndrome0, syndrome1, syndrome2, error_location, error_value, decode_result);

  // error correction
  // NE 또는 DUE 이면 error correction 진행 안하고, 그대로 data만 추출 => Decode result = NE(00) 또는 DUE(10)
  // CE이면 error correction 진행, Error location 값도 그대로 전달 => Decode result = 01 (CE)

    always_comb begin
      //$display("syndrome0 : %b",syndrome0);    
      //$display("syndrome1 : %b",syndrome1);   
      //$display("syndrome2 : %b",syndrome2);
      // DUE 'or' NE
      if(decode_result != 2'b01) begin
         data=codeword_in[311:24];
      end 
      if(decode_result == 2'b01) begin
         codeword=codeword_in;
         case(error_location)
            6'b00_0000: codeword[311:304]^=error_value;
            6'b00_0001: codeword[303:296]^=error_value;
            6'b00_0010: codeword[295:288]^=error_value;
            6'b00_0011: codeword[287:280]^=error_value;
            6'b00_0100: codeword[279:272]^=error_value;
            6'b00_0101: codeword[271:264]^=error_value;
            6'b00_0110: codeword[263:256]^=error_value;
            6'b00_0111: codeword[255:248]^=error_value;
            6'b00_1000: codeword[247:240]^=error_value;
            6'b00_1001: codeword[239:232]^=error_value;
            6'b00_1010: codeword[231:224]^=error_value;
            6'b00_1011: codeword[223:216]^=error_value;
            6'b00_1100: codeword[215:208]^=error_value;
            6'b00_1101: codeword[207:200]^=error_value;
            6'b00_1110: codeword[199:192]^=error_value;
            6'b00_1111: codeword[191:184]^=error_value;
            6'b01_0000: codeword[183:176]^=error_value;
            6'b01_0001: codeword[175:168]^=error_value;
            6'b01_0010: codeword[167:160]^=error_value;
            6'b01_0011: codeword[159:152]^=error_value;
            6'b01_0100: codeword[151:144]^=error_value;
            6'b01_0101: codeword[143:136]^=error_value;
            6'b01_0110: codeword[135:128]^=error_value;
            6'b01_0111: codeword[127:120]^=error_value;
            6'b01_1000: codeword[119:112]^=error_value;
            6'b01_1001: codeword[111:104]^=error_value;
            6'b01_1010: codeword[103:96] ^=error_value;
            6'b01_1011: codeword[95:88]  ^=error_value;
            6'b01_1100: codeword[87:80]  ^=error_value;
            6'b01_1101: codeword[79:72]  ^=error_value;
            6'b01_1110: codeword[71:64]  ^=error_value;
            6'b01_1111: codeword[64:56]  ^=error_value;
            6'b10_0000: codeword[55:48]  ^=error_value;
            6'b10_0001: codeword[47:40]  ^=error_value;
            6'b10_0010: codeword[39:32]  ^=error_value;
            6'b10_0011: codeword[31:24]  ^=error_value;
            6'b10_0100: codeword[23:16]  ^=error_value;
            6'b10_0101: codeword[15:8]   ^=error_value;
            6'b10_0110: codeword[7:0]    ^=error_value;
            default: codeword=codeword;
         endcase
         //$display("after codeword : %b", codeword);
         data=codeword[311:24];
      end
      //$display("syndrome : %b",syndrome);
   end


  assign data_out = data; // error location : 0 > 79~72, error location : 1 > 71~64
  assign Decode_result_out = decode_result; // NE/CE/DUE
  //assign Error_location_out = error_location; // 0000~1001 (CE 아니라면 이상한 값 전달)
  //assign error_value_out = error_value; // for debug
  //assign syndrome0_out = syndrome0; // for debug
  //assign syndrome1_out = syndrome1; // for debug
  //assign syndrome2_out = syndrome2; // for debug

endmodule
