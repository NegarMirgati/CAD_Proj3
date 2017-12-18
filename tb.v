module tb #(parameter Q = 100 ,parameter  d = 3 , parameter N = 16)();

reg [N-1:0] weight_vector [0:Q-1][0:d-1];
reg [N-1:0] x_vector [0:Q-1][0:d-1];
integer i,j;

integer seed = 1;
integer seed1 = 2;

initial begin

#37
for( i = 0; i <= Q-1; i= i+1 )begin
 for ( j=0; j<=d-1; j=j+1) 
   begin
      weight_vector[i][j] = {$random(seed)} % 2**(N);
   end
   end
  //$display("%p",weight_vector);

for( i = 0; i <= Q-1; i= i+1 )begin
 for ( j=0; j<=d-1; j=j+1) 
   begin
      x_vector[i][j] = {$random(seed1)} % 2**(N);
   end
   end
#1000
  $stop;
end

endmodule

