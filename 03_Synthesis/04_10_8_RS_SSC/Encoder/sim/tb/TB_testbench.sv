module TB();

wire [63:0] data_in;
wire [79:0] codeword_out;
 
reg [63:0] data;

initial begin
    data[63:56]  = 8'b1010_0011;
    data[55:0] = 56'b0;  
end

assign data_in = data;

  AMDCHIPKILL_ENCODER encoder(data_in, codeword_out);


  initial begin
    # 20;
    $display("data :     %b",data_in);
    $display("codeword : %b",codeword_out);
  end

endmodule
