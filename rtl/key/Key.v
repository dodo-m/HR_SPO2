module Key(
	Clk,Rst_n,
	Key,
	Key_Out
);
	input 	Clk,Rst_n;
	input 	Key;
	output 	reg Key_Out;
	
	

wire key_state,key_flag;

key_filter key_filter_1(
			.Clk(Clk),      //50M时钟输入
			.Rst_n(Rst_n),    //模块复位
			.key_in(Key),   //按键输入
			.key_flag(key_flag), //按键标志信号
			.key_state(key_state) //按键状态信号
		);
			
always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Key_Out <= 1'b0;
	else if(key_flag&&!key_state)
			Key_Out <= !Key_Out;
		else 
			Key_Out <= Key_Out;
endmodule