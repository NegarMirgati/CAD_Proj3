`timescale 1ns/1ns
module tb #(parameter Q = 100 ,parameter  d = 3 , parameter N = 16)();

reg clk = 0;
reg rst = 0;
reg st = 0;

Neuron #(N,Q,d) n(.clk(clk), .rst(rst), .st(st));

initial begin

#113
rst = 1;

#1133

clk = ~clk;

#1113

clk = ~clk;

#1113

rst = 0;

#1113

st = 0;

#1113

st = 1;

#1113

clk = ~ clk;

#1113

clk = ~clk;

#1113 

st = 0;

repeat(10000) #1133 clk = ~clk;

end

endmodule

