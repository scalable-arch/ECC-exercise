module ERROR_INFORMATION(input [15:0] Syndrome_in,
                      output [3:0] Error_location_out,
                      output [7:0] Error_value_out,
                      output [1:0] Decode_result_out
                      );
  // Syndome_in : 16bit syndrome input
  // Error_location_out : error (symbol) location output (0~9, DUE/NE: 1111)
  // Error_value_out : error value output (0000_0000 ~ 1111_1111)
  // Decode_result_out : NE(00), CE(01), DUE(10)

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

  reg [1:0] Decode_result;
  //wire [7:0] Error_location_gdiv;
  reg [7:0] Error_location_gfexp;
  reg [3:0] Error_location_reg;
  reg [7:0] Error_value;
  wire [7:0] Syndrome0,Syndrome1;

  //GFDIV gdiv(Syndrome_in[7:0], Syndrome_in[15:8], Error_location_gdiv);
  //GFEXP gfexp(Error_location_gdiv, Error_location_gfexp);

    GFEXP gfexp_00(Syndrome_in[7:0],Syndrome0);
    GFEXP gfexp_01(Syndrome_in[15:8],Syndrome1);
    ERROR_LOCATION error_location(Syndrome1 , Syndrome0, Error_location_gfexp);
    //GFDIV error_value00(Syndrome_in[7:0],Syndrome_in[15:8], Error_location_gfdiv); // a^(50+?, 78+?, ...)/a^(25+?, 39+?, ...) => a^(25, 39, ...)  
    //GFDIV error_value01(Syndrome_in[15:8], Error_location_gfdiv, Error_value); // a^(25+?)/a^(a^25) => a^? (error value)
    
   always_comb begin    
     if(Syndrome_in[7:0]==8'b0000_0000 && Syndrome_in[15:8]!=8'b0000_0000)begin // 8th chip errors
        Error_location_reg = 4'b1000;
        Error_value=Syndrome_in[15:8];
        Decode_result=2'b01; //CE
     end
     if(Syndrome_in[7:0]!=8'b0000_0000 && Syndrome_in[15:8]==8'b0000_0000)begin // 9th chip errors
        Error_location_reg = 4'b1001;
        Error_value=Syndrome_in[7:0];
        Decode_result=2'b01; //CE
     end
     if(Syndrome_in[7:0]!=8'b0000_0000 && Syndrome_in[15:8]!=8'b0000_0000 && Error_location_gfexp<=8'd7) begin // 0~7th chip errors
        //$display("error location div : %b",Error_location_gdiv);
         //$display("error information error location : %d",Error_location_gfexp);
         //$display("CE!");
         Error_location_reg = Error_location_gfexp[3:0]; // 0000 ~ 0111
         Error_value=Syndrome_in[15:8];
         Decode_result=2'b01; // CE
     end
     if(Syndrome_in[7:0]!=8'b0000_0000 && Syndrome_in[15:8]!=8'b0000_0000 && Error_location_gfexp>8'd7) begin // 0~7th chip errors
        //$display("error location div : %b",Error_location_gdiv);
         //$display("error information error location : %d",Error_location_gfexp);
         //$display("DUE");
         Error_location_reg = 4'b0000;
         Error_value=8'b0000_0000;
         Decode_result=2'b10; // DUE
     end
     if(Syndrome_in[15:0]==16'b0000_0000_0000_0000) begin
        Error_location_reg = 4'b0000;
        Error_value=8'b0000_0000;
        Decode_result=2'b00; // NE
     end
   end
  
  assign Error_location_out =  Error_location_reg;
  assign Error_value_out = Error_value;
  // NE : Syndrome_in is all zero
  // CE: Error location is 0~9
  // otherwise : DUE
  assign Decode_result_out = Decode_result;

endmodule
