`timescale 1ns/1ns
module Datapath #(parameter N, parameter Q, parameter d) (input clk, input rst, input acc_en,
				input ready, input clear_acc,
				input x_write, input w_write, input res_write,
				input [N-1:0] weight,
				input [N-1:0] x ,
                                output data_out);

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

Acc #(N) acc(.clk(clk), .rst(rst),.clear_acc(claer_acc), .en(acc_en), .in(acc_in), .out(acc_out));
Multiplier #(N) mult(.a(x_out), .w(w_out), .out(mult_out));
Adder #(N) adder(.num1(add_in1), .num2(add_in2),.out(add_out));
ActivationFunc #(N) af(.ready(ready), .in(af_in), .out(af_out));
Register #(N) x_reg(.clk(clk), .rst(rst),.reg_write(x_write) , .in(x), .out(x_out));
Regsiter #(N) w_reg(.clk(clk), .rst(rst),.reg_write(w_write) , .in(x), .out(w_out));
Register #(N) result(.clk(clk), .rst(rst), .reg_write(res_write), .in(res_in), .out(res_out));



assign acc_in = add_out;
assign add_in1 = mult_out;
assign add_in2 = acc_out;
assign af_in = acc_out;
assign res_in = acc_out;
assign data_out = res_out;


endmodule
