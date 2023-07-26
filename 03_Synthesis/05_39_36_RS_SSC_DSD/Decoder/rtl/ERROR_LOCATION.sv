module ERROR_LOCATION(input [7:0] Syndrome0,
                      input [7:0] Syndrome1,
                      output [7:0] Error_location_out);
  // Syndome0 : 8bit Syndrome 0 입력
  // Syndrome1 : 8bit syndrome 1 입력
  // Error location out : Syndrome1/Syndrome0 의 절댓값 출력 => CE 경우라면 0~7이 나올 것임

   assign Error_location_out = (Syndrome1 > Syndrome0) ? Syndrome1-Syndrome0 : Syndrome0-Syndrome1;

endmodule


