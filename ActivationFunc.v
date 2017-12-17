module ActivationFunc #(parameter N)(input ready, input [N-1:0] in , output reg [N-1:0] out);

always @(*) begin

    if(ready) begin
        assign out = (in[0] != 1) ? {N{1'b0}} : {N{1'b1}};
    end
end


endmodule