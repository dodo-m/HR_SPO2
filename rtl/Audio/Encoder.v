module Encoder
//#( parameter mod=1'b1 )
(
	input 	  	[3:0]	num,
	output reg 	[4:0]	code
);


parameter mod = 1'b1;
localparam None = 5'b01000;	//23

always@(*)
	if(mod)begin //个位
		case(num)//1~10
		0:code <= 5'b11110;
		1:code <= 5'b11101;
		2:code <= 5'b11100;
		3:code <= 5'b11011;
		4:code <= 5'b11010;
		5:code <= 5'b11001;
		6:code <= 5'b11000;
		7:code <= 5'b10111;
		8:code <= 5'b10110;
		9:code <= 5'b10101;
		default:code <= None;
		endcase
	end
	else begin	//十位
		case(num)
		0:code <= 5'b11110;		//零还是读作零
		1:code <= 5'b10100;		//11~19
		2:code <= 5'b10011;
		3:code <= 5'b10010;
		4:code <= 5'b10001;
		5:code <= 5'b10000;
		6:code <= 5'b01111;
		7:code <= 5'b01110;
		8:code <= 5'b01101;
		9:code <= 5'b01100;
		
		default:code <= None;
		endcase
	end
	
endmodule