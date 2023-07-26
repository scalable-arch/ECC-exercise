module TB();

wire [95:0] data_in;
wire [103:0] codeword_out;
 
reg [95:0] data;

initial begin
    data[95:88]  = 8'b1010_0011;
    data[87:0] = 88'b0;  
end

assign data_in = data;

  SEC_DED_ENCODER(data_in, codeword_out);


  initial begin
    # 20;
    $display("data :     %b",data_in);
    $display("codeword : %b",codeword_out);
  end

endmodule
