`timescale 1ns/1ns
module Datapath #(parameter N, parameter Q, parameter d) (input clk, input rst, input acc_en,
				input ready, input clear_acc, input memRead_x, input memRead_w,
				input x_write, input w_write, input res_write, input [Q-1:0] addr_x,
				input [Q-1:0] addr_w, input [d-1:0] index_d_x, input[d-1:0] index_d_w,
                                output[N-1:0] data_out);

wire [N-1:0] acc_in;
wire [N-1:0] acc_out;
wire [N-1:0] add_in1;
wire [N-1:0] add_in2;
wire [N-1:0] add_out;
wire [N-1:0] mult_out;
wire [N-1:0] af_in;
wire [N-1:0] af_out;
wire [N-1:0]  x_out;
wire [N-1:0] w_out;
wire [N-1:0] res_out;
wire [N-1:0] res_in;
wire [N-1:0] mem_out_x;
wire [N-1:0] mem_out_w;
wire [N-1:0] x_in;
wire [N-1:0] w_in;


Acc #(N) acc(.clk(clk), .rst(rst),.clear_acc(claer_acc), .en(acc_en), .in(acc_in), .out(acc_out));
Multiplier #(N) mult(.a(x_out), .w(w_out), .out(mult_out));
Adder #(N) adder(.num1(add_in1), .num2(add_in2),.out(add_out));
ActivationFunc #(N) af(.ready(ready), .in(af_in), .out(af_out));
Register #(N) x_reg(.clk(clk), .rst(rst),.reg_write(x_write) , .in(x_in), .out(x_out));
Register #(N) w_reg(.clk(clk), .rst(rst),.reg_write(w_write) , .in(w_in), .out(w_out));
Register #(N) result(.clk(clk), .rst(rst), .reg_write(res_write), .in(res_in), .out(res_out));
Memory #(Q, d, N) mem_x(.clk(clk), .index_dimension(index_d_x),.memRead(memRead_x),.addr(addr_x), .out(mem_out_x));
Memory #(Q, d, N) mem_w(.clk(clk), .index_dimension(index_d_w),.memRead(memRead_w),.addr(addr_w), .out(mem_out_w));


assign acc_in = add_out;
assign add_in1 = mult_out;
assign add_in2 = acc_out;
assign af_in = acc_out;
assign res_in = af_out;
assign data_out = res_out;
assign x_in = mem_out_x;
assign w_in = mem_out_w;


endmodule
