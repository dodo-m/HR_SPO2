/***************************************************
*	Module Name		:	filter_32		   
*	Engineer		   :	杨绪刚
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2019-4-18
*	Revision		   :	v1.1
*	Description		:  //FIR低通滤波
**************************************************/
module filter_32(
	clk,
	rest_n,
	adc_data,
	filter_data
);
	input clk;
	input rest_n;
	input [11:0]adc_data;
	output reg signed[21:0]filter_data;
	
	reg [11:0] order[0:31];
	always@(posedge clk or negedge rest_n)
		if(!rest_n)begin
			 order[0]  <= 12'b0;
			 order[1]  <= 12'b0;
			 order[2]  <= 12'b0;
			 order[3]  <= 12'b0;
			 order[4]  <= 12'b0;
			 order[4]  <= 12'b0;
			 order[5]  <= 12'b0;
			 order[6]  <= 12'b0;
			 order[7]  <= 12'b0;
			 order[8]  <= 12'b0;
			 order[9]  <= 12'b0;
			 order[10] <= 12'b0;
			 order[11] <= 12'b0;
			 order[12] <= 12'b0;
			 order[13] <= 12'b0;
			 order[14] <= 12'b0;
			 order[15] <= 12'b0;
			 order[16] <= 12'b0;
			 order[17] <= 12'b0;
			 order[18] <= 12'b0;
			 order[19] <= 12'b0;
			 order[20] <= 12'b0;
			 order[21] <= 12'b0;
			 order[22] <= 12'b0;
			 order[23] <= 12'b0;
			 order[24] <= 12'b0;
			 order[25] <= 12'b0;
			 order[26] <= 12'b0;
			 order[27] <= 12'b0;
			 order[28] <= 12'b0;
			 order[29] <= 12'b0;
			 order[30] <= 12'b0;
			 order[31] <= 12'b0;
		end
		else begin
			order[0 ] <= adc_data  ;//延时一个采样周期
			order[1 ] <= order[0]  ;
			order[2 ] <= order[1]  ;
			order[3 ] <= order[2]  ;
			order[4 ] <= order[3]  ;
			order[5 ] <= order[4]  ;
			order[6 ] <= order[5]  ;
			order[7 ] <= order[6]  ;
			order[8 ] <= order[7]  ;
			order[9 ] <= order[8]  ;
			order[10] <= order[9]  ;
			order[11] <= order[10] ;
			order[12] <= order[11] ;
			order[13] <= order[12] ;
			order[14] <= order[13] ;
			order[15] <= order[14] ;
			order[16] <= order[15] ;
			order[17] <= order[16] ;
			order[18] <= order[17] ;
			order[19] <= order[18] ;
			order[20] <= order[19] ;
			order[21] <= order[20] ;
			order[22] <= order[21] ;
			order[23] <= order[22] ;
			order[24] <= order[23] ;
			order[25] <= order[24] ;
			order[26] <= order[25] ;
			order[27] <= order[26] ;
			order[28] <= order[27] ;
			order[29] <= order[28] ;
			order[30] <= order[29] ;
			order[31] <= order[30] ;
		end
	wire [7:0] hx_0_31  = 8'd42 ;//8'd0;	//滤波器系数
	wire [7:0] hx_1_30  = 8'd41 ;//8'd1;
	wire [7:0] hx_2_29  = 8'd43 ;//8'd1;
	wire [7:0] hx_3_28  = 8'd49 ;//8'd3;
	wire [7:0] hx_4_27  = 8'd54 ;//8'd6;
	wire [7:0] hx_5_26  = 8'd51 ;//8'd10;
	wire [7:0] hx_6_25  = 8'd37 ;//8'd15;
	wire [7:0] hx_7_24  = 8'd29 ;//8'd22;
	wire [7:0] hx_8_23  = 8'd40 ;//8'd31;
	wire [7:0] hx_9_22  = 8'd60 ;//8'd40;
	wire [7:0] hx_10_21 = 8'd59 ;//8'd51;
	wire [7:0] hx_11_20 = 8'd26 ;//8'd61;
	wire [7:0] hx_12_19 = 8'd0  ;//8'd70;
	wire [7:0] hx_13_18 = 8'd38 ;//8'd78;
	wire [7:0] hx_14_17 = 8'd143;//8'd84;
	wire [7:0] hx_15_16 = 8'd236;//8'd87;


	reg signed[21:0] M_0_31;//乘积
	reg signed[21:0] M_1_30;
	reg signed[21:0] M_2_29;
	reg signed[21:0] M_3_28;
	reg signed[21:0] M_4_27;
	reg signed[21:0] M_5_26;
	reg signed[21:0] M_6_25;
	reg signed[21:0] M_7_24;
	reg signed[21:0] M_8_23;
	reg signed[21:0] M_9_22;
	reg signed[21:0] M_10_21;
	reg signed[21:0] M_11_20;
	reg signed[21:0] M_12_19;
	reg signed[21:0] M_13_18;
	reg signed[21:0] M_14_17;
	reg signed[21:0] M_15_16;
	
	always@(posedge clk or negedge rest_n)
	if(!rest_n)begin
		M_0_31 <= 22'b0;
		M_1_30 <= 22'b0;
		M_2_29 <= 22'b0;
		M_3_28 <= 22'b0;
		M_4_27 <= 22'b0;
		M_5_26 <= 22'b0;
		M_6_25 <= 22'b0;
		M_7_24 <= 22'b0;
		M_8_23 <= 22'b0;
		M_9_22 <= 22'b0;
		M_10_21<= 22'b0;
		M_11_20<= 22'b0;
		M_12_19<= 22'b0;
		M_13_18<= 22'b0;
		M_14_17<= 22'b0;
		M_15_16<= 22'b0;
	end             
	else begin
		M_0_31  <= hx_0_31  * (order[0 ] + order[16]);
		M_1_30  <= hx_1_30  * (order[1 ] + order[17]);
		M_2_29  <= hx_2_29  * (order[2 ] + order[18]);
		M_3_28  <= hx_3_28  * (order[3 ] + order[19]);
		M_4_27  <= hx_4_27  * (order[4 ] + order[20]);
		M_5_26  <= hx_5_26  * (order[5 ] + order[21]);
		M_6_25  <= hx_6_25  * (order[6 ] + order[22]);
		M_7_24  <= hx_7_24  * (order[7 ] + order[23]);
		M_8_23  <= hx_8_23  * (order[8 ] + order[24]);
		M_9_22  <= hx_9_22  * (order[9 ] + order[25]);
		M_10_21 <= hx_10_21 * (order[10] + order[26]);
		M_11_20 <= hx_11_20 * (order[11] + order[27]);
		M_12_19 <= hx_12_19 * (order[12] + order[28]);
		M_13_18 <= hx_13_18 * (order[13] + order[29]);
		M_14_17 <= hx_14_17 * (order[14] + order[30]);
      M_15_16 <= hx_15_16 * (order[15] + order[31]);
	end
	//always@(posedge clk or negedge rest_n)
	//if(!rest_n)	M_0_31 <= 22'b0;
	//else			M_0_31  <= hx_0_31  * (order[0 ] + order[31]);
	//always@(posedge clk or negedge rest_n)
	//if(!rest_n)	M_1_30 <= 22'b0;
	//else			M_1_30  <= hx_1_30  * (order[1 ] + order[30]);
	//always@(posedge clk or negedge rest_n)
	//if(!rest_n)	M_2_29 <= 22'b0;
	//else			M_2_29  <= hx_2_29  * (order[2 ] + order[29]);
	//always@(posedge clk or negedge rest_n)
	//if(!rest_n)	M_3_28 <= 22'b0;
	//else			M_3_28  <= hx_3_28  * (order[3 ] + order[28]);
	//always@(posedge clk or negedge rest_n)
	//if(!rest_n)	M_4_27 <= 22'b0;
	//else			M_4_27  <= hx_4_27  * (order[4 ] + order[27]);
	//always@(posedge clk or negedge rest_n)
	//if(!rest_n)	M_5_26 <= 22'b0;
	//else			M_5_26  <= hx_5_26  * (order[5 ] + order[26]);
	//always@(posedge clk or negedge rest_n)
	//if(!rest_n)	M_6_25 <= 22'b0;
	//else			M_6_25  <= hx_6_25  * (order[6 ] + order[25]);
	//always@(posedge clk or negedge rest_n)
	//if(!rest_n)	M_7_24 <= 22'b0;
	//else			M_7_24  <= hx_7_24  * (order[7 ] + order[24]);
	//always@(posedge clk or negedge rest_n)
	//if(!rest_n)	M_8_23 <= 22'b0;
	//else			M_8_23  <= hx_8_23  * (order[8 ] + order[23]);
	//always@(posedge clk or negedge rest_n)
	//if(!rest_n)	M_9_22 <= 22'b0;
	//else			M_9_22  <= hx_9_22  * (order[9 ] + order[22]);
	//always@(posedge clk or negedge rest_n)
	//if(!rest_n)	M_10_21 <= 22'b0;
	//else			M_10_21  <= hx_10_21  * (order[10 ] + order[21]);
	//always@(posedge clk or negedge rest_n)
	//if(!rest_n)	M_11_20 <= 22'b0;
	//else			M_11_20  <= hx_11_20  * (order[11 ] + order[20]);
	//always@(posedge clk or negedge rest_n)
	//if(!rest_n)	M_12_19 <= 22'b0;
	//else			M_12_19  <= hx_12_19  * (order[12 ] + order[19]);
	//always@(posedge clk or negedge rest_n)
	//if(!rest_n)	M_13_18 <= 22'b0;
	//else			M_13_18  <= hx_13_18  * (order[13 ] + order[18]);
	//always@(posedge clk or negedge rest_n)
	//if(!rest_n)	M_14_17 <= 22'b0;
	//else			M_14_17  <= hx_14_17  * (order[14 ] + order[17]);
	//always@(posedge clk or negedge rest_n)
	//if(!rest_n)	M_15_16 <= 22'b0;
	//else			M_15_16  <= hx_15_16  * (order[15 ] + order[16]);
		
	always@(posedge clk or negedge rest_n)
	if(!rest_n)
		filter_data <= 22'b0;
	else
		filter_data <= M_0_31 + M_1_30 + M_2_29 + M_3_28 +M_4_27 + M_5_26 + M_6_25 + M_7_24 + M_8_23 + M_9_22 + M_10_21 + M_11_20 + M_12_19 + M_13_18 + M_14_17 + M_15_16;
endmodule