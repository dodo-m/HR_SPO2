module gui(
    input                lcd_pclk,    //时钟
    input                rst_n,       //复位，低电平有效
	
	input                wavepoint,
	output reg   [10:0]	 Char_x,
	output reg   [10:0]	 Char_y,
	output reg   [6:0] 	 Char_n,
	input                Char_p,
	input                mod,
	input        [23:0]	 showbcd,
	
	
    input        [10:0]  pixel_xpos,  //当前像素点横坐标
    input        [10:0]  pixel_ypos,  //当前像素点纵坐标         
    output  reg  [23:0]  pixel_data   //像素数据
    );

//parameter define  
parameter WHITE = 24'hFFFFFF;  //白色
parameter BLACK = 24'h000000;  //黑色
parameter RED   = 24'hFF0000;  //红色
parameter GREEN = 24'h00FF00;  //绿色
parameter BLUE  = 24'h0000FF;  //蓝色
parameter CYAN  = 24'h00FFFF;  //浅蓝
parameter YELLOW  = 24'hFFFF00;  //黄色
parameter BX  = 24'hFFFFCD;  //白杏

localparam Hr_xbase = 11'd20;
localparam Hr_ybase = 11'd340;

localparam Sp_xbase = 11'd20;
localparam Sp_ybase = 11'd390;

wire [23:0]showbcd_r;
assign showbcd_r = (rst_n&&mod)? showbcd : 24'd0;
//根据当前像素点坐标指定当前像素点颜色数据，在屏幕上显示彩条
always @(posedge lcd_pclk or negedge rst_n) begin
    if(!rst_n)
        pixel_data <= BLACK;
    else begin
		if((pixel_xpos >= 11'd0)&&(pixel_xpos <11'd500)&&(pixel_ypos >= 11'd0)&&(pixel_ypos < 11'd256))
			begin
				if(wavepoint)
					pixel_data <= BLACK;
				else
					pixel_data <= RED;
			
			end
		else if((pixel_xpos >= 11'd20)&&(pixel_xpos <11'd84)&&(pixel_ypos >= 11'd257)&&(pixel_ypos < 11'd289))
			begin
				Char_n 	<= 7'd14;
				Char_x	<= pixel_xpos-11'd20;
				Char_y 	<= pixel_ypos-11'd257;
				if(Char_p)
					pixel_data <= WHITE;
				else
					pixel_data <= BLACK;
			end
		else if((pixel_xpos >= 11'd270)&&(pixel_xpos <11'd366)&&(pixel_ypos >= 11'd257)&&(pixel_ypos < 11'd289))
			begin
				if(mod)
					Char_n 	<= 7'd16;
				else
					Char_n 	<= 7'd15;
					
				Char_x	<= pixel_xpos-11'd270;
				Char_y 	<= pixel_ypos-11'd257;
				if(Char_p)
					pixel_data <= GREEN;
				else
					pixel_data <= BLACK;
			end			
		else if((pixel_xpos>=Hr_xbase)&&(pixel_xpos<(Hr_xbase+11'd48))&&(pixel_ypos>=Hr_ybase)&&(pixel_ypos<(Hr_ybase+11'd32)))
			begin
				Char_n 	<= 7'd11;//HR
				Char_x	<= pixel_xpos-Hr_xbase;
				Char_y 	<= pixel_ypos-Hr_ybase;
				if(Char_p)
					pixel_data <= WHITE;
				else
					pixel_data <= BLACK;
			end
		else if((pixel_xpos>=(Hr_xbase+11'd80))&&(pixel_xpos<(Hr_xbase+11'd96))&&(pixel_ypos>=Hr_ybase)&&(pixel_ypos<(Hr_ybase+11'd32)))
			begin
				Char_n 	<= showbcd_r[23:20];//百
				Char_x	<= pixel_xpos-(Hr_xbase+11'd80);
				Char_y 	<= pixel_ypos-Hr_ybase;
				if(Char_p)
					pixel_data <= CYAN;
				else
					pixel_data <= BLACK;
			end
		else if((pixel_xpos>=(Hr_xbase+11'd96))&&(pixel_xpos<(Hr_xbase+11'd112))&&(pixel_ypos>=Hr_ybase)&&(pixel_ypos<(Hr_ybase+11'd32)))
			begin
				Char_n 	<= showbcd_r[19:16];//十
				Char_x	<= pixel_xpos-(Hr_xbase+11'd96);
				Char_y 	<= pixel_ypos-Hr_ybase;
				if(Char_p)
					pixel_data <= CYAN;
				else
					pixel_data <= BLACK;
			end
		else if((pixel_xpos>=(Hr_xbase+11'd112))&&(pixel_xpos<(Hr_xbase+11'd128))&&(pixel_ypos>=Hr_ybase)&&(pixel_ypos<(Hr_ybase+11'd32)))
			begin
				Char_n 	<= showbcd_r[15:12];//个
				Char_x	<= pixel_xpos-(Hr_xbase+11'd112);
				Char_y 	<= pixel_ypos-Hr_ybase;
				if(Char_p)
					pixel_data <= CYAN;
				else
					pixel_data <= BLACK;
			end
		else if((pixel_xpos>=(Hr_xbase+11'd128))&&(pixel_xpos<(Hr_xbase+11'd192))&&(pixel_ypos>=Hr_ybase)&&(pixel_ypos<(Hr_ybase+11'd32)))
			begin
				Char_n 	<= 7'd13;//TPM
				Char_x	<= pixel_xpos-(Hr_xbase+11'd128);
				Char_y 	<= pixel_ypos-Hr_ybase;
				if(Char_p)
					pixel_data <= WHITE;
				else
					pixel_data <= BLACK;
			end
		else if((pixel_xpos>=Sp_xbase)&&(pixel_xpos<(Sp_xbase+11'd80))&&(pixel_ypos>=Sp_ybase)&&(pixel_ypos<(Sp_ybase+11'd32)))
			begin
				Char_n 	<= 7'd12;//spo2
				Char_x	<= pixel_xpos-Sp_xbase;
				Char_y 	<= pixel_ypos-Sp_ybase;
				if(Char_p)
					pixel_data <= WHITE;
				else
					pixel_data <= BLACK;
			end
		else if((pixel_xpos>=(Sp_xbase+11'd80))&&(pixel_xpos<(Sp_xbase+11'd96))&&(pixel_ypos>=Sp_ybase)&&(pixel_ypos<(Sp_ybase+11'd32)))
			begin
				Char_n 	<= showbcd_r[11:8];//百
				Char_x	<= pixel_xpos-(Sp_xbase+11'd64);
				Char_y 	<= pixel_ypos-Sp_ybase;
				if(Char_p)
					pixel_data <= CYAN;
				else
					pixel_data <= BLACK;
			end
		else if((pixel_xpos>=(Sp_xbase+11'd96))&&(pixel_xpos<(Sp_xbase+11'd112))&&(pixel_ypos>=Sp_ybase)&&(pixel_ypos<(Sp_ybase+11'd32)))
			begin
				Char_n 	<= showbcd_r[7:4];//十
				Char_x	<= pixel_xpos-(Sp_xbase+11'd80);
				Char_y 	<= pixel_ypos-Sp_ybase;
				if(Char_p)
					pixel_data <= CYAN;
				else
					pixel_data <= BLACK;
			end
		else if((pixel_xpos>=(Sp_xbase+11'd112))&&(pixel_xpos<(Sp_xbase+11'd128))&&(pixel_ypos>=Sp_ybase)&&(pixel_ypos<(Sp_ybase+11'd32)))
			begin
				Char_n 	<= showbcd_r[3:0];//个
				Char_x	<= pixel_xpos-(Sp_xbase+11'd96);
				Char_y 	<= pixel_ypos-Sp_ybase;
				if(Char_p)
					pixel_data <= CYAN;
				else
					pixel_data <= BLACK;
			end
		else if((pixel_xpos>=(Sp_xbase+11'd128))&&(pixel_xpos<(Sp_xbase+11'd144))&&(pixel_ypos>=Sp_ybase)&&(pixel_ypos<(Sp_ybase+11'd32)))
			begin
				Char_n 	<= 7'd10;//%
				Char_x	<= pixel_xpos-(Sp_xbase+11'd112);
				Char_y 	<= pixel_ypos-Sp_ybase;
				if(Char_p)
					pixel_data <= CYAN;
				else
					pixel_data <= BLACK;
			end
/*		
		else if((pixel_xpos>=11'd564)&&(pixel_xpos<11'd692)&&(pixel_ypos>=11'd64)&&(pixel_ypos<11'd192))
			begin
				Char_n 	<= 7'd17;//lnu
				Char_x	<= pixel_xpos-11'd564;
				Char_y 	<= pixel_ypos-11'd64;
				if(Char_p)
					pixel_data <= YELLOW;
				else
					pixel_data <= BLACK;
			end
			
		else if((pixel_xpos>=11'd520)&&(pixel_xpos<11'd696)&&(pixel_ypos>=11'd300)&&(pixel_ypos<11'd316))
			begin
				Char_n 	<= 7'd18;//depart
				Char_x	<= pixel_xpos-11'd520;
				Char_y 	<= pixel_ypos-11'd300;
				if(Char_p)
					pixel_data <= BX;
				else
					pixel_data <= BLACK;
			end

		else if((pixel_xpos>=11'd520)&&(pixel_xpos<11'd672)&&(pixel_ypos>=11'd360)&&(pixel_ypos<11'd376))
			begin
				Char_n 	<= 7'd19;//author
				Char_x	<= pixel_xpos-11'd520;
				Char_y 	<= pixel_ypos-11'd360;
				if(Char_p)
					pixel_data <= BX;
				else
					pixel_data <= BLACK;
			end
			
		else if((pixel_xpos>=11'd520)&&(pixel_xpos<11'd648)&&(pixel_ypos>=11'd420)&&(pixel_ypos<11'd436))
			begin
				Char_n 	<= 7'd20;//ymd
				Char_x	<= pixel_xpos-11'd520;
				Char_y 	<= pixel_ypos-11'd420;
				if(Char_p)
					pixel_data <= BX;
				else
					pixel_data <= BLACK;
			end
*/				
		else if(pixel_xpos==11'd249&&pixel_ypos>256&&pixel_ypos<289) pixel_data <= CYAN;
		else if(pixel_xpos==11'd500)	pixel_data <= CYAN;
		else if(pixel_ypos==11'd256)    pixel_data <= CYAN;
		else if(pixel_ypos==11'd289)	pixel_data <= CYAN;
		else	pixel_data <= BLACK;
    end    
end
  
endmodule
