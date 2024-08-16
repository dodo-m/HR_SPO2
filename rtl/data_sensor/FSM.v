module FSM(
	Clk,Rst_n,
	Sys_Start,
	send_en,
	data_byte_send
);
	input Clk,Rst_n,Sys_Start;
	output reg send_en;
	output reg [7:0]data_byte_send;



localparam 	Work_Start 	= 8'h8A,
			Work_Stop  	= 8'h88;
			
reg [2:0]Right_State;
localparam	S0 = 3'b001,
			S1 = 3'b010,
			S2 = 3'b100;


always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)begin
		Right_State <= S0;
	end
	else begin
		case(Right_State)
			S0:begin
				if(Sys_Start==1'b1)begin
					data_byte_send 	<= Work_Start;
					send_en 		<= 1'b1;
					Right_State 	<= S1;		
				end else begin
					data_byte_send 	<= Work_Stop;
					send_en 		<= 1'b1;
					Right_State <= S2;
				end
			end
			S1:begin
				if(Sys_Start==1'b1)begin
					send_en <= 1'b0;
					Right_State <= S1;
				end else begin
					Right_State <= S0;
				end
			end
			S2:begin
				if(Sys_Start==1'b1)begin
					Right_State <= S0;
				end else begin
					send_en <= 1'b0;
					Right_State <= S2;
				end
			end

		endcase
	end

endmodule