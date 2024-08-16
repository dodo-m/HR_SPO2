module m_filter
(
	input 			Clk,
	input 			Rst_n,
	input 	[7:0]	ida,
	input 			iflag,
	output	[7:0]	oda,
	output 			oflag

);

reg [7:0]array[0:2];
reg [8:0]oda_r;
always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		oda_r 	<= 9'd0;
	end else
	begin
		if(iflag)begin
			array[0] <= ida;
			array[1] <= array[0];
			array[2] <= array[1];
			oda_r <= (array[0]*7+array[1]*2+array[2])/10;
		end	else
		begin
			array[0] <= array[0];
			array[1] <= array[1];
			array[2] <= array[2];
		end
		
	end
assign oflag = iflag;

assign oda = oda_r[8:1]+8'd128;

endmodule 