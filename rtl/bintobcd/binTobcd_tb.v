`timescale 1ns / 1ps

module binTobcd_tb();

reg 	[7:0]	BIN;
wire 	[11:0]	BCD;

wire [3:0]data1;
wire [3:0]data2;
wire [3:0]data3;

binTobcd binTobcd_inst 
( 
	.bin(BIN),
	.bcd(BCD) 
);

assign data1 = BCD[3:0];
assign data2 = BCD[7:4];
assign data3 = BCD[11:8];


integer i;
initial begin
	#200;
	for(i=0;i<256;i=i+1)
	begin
		BIN = i;
		#405;
	end
	$stop;

end





endmodule