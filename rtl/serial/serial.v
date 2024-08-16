module serial
(
	input Clk,
	input Rst_n,
	input send_en,
	input [7:0]data_send,
	output Rs232_Tx
	
);

parameter Baud_Serial = 3'b010;
wire Tx_Done,uart_state;

uart_byte_tx uart_byte_tx_2(
	.Clk				(Clk)			,       				
	.Rst_n				(Rst_n)			,     				
	.data_byte			(data_send)		, 		
	.send_en			(send_en)		,   			
	.baud_set			(Baud_Serial)	,  			
	.Rs232_Tx			(Rs232_Tx)		,  		
	.Tx_Done			(Tx_Done)		,   				 
	.uart_state			(uart_state) 				
);

endmodule 