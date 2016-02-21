// 8-Bit Arithmetic Logic Unit
// Jake Messner 2/1/2016
// DLD Lab 3

module palu(input[7:0] a,
			input[7:0] b,
			input[2:0] sel,
			output reg [7:0] f,
			output reg ovf,
			output reg take_branch);
		always @(a,b,sel)
			case(sel)
				0: begin 
					f = a + b;
					take_branch = 0;
						if((a+b)>255)
							ovf = 1;
						else
							ovf = 0;
					end
				1: begin 
						take_branch = 0;			
						f = ~b;
						ovf = 0;
					end
				2: begin 
						take_branch = 0;
						f = a & b;
						ovf = 0;
					end
				3: begin 
						take_branch = 0;
						f = a | b;
						ovf = 0;
					end
				4: begin 
						take_branch = 0;			
						f = a >>> 1;
						ovf = 0;
					end
				5: begin 
						f = a <<< 1;
						ovf = 0;
						take_branch = 0;
					end
				6: begin 
						ovf = 0;
						if(a==b)
							take_branch = 1;
						else 
							take_branch = 0;
					end
				7: begin 
						ovf = 0;
						if(a!=b)
							take_branch = 1;
						else 
							take_branch = 0;
					end
			endcase
endmodule

module palu_test;
	wire[7:0] f;
	wire ovf;
	wire take_branch;
	reg[7:0] a, b;
	reg[2:0] sel;
	palu palu_8_bit(a,b,sel,f,ovf, take_branch);
	initial begin
		$monitor("%d a=%b, b=%b, sel=%b, f=%b, ovf=%b, take_branch=%b",$time,a,b,sel,f,ovf,take_branch);
		#10 a=8'b01010011;
			b=8'b10010100;
			sel=3'b000;
		#10 a=8'b11010101;
			b=8'b01111000;
			sel=3'b000;
		#10 a=8'b00000000;
			b=8'b10101010;
			sel=3'b001;
		#10 a=8'b10111000;
			b=8'b11100111;
			sel=3'b010;
		#10 a=8'b10110101;
			b=8'b11010111;
			sel=3'b011;
		#10 a=8'b10110101;
			b=8'b11010111;
			sel=3'b100;
		#10 a=8'b10110101;
			b=8'b11010111;
			sel=3'b101;
		#10 a=8'b10110101;
			b=8'b11010111;
			sel=3'b110;
		#10 a=8'b10110101;
			b=8'b11010111;
			sel=3'b111;
		#10 $finish;
	end
endmodule
