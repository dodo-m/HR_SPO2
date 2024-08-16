module lcd
(
	input                sys_clk,     	//系统时钟
    input                sys_rst_n,   	//系统复位
										//软件交互
	input        [23:0]  pixel_data,  	//像素数据
    output       [10:0]  pixel_xpos,  	//当前像素点横坐标
    output       [10:0]  pixel_ypos,  	//当前像素点纵坐标
	output               lcd_pclko,
	
										//硬件交互
    output               lcd_de,     	//LCD 数据使能信号
    output               lcd_hs,      	//LCD 行同步信号
    output               lcd_vs,      	//LCD 场同步信号
    output               lcd_clk,    	//LCD 像素时钟
    inout        [23:0]  lcd_rgb,     	//LCD RGB888颜色数据
    output               lcd_rst,
    output               lcd_bl
);



wire  [15:0]  lcd_id    ;    //LCD屏ID
wire          lcd_pclk  ;    //LCD像素时钟         

wire  [10:0]  h_disp    ;    //LCD屏水平分辨率
wire  [10:0]  v_disp    ;    //LCD屏垂直分辨率


wire  [23:0]  lcd_rgb_o ;    //输出的像素数据



//像素数据方向切换
assign lcd_rgb = lcd_de ?  lcd_rgb_o :  {24{1'bz}};

assign lcd_id  = 16'h4384; 
assign lcd_pclko = lcd_pclk; 

//时钟分频模块    
clk_div u_clk_div(
    .clk           (sys_clk  ),
    .rst_n         (sys_rst_n),
    .lcd_id        (lcd_id   ),
    .lcd_pclk      (lcd_pclk )
    );       

//LCD驱动模块
lcd_driver u_lcd_driver(
    .lcd_pclk      (lcd_pclk  ),
    .rst_n         (sys_rst_n ),
    .lcd_id        (lcd_id    ),
	
    .pixel_data    (pixel_data),
    .pixel_xpos    (pixel_xpos),
    .pixel_ypos    (pixel_ypos),
	
    .h_disp        (h_disp    ),	//屏幕尺寸800X480
    .v_disp        (v_disp    ),

    .lcd_de        (lcd_de    ),
    .lcd_hs        (lcd_hs    ),
    .lcd_vs        (lcd_vs    ),   
    .lcd_clk       (lcd_clk   ),
    .lcd_rgb       (lcd_rgb_o ),
    .lcd_rst       (lcd_rst   ),
    .lcd_bl        (lcd_bl)
    );
endmodule