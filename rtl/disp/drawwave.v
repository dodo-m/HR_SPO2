module drawwave
(
	input Clk,
	input Rst_n,
	input [7:0]wave_data,
	input wave_flag,
	input nofresh,
	input stop,
	input [10:0]  hcount,
	input [10:0]  vcount,
	
	//output ecgstate,
	output reg wavepoint
	
);
reg [10:0]axis;
reg [31:0]i_flag;
reg flag;

reg [7:0]wave[0:499];

//波形算法
reg [7:0]wavehleft;
reg [7:0]wavehright;
reg [7:0]waveh;
reg [10:0]midleft;
reg [10:0]midright;
reg [10:0]sum;
reg [10:0]div;

wire empty_sig,full_sig;
wire [7:0]q_sig;


fifo	fifo_inst 
(
.clock 	(Clk)					,
.data 	(wave_data)				,
.rdreq 	(flag&&(!empty_sig))	,
.wrreq 	(wave_flag&&(!full_sig)),
.empty 	(empty_sig)				,
.full 	(full_sig)				,
.q 		(q_sig)
);


always@(posedge Clk or negedge Rst_n)
begin
	if(!Rst_n)begin
		i_flag <= 32'd0;
		flag   <= 1'b0;
	end else begin
		if(i_flag==32'd1299999)begin
			i_flag <= 32'd0;
			flag   <= 1'b1;
		end else begin
			i_flag <= i_flag + 1'b1;
			flag   <= 1'b0;
		end
	end
end
		

always@(posedge Clk or negedge Rst_n)
begin
	if(!Rst_n)begin
		axis <= 11'd0;
	end
	else begin if(stop)	 axis <= axis; else begin
			if(flag)begin
				if(axis == 11'd499)
					axis <= 11'd0;
				else 
					axis <= axis + 1'b1;
			end else
				axis <= axis;
		end
	end
end

always@(posedge Clk)
begin
	if(nofresh)
		wave[axis] <= wave[axis];
	else begin
		if(flag&&!empty_sig)
			wave[axis] <= q_sig;
		else
			wave[axis] <= wave[axis];
	end
	
end


//图形处理
always@(posedge Clk)
begin 
	if(hcount <= 11'd499 && vcount <= 11'd255)begin
		sum = hcount+axis;
		if(sum > 11'd499)
			div = sum - 11'd499;
		else	div = sum;	
	end else
		div = sum;
end
	
always@(posedge Clk)
begin 
	if(div !=11'd0 || div!=11'd499)begin
	wavehleft = wave[div-11'd1];
	wavehright = wave[div+11'd1];
	end
	waveh = wave[div];
	midleft  = (waveh + wavehleft)/11'd2;
	midright = (waveh + wavehright)/11'd2;
	
end

	always@(*)
begin 	
	if((midleft >= vcount && vcount >= midright)//连续波形
		||(midleft <= vcount && vcount <= midright)
		||(midleft <= vcount && vcount >= midright && vcount <= waveh)
		||(midleft >= vcount && vcount >= midright && vcount >= waveh))
		wavepoint = 1'b0;		
	else
		wavepoint = 1'b1;
end


//assign ecgstate = flag&&(!nofresh);

endmodule 