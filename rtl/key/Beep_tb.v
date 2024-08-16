`timescale 1ns/1ps
`define clk_period 20

module Beep_tb();

reg Clk,Rst_n,En;
wire beep;

Beep Beep
(
.Clk		(Clk)	,
.Rst_n		(Rst_n)	,
.En			(En)	,
.beep       (beep)

);


initial Clk = 1'b0;
always #(`clk_period/2)	Clk = ~Clk;

initial begin

	Rst_n 	= 1'b0;
	En 		= 1'b0;
	#200;
	Rst_n	= 1'b1;
	En		= 1'b1;
	#20;
	En		= 1'b0;
	#26_000_000;
	En 		= 1'b1;
	#20;
	En      = 1'b0;
	#2_000_000;
	En		= 1'b1;
	#20;
	En   	= 1'b0;
	#25_000_000;
	$stop;

end




endmodule

