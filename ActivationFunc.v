`timescale 1ns/1ns
module ActivationFunc #(parameter N)(input ready, input [N-1:0] in , output reg [N-1:0] out);

always @(*) begin

    if(ready) begin
        assign out = (in[N-2] == 1'b1 && in[N-1] == 1'b0 ) ? in : {(N){1'b0}};
    end
end


endmodule