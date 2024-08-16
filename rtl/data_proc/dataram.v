module dataram
(
	input Clk,
	input Rst_n,
	input [7:0]idata,
	input idata_valid,
	
	output [7:0]proc_data1,		//心电波形
	output proc_flag1,
	
	output [7:0]proc_data2,		//心率
	output proc_flag2,
	
	output [7:0]proc_data3,		//血氧饱和度
	output proc_flag3,
	
	output [23:0]show_bcd,
	output [7:0]show_wave
	
);

reg [6:0]waddr;
wire [11:0]hrbcd;
wire [11:0]spbcd;

always@(posedge Clk or negedge Rst_n)
begin
	if(!Rst_n)begin
		waddr <= 7'd0;
	end
	else begin
		if(idata_valid)begin
			if(waddr == 7'd75)
				waddr <= 7'd0;
			else 
				waddr <= waddr + 1'b1;
		end else
			waddr <= waddr;
	end
end

assign proc_data1 = (waddr>=7'd1&&waddr<=7'd64&&idata_valid)? idata : proc_data1;
assign proc_flag1 = (waddr>=7'd1&&waddr<=7'd64&&idata_valid)?  1'b1 : 1'b0;


assign proc_data2 = (waddr==7'd65&&idata_valid)? idata : proc_data2;
assign proc_flag2 = (waddr==7'd65&&idata_valid)?  1'b1 : 1'b0;

assign proc_data3 = (waddr==7'd66&&idata_valid)? idata : proc_data3;
assign proc_flag3 = (waddr==7'd66&&idata_valid)?  1'b1 : 1'b0;

binTobcd inst1
(
.bin(proc_data2),
.bcd(hrbcd)
);

binTobcd inst2
(
.bin(proc_data3),
.bcd(spbcd)
);
assign show_bcd  = (proc_flag3==1'b1)? 		{hrbcd,spbcd}	:	show_bcd			;
assign show_wave = (proc_data1[7]==1'b1)? 	proc_data1 		: 	8'd128-proc_data1	;

endmodule