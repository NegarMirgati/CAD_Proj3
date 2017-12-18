module Adder #(parameter N)(input [N-1:0] num1, input [N-1:0] num2, output [N-1:0] out  );

reg [N-1:0] res;
reg [N-1:0] result;
reg extra;
reg overflow;
assign out = res;

always @(num1,num2) begin
	// both negative or both positive
	if(num1[N-1] == num2[N-1])
	 begin						
		res[N-2:0] = num1[N-2:0] + num2[N-2:0];		
		res[N-1] = num1[N-1];							
		
												
		{extra, result} = {1'b0,1'b0, num1[N-2:0]} + {1'b0,1'b0, num2[N-2:0]} ;
  		overflow  = ({extra, result[N-1]} == 2'b01 );
		if ( overflow == 1 ) begin
		if ( num1[N-1] == 1'b0 ) begin  res[N-1] = 1'b0; res[N-2:0] = N-1'b1; end
		if ( num1[N-1] == 1'b1 ) begin res[N-1] = 1'b1; res[N-2:0] = N-1'b1; end
		end
				
	end	
											
	//	one of them is negative...
	else if(num1[N-1] == 0 && num2[N-1] == 1) 
	   begin		                              
		if( num1[N-2:0] > num2[N-2:0] ) 
		begin					
			res[N-2:0] = num1[N-2:0] - num2[N-2:0];			
			res[N-1] = 0;										
	         end
		else begin												
			res[N-2:0] = num2[N-2:0] - num1[N-2:0];			 
			if (res[N-2:0] == 0)
				res[N-1] = 0;										
			else
				res[N-1] = 1;										
			end
	   end
	else begin												
		if( num1[N-2:0] > num2[N-2:0] ) begin					
			res[N-2:0] = num1[N-2:0] - num2[N-2:0];			 
			if (res[N-2:0] == 0)
				res[N-1] = 0;										
			else
				res[N-1] = 1;										
			end
		else begin												
			res[N-2:0] = num2[N-2:0] - num1[N-2:0];			
			res[N-1] = 0;										
			end
		end
	end
endmodule

