`timescale 1ns/1ns
module adder #(parameter N)(input [N-1:0] num1, input [N-1:0] num2, output [N-1:0] out  );

reg [N-1:0] res;
reg [N-1:0] result;
reg extra;
reg overflow;
assign out = res;

always @(num1,num2) begin
	// both negative or both positive
	if(num1[N-1] == num2[N-1])
	 begin						//	Since they have the same sign, absolute magnitude increases
		res[N-2:0] = num1[N-2:0] + num2[N-2:0];		//		So we just add the two numbers
		res[N-1] = num1[N-1];							//		and set the sign appropriately...  Doesn't matter which one we use, they both have the same sign	
		
												
		{extra, result} = {1'b0,1'b0, num1[N-2:0]} + {1'b0,1'b0, num2[N-2:0]} ;
  		overflow  = ({extra, result[N-1]} == 2'b01 );
				
	end	
											
	//	one of them is negative...
	else if(num1[N-1] == 0 && num2[N-1] == 1) 
	   begin		                                //	subtract a-b
		if( num1[N-2:0] > num2[N-2:0] ) 
		begin					//	if a is greater than b,
			res[N-2:0] = num1[N-2:0] - num2[N-2:0];			//		then just subtract b from a
			res[N-1] = 0;										//		and manually set the sign to positive
	         end
		else begin												//	if a is less than b,
			res[N-2:0] = num2[N-2:0] - num1[N-2:0];			//		we'll actually subtract a from b to avoid a 2's complement answer
			if (res[N-2:0] == 0)
				res[N-1] = 0;										//		I don't like negative zero....
			else
				res[N-1] = 1;										//		and manually set the sign to negative
			end
	   end
	else begin												//	subtract b-a (a negative, b positive)
		if( num1[N-2:0] > num2[N-2:0] ) begin					//	if a is greater than b,
			res[N-2:0] = num1[N-2:0] - num2[N-2:0];			//		we'll actually subtract b from a to avoid a 2's complement answer
			if (res[N-2:0] == 0)
				res[N-1] = 0;										//		I don't like negative zero....
			else
				res[N-1] = 1;										//		and manually set the sign to negative
			end
		else begin												//	if a is less than b,
			res[N-2:0] = num2[N-2:0] - num1[N-2:0];			//		then just subtract a from b
			res[N-1] = 0;										//		and manually set the sign to positive
			end
		end
	end
endmodule
