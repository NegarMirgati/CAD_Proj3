module Datapath #(parameter N, parameter Q, parameter d) (input clk, input rst, input acc_en,input ready,
				input [N-1:0] weight,
				input [N-1:0] x ,
                                output data_out);

reg [N-1:0] acc_in;
reg [N-1:0] acc_out;
reg [N-1:0] add_in1;
reg [N-1:0] add_in2;
reg [N-1:0] add_out;
reg [N-1:0] mult_out;
reg [N-1:0] af_in;
reg [N-1:0] af_out;

Acc #(N) acc(.clk(clk), .rst(rst), .en(acc_en), .in(acc_in), .out(acc_out));
Multiplier #(N) mult(.a(x), .w(weight), .out(mult_out));
Adder #(N) adder(.num1(add_in1), .num2(add_in2),.out(add_out));
ActivationFunc #(N) af(.ready(ready), .in(af_in), .out(af_out));


always @ (*) begin

assign acc_in = add_out;
assign add_in1 = mult_out;
assign add_in2 = acc_out;
assign af_in = acc_out;

end


endmodule
