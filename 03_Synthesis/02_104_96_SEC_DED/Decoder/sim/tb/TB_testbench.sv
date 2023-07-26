module TB();

wire [103:0] codeword_in;
wire [95:0] data_out;
wire decode_result_out;
reg [103:0] codeword;

initial begin
    //codeword[103]  = 1'b1; // error value
    //codeword[102:0]   = 103'b0;  

    codeword[103:102] = 2'b11;
    codeword[101:0] = 102'b0;
end

assign codeword_in = codeword;

  SEC_DED_DECODER(codeword_in,decode_result_out,data_out);


  initial begin
    # 20;
    $display("codeword :           %b",codeword_in);
    $display("data :               %b",data_out);
    $display("decode result :      %b",decode_result_out);
  end

endmodule