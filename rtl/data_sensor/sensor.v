module sensor
(
	input 		Clk,
	input 		Rst_n,
	input 		Sys_Start,
	output[7:0] Data,
	output		Data_Valid,
	input 		Rs232_Rx,
	output 		Rs232_Tx
);

parameter BAUD = 3'b010;	//心率血氧模块的波特率为38400

wire send_en;
wire [7:0]data_byte_send;
wire uart_state;
wire Tx_Done;

FSM FSM(
	.Clk			(Clk)			,
	.Rst_n			(Rst_n)			,
	.Sys_Start		(Sys_Start)		,		//启动按钮
	.send_en		(send_en)		,
	.data_byte_send	(data_byte_send)
);

uart_byte_tx uart_byte_tx_1(
	.Clk			(Clk)			,       				
	.Rst_n			(Rst_n)			,     				
	.data_byte		(data_byte_send), 	
	.send_en		(send_en)		,   			
	.baud_set		(BAUD)			,  				
	.Rs232_Tx		(Rs232_Tx)		,  		
	.Tx_Done		(Tx_Done)		,   					
	.uart_state		(uart_state) 					
);

uart_byte_rx uart_byte_rx_1(
	.Clk			(Clk)			,        				
	.Rst_n			(Rst_n)			,      		
	.baud_set		(BAUD)			,   		
	.Rs232_Rx		(Rs232_Rx)		,   			
	.data_byte		(Data)			,  	
	.Rx_Done		(Data_Valid)     			
);


endmodule