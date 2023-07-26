module TB();

wire [287:0] data_in;
wire [311:0] codeword_out;
 
reg [287:0] data;

initial begin
    data[287:280]  = 8'b1010_0011;
    data[279:272] = 8'b1110_1001;
    data[271:0] = 272'b0;  
end

assign data_in = data;

  RS_SSC_DSD_ENCODER(data_in, codeword_out);


  initial begin
    # 20;
    $display("data :     %b",data_in);
    $display("codeword : %b",codeword_out);
  end

endmodule
