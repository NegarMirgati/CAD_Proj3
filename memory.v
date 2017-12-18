`timescale 1ns / 1ps
module Memory #(parameter Q, parameter  d, parameter N) 
		(input clk,input[d-1:0] index_dimension, input memRead,[Q-1:0]addr, 
		 output reg[N-1:0] out);
 
reg [N-1:0] dataMem [0:Q-1][0:d-1];
integer i,j;

integer seed = 1;

initial begin
for( i = 0; i <= Q - 1; i = i+1 )begin
 for ( j=0; j<= d - 1; j = j + 1) 
   begin
      dataMem[i][j] = {$random(seed)} % 2**(N);
   end
   end
 
end

  
 always@ (memRead, addr,index_dimension)
  begin
    if(memRead)
      out <= dataMem[addr][index_dimension];
		else
		begin end
  end
  
  
 
endmodule