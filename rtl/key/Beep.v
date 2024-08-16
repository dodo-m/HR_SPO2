module Beep
(
	input 		Clk		,
	input 		Rst_n	,
	input       En		,
	output      reg beep
	
);


reg [31:0]delay;	
	
always@(posedge Clk or negedge Rst_n)	
	if(!Rst_n)begin
		beep <= 1'b0;
		delay <= 8'd0;
	end
	else if(En)begin
		delay <= 8'd5_000_000;
	end else begin
		if(delay>8'd0)begin
			delay <= delay-1'b1;
			beep  <= 1'b1;
		end
		else beep <= 1'b0;
			
	end

	

endmodule 