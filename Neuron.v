`timescale 1ns/1ns
module Neuron #(parameter N, parameter Q, parameter d)(input clk, input rst, input st);

wire acc_en, ready, clear_acc, x_write, w_write, res_write, done, memRead_x , memRead_w;
wire [N-1:0] data_out;
wire [Q-1:0] addr_x , addr_w;
wire [d-1:0] index_d_x, index_d_w;


Datapath #(N, Q, d) dp(.clk(clk), .rst(rst), .acc_en(acc_en),.ready(ready), .clear_acc(clear_acc),
		       .x_write(x_write), .w_write(w_write),.res_write(res_write), .memRead_x(memRead_x),
			.addr_x(addr_x), .addr_w(addr_w), .index_d_x(index_d_x), .index_d_w(index_d_w),
		       .memRead_w(memRead_w), .data_out(data_out));

Controller #(N, d, Q) c(.clk(clk), .rst(rst), .st(st), .acc_write(acc_en), .memRead_x(memRead_x),
			.memRead_w(memRead_w), .addr_x(addr_x), .addr_w(addr_w), .index_d_x(index_d_x), 
			.index_d_w(index_d_w), .ready(ready), .write_x(x_write), .write_w(w_write),
                        .res_write(res_write), .clear_acc(clear_acc), .done(done));



endmodule
