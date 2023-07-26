module ERROR_INFORMATION(input [7:0] Syndrome0_in,
                        input [7:0] Syndrome1_in,
                        input [7:0] Syndrome2_in,
                      output [5:0] Error_location_out,
                      output [7:0] Error_value_out,
                      output [1:0] Decode_result_out
                      );
  // Syndome_in : 24bit syndrome 입력
  // Error_location_out : error (symbol) 위치 출력 (0~38, DUE/NE면 다른 값)
  // Error_value_out : error 값 출력 (0000_0000 ~ 1111_1111)
  // Decode_result_out : NE(00), CE(01), DUE(10) 결과 출력

  // GF(2^8)에서의 primitive polynomial 기반 systematic-encoding 진행
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

  reg [1:0] Decode_result;
  //wire [7:0] Error_location_gdiv;
  reg [7:0] Error_location1, Error_location2;
  reg [5:0] Error_location_reg;
  reg [7:0] Error_value;
  wire [7:0] Syndrome0,Syndrome1,Syndrome2;

  //GFDIV gdiv(Syndrome2_in, Syndrome1_in, Error_location_gdiv); // 앞 나누기 뒤 (case 3==1 [case1==1 && case2==1])
  //GFEXP gfexp(Error_location_gdiv, Error_location1); // Error location을 integer 처럼 변환

    GFEXP gfexp_00(Syndrome0_in,Syndrome0); // n
    GFEXP gfexp_01(Syndrome1_in,Syndrome1); // n+i
    GFEXP gfexp_02(Syndrome2_in,Syndrome2); // n+2i
    ERROR_LOCATION error_location_00(Syndrome1 , Syndrome0, Error_location1); // S1/S0
    ERROR_LOCATION error_location_01(Syndrome2 , Syndrome1, Error_location2); // S2/S1
    
   always_comb begin    
   //   $display("syndrome0_in :    %b",Syndrome0_in);
   //   $display("syndrome1_in :    %b",Syndrome1_in);
   //   $display("syndrome2_in :    %b",Syndrome2_in);
   //   $display("syndrome0    :    %d",Syndrome0);
   //   $display("syndrome1    :    %d",Syndrome1);
   //   $display("syndrome2    :    %d",Syndrome2);
   //   $display("Error location1 : %d",Error_location1);
   //   $display("Error location2 : %d",Error_location2);
     if(Syndrome0_in!=8'b0000_0000 && Syndrome1_in==8'b0000_0000 && Syndrome2_in==8'b0000_0000)begin // 37번째 symbol에서 error 발생
        Error_location_reg = 6'b10_0100; // 36
        Error_value=Syndrome0_in;
        Decode_result=2'b01; //CE
     end
     if(Syndrome0_in==8'b0000_0000 && Syndrome1_in!=8'b0000_0000 && Syndrome2_in==8'b0000_0000)begin // 38번째 symbol error 발생
        Error_location_reg = 6'b10_0101; // 37
        Error_value=Syndrome1_in;
        Decode_result=2'b01; //CE
     end
     if(Syndrome0_in==8'b0000_0000 && Syndrome1_in==8'b0000_0000 && Syndrome2_in!=8'b0000_0000)begin // 39번째 symbol error 발생
        Error_location_reg = 6'b10_0110; // 38
        Error_value=Syndrome2_in;
        Decode_result=2'b01; //CE
     end
     if(Syndrome0_in!=8'b0000_0000 && Syndrome1_in!=8'b0000_0000 && Syndrome2_in!=8'b0000_0000 && Error_location1<=8'd35 && Error_location1==Error_location2) begin // 1~36번째 symbol에서  error 발생
        //$display("error location div : %b",Error_location_gdiv);
         Error_location_reg = Error_location1[5:0]; // 000000 ~ 100011 (35)
         Error_value=Syndrome0_in;
         Decode_result=2'b01; // CE
         //$display("error information error location : %d",Error_location_reg);
         //$display("CE!");
     end
     if(Syndrome0_in!=8'b0000_0000 && Syndrome1_in!=8'b0000_0000 && Syndrome2_in!=8'b0000_0000 && !(Error_location1<=8'd35 && Error_location1==Error_location2)) begin
        //$display("error location div : %b",Error_location_gdiv);
         //$display("error information error location : %d",Error_location1);
         //$display("DUE");
         Error_location_reg = 6'b00_0000;
         Error_value=8'b0000_0000;
         Decode_result=2'b10; // DUE
     end
     if(Syndrome0_in==8'b0000_0000 && Syndrome1_in!=8'b0000_0000 && Syndrome2_in!=8'b0000_0000)begin
         Error_location_reg = 6'b00_0000;
         Error_value=8'b0000_0000;
         Decode_result=2'b10; // DUE
     end
      if(Syndrome0_in!=8'b0000_0000 && Syndrome1_in==8'b0000_0000 && Syndrome2_in!=8'b0000_0000)begin
         Error_location_reg = 6'b00_0000;
         Error_value=8'b0000_0000;
         Decode_result=2'b10; // DUE
     end
      if(Syndrome0_in!=8'b0000_0000 && Syndrome1_in!=8'b0000_0000 && Syndrome2_in==8'b0000_0000)begin
         Error_location_reg = 6'b00_0000;
         Error_value=8'b0000_0000;
         Decode_result=2'b10; // DUE
     end
     if(Syndrome0_in==8'b0000_0000 && Syndrome1_in==8'b0000_0000 && Syndrome2_in==8'b0000_0000) begin
        Error_location_reg = 6'b00_0000;
        Error_value=8'b0000_0000;
        Decode_result=2'b00; // NE
     end
   end
  
  assign Error_location_out =  Error_location_reg;
  assign Error_value_out = Error_value;
  // NE : Syndrome_in이 전부 0이면 NE
  // CE: Error location이 0~9이면 CE
  // 그 이외 : DUE
  assign Decode_result_out = Decode_result;

endmodule