`timescale 1ns / 1ps
module memory_16byte(inout [7:0] data,input [3:0] address, input clk, read, write, preset, reset);
reg [7:0] mem [15:0];
integer i;
reg [7:0] dataout;
wire [7:0] tri_state_out;
initial for(i = 0;i<16; i= i +1) mem[i]= 8'b0;
always @(posedge clk, negedge reset) begin
    if (!reset) for(i = 0;i<16; i= i +1) mem[i]= 8'b0;
    else if (preset) for(i = 0;i<16; i= i +1) mem[i]= 8'hff;
    else if (write & !read ) mem[address] <= data;
end
assign tri_state_out = read ? mem[address] : 8'bz;
assign data = (read & !write) ? tri_state_out: 8'bz;
endmodule
