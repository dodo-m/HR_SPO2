
/***************************************************
*	Module Name		:	mid_filter		   
*	Engineer		   :	杨绪刚
*	Target Device	:	EP4CE10F17C8
*	Tool versions	:	Quartus II 13.0
*	Create Date		:	2019-4-15
*	Revision		   :	v1.1
*	Description		:  //75阶中值滤波
**************************************************/

module mid_filter(
	input clk,
	input data_clk,
	input rest_n,
	input [0:7]data,
	output reg [0:7]mid_data_out//输出中值
);

reg [0:7]array[0:74];//缓存序列
reg [0:7]array_data;
reg [0:7]count_sequence;//序列号
reg [0:7]count_bit;	//判断第count_sequence个数据的第count_bit位0，1
reg [0:7]num_0[0:74] ;reg [0:7]num_1[0:74];	//0，1的数量统计
reg [0:7]add_L; reg [0:7]add_R; //中值两边的数量统计
reg f_start;
reg [0:7]mid_data;
parameter [0:7]count_half = 38;	//中值的顺序位置

reg btn1,btn2,data_clkPg;
always@(posedge clk)
begin 
	btn1 <= data_clk;
	btn2 <= btn1;
	data_clkPg <= btn1 & ~btn2;//data_clk posedge
end

always@(posedge clk)
	begin
		if(!rest_n)
			begin
				array[0 ] <= 0;
				array[1 ] <= 0;
				array[2 ] <= 0;
				array[3 ] <= 0;
				array[4 ] <= 0;
				array[5 ] <= 0;
				array[6 ] <= 0;
				array[7 ] <= 0;
				array[8 ] <= 0;
				array[9 ] <= 0;
				array[10] <= 0;
				array[11] <= 0;
				array[12] <= 0;
				array[13] <= 0;
				array[14] <= 0;
				array[15] <= 0;
				array[16] <= 0;
				array[17] <= 0;
				array[18] <= 0;
				array[19] <= 0;
				array[20] <= 0;
				array[21] <= 0;
				array[22] <= 0;
				array[23] <= 0;
				array[24] <= 0;
				array[25] <= 0;
				array[26] <= 0;
				array[27] <= 0;
				array[28] <= 0;
				array[29] <= 0;
				array[30] <= 0;
				array[31] <= 0;
				array[32] <= 0;
				array[33] <= 0;
				array[34] <= 0;
				array[35] <= 0;
				array[36] <= 0;
				array[37] <= 0;
				array[38] <= 0;
				array[39] <= 0;
				array[40] <= 0;
				array[41] <= 0;
				array[42] <= 0;
				array[43] <= 0;
				array[44] <= 0;
				array[45] <= 0;
				array[46] <= 0;
				array[47] <= 0;
				array[48] <= 0;
				array[49] <= 0;
				array[50] <= 0;
				array[51] <= 0;
				array[52] <= 0;
				array[53] <= 0;
				array[54] <= 0;
				array[55] <= 0;
				array[56] <= 0;
				array[57] <= 0;
				array[58] <= 0;
				array[59] <= 0;
				array[60] <= 0;
				array[61] <= 0;
				array[62] <= 0;
				array[63] <= 0;
				array[64] <= 0;
				array[65] <= 0;
				array[66] <= 0;
				array[67] <= 0;
				array[68] <= 0;
				array[69] <= 0;
				array[70] <= 0;
				array[71] <= 0;
				array[72] <= 0;
				array[73] <= 0;
				array[74] <= 0;
				
				num_0[0 ] <= 0;	num_1[0 ] <= 0;
				num_0[1 ] <= 0;	num_1[1 ] <= 0;
				num_0[2 ] <= 0;	num_1[2 ] <= 0;
				num_0[3 ] <= 0;	num_1[3 ] <= 0;
				num_0[4 ] <= 0;	num_1[4 ] <= 0;
				num_0[5 ] <= 0;	num_1[5 ] <= 0;
				num_0[6 ] <= 0;	num_1[6 ] <= 0;
				num_0[7 ] <= 0;	num_1[7 ] <= 0;
				num_0[8 ] <= 0;	num_1[8 ] <= 0;
				num_0[9 ] <= 0;	num_1[9 ] <= 0;
				num_0[10] <= 0;	num_1[10] <= 0;
				num_0[11] <= 0;	num_1[11] <= 0;
				num_0[12] <= 0;	num_1[12] <= 0;
				num_0[13] <= 0;	num_1[13] <= 0;
				num_0[14] <= 0;	num_1[14] <= 0;
				num_0[15] <= 0;	num_1[15] <= 0;
				num_0[16] <= 0;	num_1[16] <= 0;
				num_0[17] <= 0;	num_1[17] <= 0;
				num_0[18] <= 0;	num_1[18] <= 0;
				num_0[19] <= 0;	num_1[19] <= 0;
				num_0[20] <= 0;	num_1[20] <= 0;
				num_0[21] <= 0;	num_1[21] <= 0;
				num_0[22] <= 0;	num_1[22] <= 0;
				num_0[23] <= 0;	num_1[23] <= 0;
				num_0[24] <= 0;	num_1[24] <= 0;
				num_0[25] <= 0;	num_1[25] <= 0;
				num_0[26] <= 0;	num_1[26] <= 0;
				num_0[27] <= 0;	num_1[27] <= 0;
				num_0[28] <= 0;	num_1[28] <= 0;
				num_0[29] <= 0;	num_1[29] <= 0;
				num_0[30] <= 0;	num_1[30] <= 0;
				num_0[31] <= 0;	num_1[31] <= 0;
				num_0[32] <= 0;	num_1[32] <= 0;
				num_0[33] <= 0;	num_1[33] <= 0;
				num_0[34] <= 0;	num_1[34] <= 0;
				num_0[35] <= 0;	num_1[35] <= 0;
				num_0[36] <= 0;	num_1[36] <= 0;
				num_0[37] <= 0;	num_1[37] <= 0;
				num_0[38] <= 0;	num_1[38] <= 0;
				num_0[39] <= 0;	num_1[39] <= 0;
				num_0[40] <= 0;	num_1[40] <= 0;
				num_0[41] <= 0;	num_1[41] <= 0;
				num_0[42] <= 0;	num_1[42] <= 0;
				num_0[43] <= 0;	num_1[43] <= 0;
				num_0[44] <= 0;	num_1[44] <= 0;
				num_0[45] <= 0;	num_1[45] <= 0;
				num_0[46] <= 0;	num_1[46] <= 0;
				num_0[47] <= 0;	num_1[47] <= 0;
				num_0[48] <= 0;	num_1[48] <= 0;
				num_0[49] <= 0;	num_1[49] <= 0;
				num_0[50] <= 0;	num_1[50] <= 0;
				num_0[51] <= 0;	num_1[51] <= 0;
				num_0[52] <= 0;	num_1[52] <= 0;
				num_0[53] <= 0;	num_1[53] <= 0;
				num_0[54] <= 0;	num_1[54] <= 0;
				num_0[55] <= 0;	num_1[55] <= 0;
				num_0[56] <= 0;	num_1[56] <= 0;
				num_0[57] <= 0;	num_1[57] <= 0;
				num_0[58] <= 0;	num_1[58] <= 0;
				num_0[59] <= 0;	num_1[59] <= 0;
				num_0[60] <= 0;	num_1[60] <= 0;
				num_0[61] <= 0;	num_1[61] <= 0;
				num_0[62] <= 0;	num_1[62] <= 0;
				num_0[63] <= 0;	num_1[63] <= 0;
				num_0[64] <= 0;	num_1[64] <= 0;
				num_0[65] <= 0;	num_1[65] <= 0;
				num_0[66] <= 0;	num_1[66] <= 0;
				num_0[67] <= 0;	num_1[67] <= 0;
				num_0[68] <= 0;	num_1[68] <= 0;
				num_0[69] <= 0;	num_1[69] <= 0;
				num_0[70] <= 0;	num_1[70] <= 0;
				num_0[71] <= 0;	num_1[71] <= 0;
				num_0[72] <= 0;	num_1[72] <= 0;
				num_0[73] <= 0;	num_1[73] <= 0;
				num_0[74] <= 0;	num_1[74] <= 0;
				
				
				add_L <= 0;	add_R <= 0;
				count_sequence = 0;
				count_bit = 0;	
				mid_data = 0;
			end
		else
			begin
				if(data_clkPg)
					begin
						array[0 ]   <= data;
						array[1 ]   <= array[0 ]  ;
						array[2 ]   <= array[1 ]  ;
						array[3 ]   <= array[2 ]  ;
						array[4 ]   <= array[3 ]  ;
						array[5 ]   <= array[4 ]  ;
						array[6 ]   <= array[5 ]  ;
						array[7 ]   <= array[6 ]  ;
						array[8 ]   <= array[7 ]  ;
						array[9 ]   <= array[8 ]  ;
						array[10]   <= array[9 ]  ;
						array[11]   <= array[10]  ;
						array[12]   <= array[11]  ;
						array[13]   <= array[12]  ;
						array[14]   <= array[13]  ;
						array[15]   <= array[14]  ;
						array[16]   <= array[15]  ;
						array[17]   <= array[16]  ;
						array[18]   <= array[17]  ;
						array[19]   <= array[18]  ;
						array[20]   <= array[19]  ;
						array[21]   <= array[20]  ;
						array[22]   <= array[21]  ;
						array[23]   <= array[22]  ;
						array[24]   <= array[23]  ;
						array[25]   <= array[24]  ;
						array[26]   <= array[25]  ;
						array[27]   <= array[26]  ;
						array[28]   <= array[27]  ;
						array[29]   <= array[28]  ;
						array[30]   <= array[29]  ;
						array[31]   <= array[30]  ;
						array[32]   <= array[31]  ;
						array[33]   <= array[32]  ;
						array[34]   <= array[33]  ;
						array[35]   <= array[34]  ;
						array[36]   <= array[35]  ;
						array[37]   <= array[36]  ;
						array[38]   <= array[37]  ;
						array[39]   <= array[38]  ;
						array[40]   <= array[39]  ;
						array[41]   <= array[40]  ;
						array[42]   <= array[41]  ;
						array[43]   <= array[42]  ;
						array[44]   <= array[43]  ;
						array[45]   <= array[44]  ;
						array[46]   <= array[45]  ;
						array[47]   <= array[46]  ;
						array[48]   <= array[47]  ;
						array[49]   <= array[48]  ;
						array[50]   <= array[49]  ;
						array[51]   <= array[50]  ;
						array[52]   <= array[51]  ;
						array[53]   <= array[52]  ;
						array[54]   <= array[53]  ;
						array[55]   <= array[54]  ;
						array[56]   <= array[55]  ;
						array[57]   <= array[56]  ;
						array[58]   <= array[57]  ;
						array[59]   <= array[58]  ;
						array[60]   <= array[59]  ;
						array[61]   <= array[60]  ;
						array[62]   <= array[61]  ;
						array[63]   <= array[62]  ;
						array[64]   <= array[63]  ;
						array[65]   <= array[64]  ;
						array[66]   <= array[65]  ;
						array[67]   <= array[66]  ;
						array[68]   <= array[67]  ;
						array[69]   <= array[68]  ;
						array[70]   <= array[69]  ;
						array[71]   <= array[70]  ;
						array[72]   <= array[71]  ;
						array[73]   <= array[72]  ;
						array[74]   <= array[73]  ;
						f_start = 1;//触发器
						array_data <= data;
					end
				else 
					begin
						if(f_start == 1)
							begin	
								if(count_bit == 8)//判断完成
									begin
										count_bit <= 0;
										f_start <= 0;
										mid_data_out <= mid_data;
										add_L <= 0;
										add_R <= 0;
										num_0[0 ] <= 0;	num_1[0 ] <= 0;
										num_0[1 ] <= 0;	num_1[1 ] <= 0;
										num_0[2 ] <= 0;	num_1[2 ] <= 0;
										num_0[3 ] <= 0;	num_1[3 ] <= 0;
										num_0[4 ] <= 0;	num_1[4 ] <= 0;
										num_0[5 ] <= 0;	num_1[5 ] <= 0;
										num_0[6 ] <= 0;	num_1[6 ] <= 0;
										num_0[7 ] <= 0;	num_1[7 ] <= 0;
										num_0[8 ] <= 0;	num_1[8 ] <= 0;
										num_0[9 ] <= 0;	num_1[9 ] <= 0;
										num_0[10] <= 0;	num_1[10] <= 0;
										num_0[11] <= 0;	num_1[11] <= 0;
										num_0[12] <= 0;	num_1[12] <= 0;
										num_0[13] <= 0;	num_1[13] <= 0;
										num_0[14] <= 0;	num_1[14] <= 0;
										num_0[15] <= 0;	num_1[15] <= 0;
										num_0[16] <= 0;	num_1[16] <= 0;
										num_0[17] <= 0;	num_1[17] <= 0;
										num_0[18] <= 0;	num_1[18] <= 0;
										num_0[19] <= 0;	num_1[19] <= 0;
										num_0[20] <= 0;	num_1[20] <= 0;
										num_0[21] <= 0;	num_1[21] <= 0;
										num_0[22] <= 0;	num_1[22] <= 0;
										num_0[23] <= 0;	num_1[23] <= 0;
										num_0[24] <= 0;	num_1[24] <= 0;
										num_0[25] <= 0;	num_1[25] <= 0;
										num_0[26] <= 0;	num_1[26] <= 0;
										num_0[27] <= 0;	num_1[27] <= 0;
										num_0[28] <= 0;	num_1[28] <= 0;
										num_0[29] <= 0;	num_1[29] <= 0;
										num_0[30] <= 0;	num_1[30] <= 0;
										num_0[31] <= 0;	num_1[31] <= 0;
										num_0[32] <= 0;	num_1[32] <= 0;
										num_0[33] <= 0;	num_1[33] <= 0;
										num_0[34] <= 0;	num_1[34] <= 0;
										num_0[35] <= 0;	num_1[35] <= 0;
										num_0[36] <= 0;	num_1[36] <= 0;
										num_0[37] <= 0;	num_1[37] <= 0;
										num_0[38] <= 0;	num_1[38] <= 0;
										num_0[39] <= 0;	num_1[39] <= 0;
										num_0[40] <= 0;	num_1[40] <= 0;
										num_0[41] <= 0;	num_1[41] <= 0;
										num_0[42] <= 0;	num_1[42] <= 0;
										num_0[43] <= 0;	num_1[43] <= 0;
										num_0[44] <= 0;	num_1[44] <= 0;
										num_0[45] <= 0;	num_1[45] <= 0;
										num_0[46] <= 0;	num_1[46] <= 0;
										num_0[47] <= 0;	num_1[47] <= 0;
										num_0[48] <= 0;	num_1[48] <= 0;
										num_0[49] <= 0;	num_1[49] <= 0;
										num_0[50] <= 0;	num_1[50] <= 0;
										num_0[51] <= 0;	num_1[51] <= 0;
										num_0[52] <= 0;	num_1[52] <= 0;
										num_0[53] <= 0;	num_1[53] <= 0;
										num_0[54] <= 0;	num_1[54] <= 0;
										num_0[55] <= 0;	num_1[55] <= 0;
										num_0[56] <= 0;	num_1[56] <= 0;
										num_0[57] <= 0;	num_1[57] <= 0;
										num_0[58] <= 0;	num_1[58] <= 0;
										num_0[59] <= 0;	num_1[59] <= 0;
										num_0[60] <= 0;	num_1[60] <= 0;
										num_0[61] <= 0;	num_1[61] <= 0;
										num_0[62] <= 0;	num_1[62] <= 0;
										num_0[63] <= 0;	num_1[63] <= 0;
										num_0[64] <= 0;	num_1[64] <= 0;
										num_0[65] <= 0;	num_1[65] <= 0;
										num_0[66] <= 0;	num_1[66] <= 0;
										num_0[67] <= 0;	num_1[67] <= 0;
										num_0[68] <= 0;	num_1[68] <= 0;
										num_0[69] <= 0;	num_1[69] <= 0;
										num_0[70] <= 0;	num_1[70] <= 0;
										num_0[71] <= 0;	num_1[71] <= 0;
										num_0[72] <= 0;	num_1[72] <= 0;
										num_0[73] <= 0;	num_1[73] <= 0;
										num_0[74] <= 0;	num_1[74] <= 0;
									end
								else
									begin
										if(count_sequence == 75)//一列判断完成
											begin
											if(add_L + num_0[count_bit] >= count_half)//判断中值所在
												begin 
													mid_data[count_bit] <= 1'b0;
													add_R <= add_R + num_1[count_bit];//中值在左侧，至少有add_R+num1[count_bit]个数在中值右侧
												end
											else 
												begin
													mid_data[count_bit] <= 1'b1;
													add_L <= add_L + num_0[count_bit];//中值在右侧，至少有add_R+num1[count_bit]个数在中值左侧
												end
												
											count_bit <= count_bit + 1;
											count_sequence <= 0;
											array_data <= array[0];
											end
										else
											begin
												count_sequence <= count_sequence + 1;
												array_data <= array[count_sequence + 1];
												case(count_bit)
													0:		if(array_data[0] == 0)
																num_0[0] <= num_0[0] + 1;
															else
																num_1[0] <= num_1[0] + 1;
													1:	if(array_data[0] == mid_data[0])
															begin
																if(array_data[1] == 0)
																	num_0[1] <= num_0[1] + 1;
																else
																	num_1[1] <= num_1[1] + 1;
															end
													
													2:	if(array_data[0:1] == mid_data[0:1])
															begin
																if(array_data[2] == 0)
																	num_0[2] <= num_0[2] + 1;
																else
																	num_1[2] <= num_1[2] + 1;
															end
													3:	if(array_data[0:2] == mid_data[0:2])
															begin
																if(array_data[3] == 0)
																	num_0[3] <= num_0[3] + 1;
																else
																	num_1[3] <= num_1[3] + 1;
															end
													4:	if(array_data[0:3] == mid_data[0:3])
															begin
																if(array_data[4] == 0)
																	num_0[4] <= num_0[4] + 1;
																else
																	num_1[4] <= num_1[4] + 1;
															end
													5:	if(array_data[0:4] == mid_data[0:4])
															begin
																if(array_data[5] == 0)
																	num_0[5] <= num_0[5] + 1;
																else
																	num_1[5] <= num_1[5] + 1;
															end
													6:	if(array_data[0:5] == mid_data[0:5])
															begin
																if(array_data[6] == 0)
																	num_0[6] <= num_0[6] + 1;
																else
																	num_1[6] <= num_1[6] + 1;
															end
													7:	if(array_data[0:6] == mid_data[0:6])
															begin
																if(array_data[7] == 0)
																	num_0[7] <= num_0[7] + 1;
																else
																	num_1[7] <= num_1[7] + 1;
															end
													
													default:;
												endcase
											end
									end
							end
					end
			end
	end

endmodule

/*
有N个位数为M的无符号二进制数求他们中的中值

1. 统计这N个数的最高（M-1）位 0、1的个数分别为num0_M-1、num1_M-1. 若num0_M-1 > N/2 则可以判断中值在 M-1位为0的数 中。
并且可以判断按从左到右从小到大的顺序 add_R = num1_M-1 个 M-1位为1的数 比中值大在中值右侧。

2. 在1.中判断出的 num0_M-1 个M-1位为0的数中继续统计其第M-2位 0、1的个数分别为num0_M-2、num1_M-2. 
若num0_M-2 < N/2 则可以判断中值在M-1位为0、M-2为1的num1_M-2个数中。并且可以判断add_L = num0_M-2 个 M-2位为0的数 比中值小在中值左侧。

3. 在2.中判断出的 num1_M-2 个M-1位为0、M-2为1的数中继续统计 M-3 位 0、1的个数分别为 num0_M-3、num1_M-3.
若add_L + num0_M-3 > N/2 则可以判断中值在M-1位为0、M-2为1、M-3位为0的num0_M-3个数中。add_R = add_R + num1_M-3个数 比中值大在中值右侧。

4. 重复以上步骤直到判断到这N个数的最低位。

*/


