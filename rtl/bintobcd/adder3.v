module adder3(x, y);
input 		[3:0]	x;
output reg 	[3:0]	y;

always @ (x) begin
    case (x) 
        4'b0000 : y <= 4'b0000;
        4'b0001 : y <= 4'b0001;
        4'b0010 : y <= 4'b0010;
        4'b0011 : y <= 4'b0011;
        4'b0100 : y <= 4'b0100;
        4'b0101 : y <= 4'b1000;
        4'b0110 : y <= 4'b1001;
        4'b0111 : y <= 4'b1010;
        4'b1000 : y <= 4'b1011;
        4'b1001 : y <= 4'b1100;
        default : y <= 4'b0000;
    endcase
end
endmodule