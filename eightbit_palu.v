// 8-Bit Partial Arithmetic Logic Unit
// Jake Messner 2/1/2016

module palu(input[7:0] a,
			input[7:0] b,
			input[1:0] sel,
			output reg [7:0] f,
			output reg ovf);
		always @(a,b,sel)
			case(sel)
				0: begin 
					f = a + b;
						if((a+b)>255)
							ovf = 1;
						else
							ovf = 0;
					end
				1: begin 
						f = ~b;
						ovf = 0;
					end
				2: begin 
						f = a & b;
						ovf = 0;
					end
				3: begin 
						f = a | b;
						ovf = 0;
					end
			endcase
endmodule

module palu_test;
	wire[7:0] f;
	wire ovf;
	reg[7:0] a, b;
	reg[1:0] sel;
	palu palu_8_bit(a,b,sel,f,ovf);
	initial begin
		$monitor("%d a=%b, b=%b, sel=%b, f=%b, ovf=%b",$time,a,b,sel,f,ovf);
		#10 a=8'b01010011;
			b=8'b10010100;
			sel=2'b00;
		#10 a=8'b11010101;
			b=8'b01111000;
			sel=2'b00;
		#10 a=8'b00000000;
			b=8'b10101010;
			sel=2'b01;
		#10 a=8'b10111000;
			b=8'b11100111;
			sel=2'b10;
		#10 a=8'b10110101;
			b=8'b11010111;
			sel=2'b11;
		#10 $finish;
	end
endmodule
