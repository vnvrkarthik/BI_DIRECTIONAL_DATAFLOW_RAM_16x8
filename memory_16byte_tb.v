`timescale 1ns / 1ps
module memory_16byte_tb;
wire [7:0] data;
reg [3:0] address;
reg clk, read, write, preset, reset;
reg [7:0] data_tb;
memory_16byte uut(data,address, clk , read, write, preset, reset);
assign data = (write & !read) ? data_tb : 8'bz;
initial begin
    $monitor("Time = %t | Addr = %d | Data = %h | Data_tb = %h | r = %b | w = %b | preset = %b | reset = %b", $time,address, data, data_tb, read, write,preset, reset);
    clk = 0;
 end
 
always #5 clk = ~clk;

initial begin
address = 0;read = 0;write = 0;preset = 0; reset = 0;data_tb = 0;
#10 reset = 1;
#10 reset = 0;
#10 reset = 1;
read = 1;
#10 preset = 1;
read = 0;

#10 preset = 0;
#5 read = 1;
#10 data_tb = $random & 8'hff;
#10 {address,read,write} = {4'b0010,1'b0,1'b1};
#10 write = 0;

#10 data_tb = $random & 8'hff;
#10 {address,read,write} = {4'b0100,1'b0,1'b1};
#10 write = 0;

#10 {address,read,write} = {4'b0010,1'b1,1'b0};
#10 read = 0;

#10 {address,read,write} = {4'b0100,1'b1,1'b0};
#10 read = 0;

#10 data_tb = $random & 8'hff;
#10 {address,read,write} = {4'b0010,1'b1,1'b1};
#10 {read ,write} = 2'b0;

#10 reset = 0;
#10 reset = 1;
#10 {address,read,write} = {4'b0100,1'b1,1'b0};
#10 read = 0;

#10 data_tb = $random & 8'hff;
#10 {address,read,write} = {4'b0010,1'b1,1'b0};
#10 write = 1;

#20 $finish;


end
endmodule
