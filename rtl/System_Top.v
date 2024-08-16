module System_Top
(
	input Clk,
	input Rst_n,
//按键
	input key_in,
	output led0,
	input key_in2,
	output led1,
	
	input wifi_key1,
	input wifi_key2,
//语音播放
	input Busy,
	output PA5,
	output PA4,
	output PA3,
	output PA2,
	output PA1,
//蜂鸣器
	output beep,
//串口
	input Rs232_Rx,
	output Rs232_Tx,
	output Rs232_Tx_Serial,
//屏幕
    output               lcd_de,     	//LCD 数据使能信号
    output               lcd_hs,      	//LCD 行同步信号
    output               lcd_vs,      	//LCD 场同步信号
    output               lcd_clk,    	//LCD 像素时钟
    inout        [23:0]  lcd_rgb,     	//LCD RGB888颜色数据
    output               lcd_rst,
    output               lcd_bl
);

wire start;
wire [7:0]data_sensor;
wire data_flag;

wire proc_flag1;
wire [7:0]proc_data1;
wire proc_flag2;
wire [7:0]proc_data2;
wire proc_flag3;
wire [7:0]proc_data3;

wire [23:0]show_bcd;
wire [7:0]show_wave;


wire [23:0]pixel_data;
wire [10:0]pixel_xpos;
wire [10:0]pixel_ypos;
wire lcd_pclko;

wire wavepoint;
wire [10:0]Char_x;
wire [10:0]Char_y;
wire [6:0] Char_n;
wire Char_p;


wire pass;
wire [7:0]odata;
wire o_flag;

wire ckey1;
wire ckey2;

wire [4:0]Cpin;
wire beep_nk;

assign PA5 = Cpin[4];
assign PA4 = Cpin[3];
assign PA3 = Cpin[2];
assign PA2 = Cpin[1];
assign PA1 = Cpin[0];

Key Key_1
(
.Clk	(Clk)	,
.Rst_n	(Rst_n)	,
.Key	(key_in),
.Key_Out(ckey1)
);
assign start = ckey1||wifi_key1;
assign led0 = ckey1||wifi_key1;	//指示灯

Key Key_2
(
.Clk	(Clk)		,
.Rst_n	(Rst_n)		,
.Key	(key_in2)	,
.Key_Out(ckey2)
);
assign pass = ckey2||wifi_key2;
assign led1 = ckey2||wifi_key2;	//指示灯
assign beep = beep_nk&&start;
sensor sensor_inst
(
.Clk			(Clk)			,
.Rst_n			(Rst_n)			,
.Sys_Start		(start)			,
.Data			(data_sensor)	,
.Data_Valid		(data_flag)		,
.Rs232_Rx		(Rs232_Rx)		,
.Rs232_Tx       (Rs232_Tx)
);

dataram dataram
(
.Clk			(Clk)			,
.Rst_n			(Rst_n)			,
.idata			(data_sensor)	,
.idata_valid	(data_flag)		,

.proc_data1		(proc_data1)	,		//心电波形
.proc_flag1		(proc_flag1)	,

.proc_data2		(proc_data2)	,		//心率
.proc_flag2		(proc_flag2)	,

.proc_data3		(proc_data3)	,		//血氧饱和度
.proc_flag3		(proc_flag3)	,

.show_bcd		(show_bcd)		,		//用于屏幕显示
.show_wave		(show_wave)
);

serial serial
(
.Clk			(Clk)			,
.Rst_n			(Rst_n)			,
.send_en		(data_flag)		,
.data_send		(data_sensor)	,
.Rs232_Tx       (Rs232_Tx_Serial)
);              




Read Read
(
.Clk	(Clk)			,
.Rst_n	(Rst_n)			,
.Flag	(proc_flag3)	,
.Busy	(Busy)			,
.Audio	(show_bcd)		,
.Cpin   (Cpin)
);


fir_top fir_top
(
.Clk		(Clk)		,
.Rst_n		(Rst_n)		,
.pass		(1'b0)		,
.idata		(proc_data1),
.i_flag		(proc_flag1),
.odata		(odata)		,
.o_flag     (o_flag)
);


drawwave drawwave
(
.Clk		(Clk)			,
.Rst_n		(Rst_n)			,
.wave_data	(odata)			,
.wave_flag	(o_flag)  		,
.nofresh	(!start)		,
.stop		(pass)			,
.hcount		(pixel_xpos)	,	
.vcount		(pixel_ypos)	,
.wavepoint	(wavepoint)
);

/*
belldrive belldrive
(
.clk		(Clk)		,
.trig		(proc_flag2), 
.beep       (beep)
);
*/

Beep Beep
(
.Clk		(Clk)			,
.Rst_n		(Rst_n)			,
.En			(proc_flag3)	,
.beep		(beep_nk)
);


gui gui
(
.lcd_pclk	(lcd_pclko)		,   
.rst_n		(Rst_n)			, 
.wavepoint  (wavepoint)		, 
.Char_x		(Char_x)		,
.Char_y		(Char_y)		,
.Char_n		(Char_n)		,
.Char_p		(Char_p)		,
.mod		(start)			,
.showbcd	(show_bcd)		,    
.pixel_xpos	(pixel_xpos)	,  
.pixel_ypos	(pixel_ypos)	,          
.pixel_data (pixel_data)  
);
Char Char
(
.Clk   (Clk   ),
.Char_n(Char_n),
.Char_x(Char_x),
.Char_y(Char_y),
.Char_p(Char_p)
);

lcd lcd
(
.sys_clk		(Clk)			,     	//系统时钟
.sys_rst_n		(Rst_n)			,   	//系统复位			
										//软件交互
.pixel_data		(pixel_data)	,  		//像素数据
.pixel_xpos		(pixel_xpos)	,  		//当前像素点横坐标
.pixel_ypos		(pixel_ypos)	,  		//当前像素点纵坐标
.lcd_pclko		(lcd_pclko)		,		
										//硬件交互
.lcd_de			(lcd_de)		,     	//LCD 数据使能信号
.lcd_hs			(lcd_hs)		,      	//LCD 行同步信号
.lcd_vs			(lcd_vs)		,      	//LCD 场同步信号
.lcd_clk		(lcd_clk)		,    	//LCD 像素时钟
.lcd_rgb		(lcd_rgb)		,     	//LCD RGB888颜色数据
.lcd_rst		(lcd_rst)		,
.lcd_bl			(lcd_bl)
);

endmodule