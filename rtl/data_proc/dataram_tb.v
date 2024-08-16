`timescale 1ns/1ns

`define clk_period 20

module dataram_tb();

	reg clock,rst;
	reg [7:0]data;
	reg [7:0]rdaddress;
	reg wren;
	
	wire [7:0]q;
	wire fflag;
	
	integer i;
	
	dataram dataram
	(
	.Clk			(clock)			,
	.Rst_n			(rst)			,
	.idata			(data)			,
	.idata_valid	(wren)			,
	.raddr			(rdaddress)		,
	.proc_data		(q)				,
	.fflag          (fflag)	
	);
	
	initial clock = 1;
	always#(`clk_period/2)clock = ~clock;
	

	
	initial begin
		data = 0;
		rdaddress = 0;
		wren = 0;
		rst  = 1;
		#(`clk_period*20 +1 );
		for (i=0;i<=80;i=i+1)begin
			wren = 1;
			data = 255 - i;
			#`clk_period;
			wren = 0;
			#50;
		end
		wren = 0;
		
		#(`clk_period*20);
		for (i=0;i<=80;i=i+1)begin
			rdaddress = i;
			#`clk_period;
		end
		#(`clk_period*20);
		$stop;	
	end

endmodule
