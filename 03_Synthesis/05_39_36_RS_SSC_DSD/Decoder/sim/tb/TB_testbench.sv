module TB();

wire [311:0] codeword_in;
//wire [5:0] Error_location_out;
wire [1:0] Decode_result_out;
wire [287:0] data_out;
//wire [7:0] error_value_out;
//wire [7:0] syndrome0_out;
//wire [7:0] syndrome1_out;
//wire [7:0] syndrome2_out;
 
reg [311:0] codeword;



initial begin
    codeword[311:304] = 8'b0;
    codeword[303:296]  = 8'b1010_1101; // error value
    codeword[295:0]   = 296'b0; 

    // codeword[311:304]  = 8'b1010_0011; // error value
    // codeword[303:296]   = 8'b0;
    // codeword[295:288]  = 8'b1010_1101; // error value
    // codeword[287:0]   = 288'b0; 


end

assign codeword_in = codeword;

  RS_SSC_DSD_DECODER(codeword_in, Decode_result_out, data_out);

  initial begin
    # 20;

    $display("codeword :           %b",codeword_in);
    //$display("syndrome_0 :         %b",syndrome0_out);
    //$display("syndrome_1 :         %b",syndrome1_out);
    //$display("syndrome_2 :         %b",syndrome2_out); 
    //$display("Error_location :     %b",Error_location_out);
    //$display("Error_value :        %b",error_value_out);
    $display("Decode_result_out :  %b",Decode_result_out);
    $display("data :               %b",data_out);
  end

endmodule