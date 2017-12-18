`timescale 1ns/1ns
module Acc #(parameter N)(input clk, input rst,input clear_acc, input en, input [N-1:0] in, output[N-1:0] out);

reg[N-1:0] data;

always @(posedge clk, posedge rst) begin

if(rst)
	data<= {(N){1'b0}};

else if(clear_acc)

	data <= {{N}{1'b0}};

else if(en)

	data <= in;


end

assign out = data;


endmodule
