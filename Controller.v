`timescale 1ns/1ns
module Controller #(parameter N, parameter d, parameter Q)(input clk, input rst, input st, 
					                   output reg acc_write,
					     		   output reg ready, output reg[N-1:0] weight,
					                   output reg write_x, output reg write_w,
					                   output reg res_write, clear_acc,
					                   output reg done,
					                   output reg[N-1:0]x);

reg[2:0] state;
reg[2:0] next_state;

reg[d-1:0] d_cnt = {(d){1'b0}};
reg[Q-1:0] q_cnt = {(Q){1'b0}};

reg d_flag = 1'b0;
reg q_flag = 1'b0;

parameter state0 = 0;
parameter state1 = 1;
parameter state2 = 2;
parameter state3 = 3;
parameter state4 = 4;
parameter state5 = 5;

always @(posedge clk, posedge rst) begin

if(rst) 
    state <= 3'd0;
else
    state <= next_state;

end

always @(*) begin
next_state = state0;

case (state)

state0 : next_state = (st) ? state1 : state0;
state1 : next_state = state2;
state2 : next_state = d_flag ? state3 : state1;
state3 : next_state = state4;
state4 : next_state = q_flag ? state5 : state1;
default: next_state = state0;

endcase

end



always @(posedge clk) begin


case (state)

state0 : begin

    acc_write = 1'b0;
    ready = 1'b0;
    write_x = 1'b0;
    write_w = 1'b0;
    done = 1'b0;
    res_write = 1'b0;

end


state1 : begin

write_x = 1'b1;
write_w = 1'b1;
ready = 1'b0;
acc_write = 1'b0;
done = 1'b0;

if(d_cnt < d)
    d_cnt = d_cnt + 1;
else 
    d_flag = 1'b1;

if(q_cnt < Q)
    q_cnt = q_cnt + 1;
else
    q_cnt = 1'b1;

end


/*****Handle Data and Weight with respect to q_cnt and d_cnt ****/
    
state2: begin

write_x = 1'b0;
write_w = 1'b0;
acc_write = 1'b1;
ready = 1'b1;
done = 1'b0;

end


state3: begin

acc_write = 1'b0;
ready = 1'b0;
res_write = 1'b1;
done = 1'b0;

end


state4: begin

res_write = 1'b0;
clear_acc = 1'b1;
ready = 1'b0;
acc_write = 1'b0;
done = 1'b0;

end


state5: begin

clear_acc = 1'b0;
done = 1'b1;

end

default: begin
	{done, clear_acc, ready, res_write, acc_write, write_x, write_w} = 7'd0;
         x = {(N){1'b0}};
	 weight = {(N){1'b0}};
end


endcase

end

endmodule