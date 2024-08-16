module Char(
	Clk,
	Char_n,
	Char_x,
	Char_y,
	Char_p
);
	input Clk;
	input [6:0]		Char_n;
	input [10:0]	Char_x;
	input [10:0]	Char_y;
	output reg 		Char_p;


	
//char
reg [15:0]	Zero	[0:31];
reg [15:0]	One		[0:31];
reg [15:0]	Two		[0:31];
reg [15:0]	Three	[0:31];
reg [15:0]	Four	[0:31];
reg [15:0]	Five	[0:31];
reg [15:0]	Six		[0:31];
reg [15:0]	Seven	[0:31];
reg [15:0]	Eight	[0:31];
reg [15:0]	Nine	[0:31];
reg [15:0]	Per		[0:31];

//提示词
reg [47:0]	HR		[0:31];
reg [79:0]	SPO2	[0:31];
reg [63:0]	TPM		[0:31];
reg [95:0]	review	[0:31];
reg [95:0]	r_time	[0:31];
reg [63:0]	mod		[0:31];


//署名
//reg [127:0]	lnu		[0:127]	;
//reg [175:0]	depart	[0:15]	;
//reg [151:0] author  [0:15]	;
//reg [127:0] ymd     [0:15]  ;


reg [15:0]	zi_16	;
reg [47:0]	HR_r	;
reg [79:0]	SPO2_r	;

reg [63:0]	zi_64	;
reg [95:0]	zi_96	;

//reg [255:0]	zi_256	;
//reg [175:0]	zi_176	;
//reg [151:0]	zi_152	;
//reg [127:0]	zi_128	;

initial 
begin
$readmemh("zero.txt"	, Zero	);
$readmemh("one.txt"		, One	);
$readmemh("two.txt"		, Two	);
$readmemh("three.txt"	, Three	);
$readmemh("four.txt"	, Four	);
$readmemh("five.txt"	, Five	);
$readmemh("six.txt"		, Six	);
$readmemh("seven.txt"	, Seven	);
$readmemh("eight.txt"	, Eight	);
$readmemh("nine.txt"	, Nine	);
$readmemh("per.txt"		, Per	);

$readmemh("hr.txt"		, HR	);
$readmemh("spo2.txt"	, SPO2	);
$readmemh("dw.txt"		, TPM	);
$readmemh("review.txt"	, review);
$readmemh("rtime.txt"	, r_time);
$readmemh("mod.txt"		, mod	);

//$readmemh("lnu.txt"		, lnu	);
//$readmemh("depart.txt"	, depart);
//$readmemh("author.txt"	, author);
//$readmemh("time.txt"	, ymd	);

end

always@(*)
	case(Char_n)
	0:begin
		zi_16 	= Zero[Char_y];
		Char_p 	= zi_16[16-Char_x];
	end
	1:begin
		zi_16 	= One[Char_y];
		Char_p 	= zi_16[16-Char_x];
	end
	2:begin
		zi_16 	= Two[Char_y];
		Char_p 	= zi_16[16-Char_x];
	end
	3:begin
		zi_16 	= Three[Char_y];
		Char_p 	= zi_16[16-Char_x];
	end
	4:begin
		zi_16 	= Four[Char_y];
		Char_p 	= zi_16[16-Char_x];
	end
	5:begin
		zi_16 	= Five[Char_y];
		Char_p 	= zi_16[16-Char_x];
	end
	6:begin
		zi_16 	= Six[Char_y];
		Char_p 	= zi_16[16-Char_x];
	end
	7:begin
		zi_16 	= Seven[Char_y];
		Char_p 	= zi_16[16-Char_x];
	end
	8:begin
		zi_16 	= Eight[Char_y];
		Char_p 	= zi_16[16-Char_x];
	end
	9:begin
		zi_16 	= Nine[Char_y];
		Char_p 	= zi_16[16-Char_x];
	end
	10:begin//%
		zi_16 	= Per[Char_y];
		Char_p 	= zi_16[16-Char_x];
	end
	11:begin//HR
		HR_r 	= HR[Char_y];
		Char_p 	= HR_r[48-Char_x];
	end
	12:begin//SPO2
		SPO2_r 	= SPO2[Char_y];
		Char_p 	= SPO2_r[80-Char_x];
	end
	13:begin//TPM
		zi_64 	= TPM[Char_y];
		Char_p 	= zi_64[64-Char_x];
	end
	14:begin//mod
		zi_64 	= mod[Char_y];
		Char_p 	= zi_64[64-Char_x];
	end
	15:begin//review
		zi_96 	= review[Char_y];
		Char_p 	= zi_96[96-Char_x];
	end
	16:begin//r_time
		zi_96 	= r_time[Char_y];
		Char_p 	= zi_96[96-Char_x];
	end
/*	
	17:begin//lnu
		zi_128 	= lnu[Char_y];
		Char_p 	= zi_128[128-Char_x];
	end
	
	18:begin//depart
		zi_176 	= depart[Char_y];
		Char_p 	= zi_176[176-Char_x];
	end
	19:begin//author
		zi_152 	= author[Char_y];
		Char_p 	= zi_152[152-Char_x];
	end
	20:begin//ymd
		zi_128 	= ymd[Char_y];
		Char_p 	= zi_128[128-Char_x];
	end
*/
	default:	Char_p = 0;
endcase



endmodule