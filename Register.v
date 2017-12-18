`timescale 1ns/1ns
module Register #( parameter N)(input clk, input rst, input reg_write,
				 input [N-1:0] in, output [N-1:0] out);

reg[N-1:0] data;

always@(posedge clk, posedge rst) begin

if(rst)
    data <= {(N) {1'b0}};

else if(reg_write)
    data <= in;

end


assign out = data;
	


endmodule
