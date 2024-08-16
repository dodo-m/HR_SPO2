module fir_top
(
	input Clk,
	input Rst_n,
	input pass,
	input [7:0]idata,
	input i_flag,
	output [7:0]odata,
	output o_flag

);


wire o_flag_r;

wire [7:0]m_data;

/*
wire [1:0]ast_sink_error;
wire [1:0]ast_source_error;
assign ast_sink_error = 2'd0;
wire [7:0]fir_data;

fir_low fir_low (
.clk				(Clk)				,              
.reset_n			(Rst_n)				,       
.ast_sink_data		(idata)				,    			
.ast_sink_valid		(i_flag)			,   			
.ast_sink_error		(ast_sink_error)	,   			
.ast_source_data	(fir_data)			,  				
.ast_source_valid	(o_flag_r)			, 				
.ast_source_error  	(ast_source_error)				
);

*/
m_filter m_filter
(
.Clk		(Clk)		,
.Rst_n		(Rst_n)		,
.ida		(idata)		,
.iflag		(i_flag)	,
.oda		(m_data)	,
.oflag      (o_flag_r)
);


/*
mid_filter mid_filter
(
.clk			(Clk)		,
.data_clk		(o_flag_r)	,
.rest_n			(Rst_n)		,
.data			(fir_data)  ,
.mid_data_out   (mid_data)
);
wire [7:0]mid_data;
*/

assign odata = (pass==1'b1)? m_data 	: idata;
assign o_flag = (pass==1'b1)? o_flag_r 	: i_flag;
//assign o_flag = i_flag;
endmodule