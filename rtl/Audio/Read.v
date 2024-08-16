module Read
(
	input Clk,
	input Rst_n,
	input Flag,
	input Busy,
	input [23:0]Audio,
	output reg [4:0]Cpin
);

localparam None = 5'b01000;	//23
localparam HR 	= 5'b01010;	//心率提示词21
localparam SPO2 = 5'b01001;	//血氧提示词22
localparam Hund = 5'b01011;	//20-100

reg [7:0]State;


always@(posedge Clk or negedge Rst_n)	
	if(!Rst_n)begin
		Cpin <= None;	//选择没有语音的状态
		State <= 8'd0;
	end
	else begin
		case(State)
		0:begin
			if(Flag)begin
				Cpin <= HR;	//心率提示词
				State <= 8'd1;
			end else begin
				State <= 8'd0;
			end
			
		end
		1:begin
			if(Busy)begin
				State<= 8'd1;
			end else begin
				if(Audio[23:20])begin
					Cpin <= Hund;	//一百
					State <= 8'd2;
				end else begin
					Cpin <= None;
					State <= 8'd2;
				end
			end
		end
		2:begin
			if(Busy)begin
				State<= 8'd2;
			end	else begin
				if(Audio[19:12])begin
					Cpin <= xlv_h;
					State <= 8'd3;
				end else begin
					Cpin <= None;
					State <= 8'd4;//进入血氧数据
				end
			end
		end
		3:begin
			if(Busy)begin
				State<= 8'd3;
			end	else begin
				Cpin <= xlv_l;
				State <= 8'd4;
			end
		end		
		4:begin
			if(Busy)begin
				State<= 8'd4;
			end	else begin
				Cpin <= SPO2;//血氧提示词
				State <= 8'd5;
			end
		end			
		5:begin
			if(Busy)begin
				State<= 8'd5;
			end else begin
				if(Audio[11:8])begin
					Cpin <= Hund;
					State <= 8'd6;
				end else begin
					Cpin <= None;
					State <= 8'd6;
				end
			end
		end	
		6:begin
			if(Busy)begin
				State<= 8'd6;
			end	else begin
				if(Audio[7:0])begin
					Cpin <= xlv_h;
					State <= 8'd7;
				end else begin
					Cpin <= None;
					State <= 8'd0;
				end
			end
		end
		7:begin
			if(Busy)begin
				State<= 8'd7;
			end	else begin
				Cpin <= xlv_l;
				State <= 8'd0;
			end
		end		
		endcase
		
	end

wire [4:0]xlv_h;
wire [4:0]xlv_l;

wire [4:0]xya_h;
wire [4:0]xya_l;

//心率十位
Encoder 
#(
  .mod(1'b0) 
)
inst1
(
.num	(Audio[19:16]),
.code   (xlv_h)
);

//心率个位
Encoder 
#(
  .mod(1'b1) 
)
inst2
(
.num	(Audio[15:12]),
.code   (xlv_l)
);


//血氧十位
Encoder 
#(
  .mod(1'b0) 
)
inst3
(
.num	(Audio[7:4]),
.code   (xya_h)
);

//血氧个位
Encoder 
#(
  .mod(1'b1) 
)
inst4
(
.num	(Audio[3:0]),
.code   (xya_l)
);



endmodule