module TB();

wire [79:0] codeword_in;
wire [3:0] error_location_out;
wire decode_result_out;
wire [63:0] data_out;
//wire [7:0] error_value_out;
//wire [7:0] syndrome0_out;
//wire [7:0] syndrome1_out;
 
reg [79:0] codeword;

initial begin
    codeword[79:72]  = 8'b1010_0011; // error value
    codeword[71:0]   = 72'b0;  

    //codeword[79:72] = 8'b0000_0000;
    //codeword[71:64] = 8'b1010_0011;
    //codeword[63:0]  = 64'b0;
end

assign codeword_in = codeword;

  //AMDCHIPKILL_decodeR(codeword_in, error_location_out, decode_result_out, data_out, error_value_out,syndrome0_out,syndrome1_out);
  AMDCHIPKILL_DECODER decoder(codeword_in, error_location_out, decode_result_out, data_out);

  initial begin
    # 20;
    $display("codeword :           %b",codeword_in);
    //$display("syndrome_0 :         %b",syndrome0_out);
    //$display("syndrome_1 :         %b",syndrome1_out);
    $display("error_location :     %b",error_location_out);
    //$display("error_value :        %b",error_value_out);
    $display("decode_result_out :  %b",decode_result_out);
    $display("data :               %b",data_out);
  end

endmodule