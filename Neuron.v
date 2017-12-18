`timescale 1ns/1ns
module Neuron #(parameter N, parameter Q, parameter d)(input clk, input rst, input st);

wire acc_en, ready, clear_acc, x_write, w_write, res_write, done;
wire [N-1:0] x, weight, data_out;


Datapath #(N, Q, d) dp(.clk(clk), .rst(rst), .acc_en(acc_en),.ready(ready), .clear_acc(clear_acc),
		       .x_write(x_write), .w_write(w_write),.res_write(res_write), 
		       .weight(weight),.x(x), .data_out(data_out));

Controller #(N, d, Q) c(.clk(clk), .rst(rst), .st(st), .acc_write(acc_write), .rst_dp(rst_dp),
                      .ready(ready) , .weight(weight), .write_x(x_write), .write_w(write_w),
                      .res_write(res_write), .clear_acc(clear_acc), .done(done), .x(x));








endmodule
