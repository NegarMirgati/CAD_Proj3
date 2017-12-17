`timescale 1ns/1ns
module Multiplier #(parameter N)(input [N-1:0] a, input [N-1:0] w, output [N-1:0] out);

 reg [2*N -2:0] res   ;
 reg [2*N -2:0] temp1 ;
 reg [2*N -2:0] temp2 ;

 always @ (a, w) begin

 temp1[N-2:0] = a[N-2:0];
 temp1[2*N -2 : N-1] = {(N){1'b0}};

 temp2[N-2:0] = w[N-2:0];
 temp2[2*N -2 : N-1] = {(N){1'b0}};

  res = temp1 * temp2;
  res = res >> N-1 ;               //Shift by the size of fixed point bits
                                   //In this project (N-1) fixed point bits

 end

 assign out[N-1] = ( (~a[N-1] && w[N-1] ) || (a[N-1] && ~w[N-1]) ) ? 1'b1 : 1'b0;   // 0-1 , 1-0 sign = 1 other. 0
 assign out[N-2:0] = res[2*N -2: N];     // Delete LSB's
 

endmodule