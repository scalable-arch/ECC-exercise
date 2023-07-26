module ERROR_LOCATION(input [7:0] Syndrome0,
                      input [7:0] Syndrome1,
                      output [7:0] Error_location_out);
  // Syndome0 : 8bit Syndrome 0 input
  // Syndrome1 : 8bit syndrome 1 input
  // Error location out : Syndrome1/Syndrome0 absolute value => 0~7 (CE cases)

   assign Error_location_out = (Syndrome1 > Syndrome0) ? Syndrome1-Syndrome0 : Syndrome0-Syndrome1;

endmodule


