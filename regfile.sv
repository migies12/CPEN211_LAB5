
module regfile(data_in,writenum,write,readnum,clk,data_out);

localparam IV0 = 8'b00000001;
localparam IV1 = 8'b00000010;
localparam IV2 = 8'b00000100;
localparam IV3 = 8'b00001000;
localparam IV4 = 8'b00010000;
localparam IV5 = 8'b00100000;
localparam IV6 = 8'b01000000;
localparam IV7 = 8'b10000000;

reg[15:0] OUT0, OUT1, OUT2, OUT3, OUT4, OUT5, OUT6, OUT7;


input [15:0] data_in;
input [2:0] writenum, readnum;
input write, clk;
output [15:0] data_out;
reg registerOut;
reg regSel[2:0];


always_ff @(posedge clk) begin



if (write) begin
case(writenum)

	0:begin
	   OUT0 <= data_in;
	   OUT1 <= OUT1;
	   OUT2 <= OUT2;
	   OUT3 <= OUT3;
	   OUT4 <= OUT4;
	   OUT5 <= OUT5;
	   OUT6 <= OUT6;
	   OUT7 <= OUT7;
	   end

	1: begin
	   OUT0 <= OUT0;
	   OUT1 <= data_in;
	   OUT2 <= OUT2;
	   OUT3 <= OUT3;
	   OUT4 <= OUT4;
	   OUT5 <= OUT5;
	   OUT6 <= OUT6;
	   OUT7 <= OUT7;
	   end

	2: begin
 	   OUT0 <= OUT0;
	   OUT1 <= OUT1;
	   OUT2 <= data_in;
	   OUT3 <= OUT3;
	   OUT4 <= OUT4;
	   OUT5 <= OUT5;
	   OUT6 <= OUT6;
	   OUT7 <= OUT7;
	   end

	3: begin 
	   OUT0 <= OUT0;
	   OUT1 <= OUT1;
	   OUT2 <= OUT2;
	   OUT3 <= data_in;
	   OUT4 <= OUT4;
	   OUT5 <= OUT5;
	   OUT6 <= OUT6;
	   OUT7 <= OUT7;
	   end

	4: begin
	   OUT0 <= OUT0;
	   OUT1 <= OUT1;
	   OUT2 <= OUT2;
	   OUT3 <= OUT3;
	   OUT4 <= data_in;
	   OUT5 <= OUT5;
	   OUT6 <= OUT6;
	   OUT7 <= OUT7;
	   end

	5: begin
	   OUT0 <= OUT0;
	   OUT1 <= OUT1;
	   OUT2 <= OUT2;
	   OUT3 <= OUT3;
	   OUT4 <= OUT4;
	   OUT5 <= data_in;
	   OUT6 <= OUT6;
	   OUT7 <= OUT7;
	   end

	6: begin 
	   OUT0 <= OUT0;
	   OUT1 <= OUT1;
	   OUT2 <= OUT2;
	   OUT3 <= OUT3;
	   OUT4 <= OUT4;
	   OUT5 <= OUT5;
	   OUT6 <= data_in;
	   OUT7 <= OUT7;
	   end

	7: begin
	   OUT0 <= OUT0;
	   OUT1 <= OUT1;
	   OUT2 <= OUT2;
	   OUT3 <= OUT3;
	   OUT4 <= OUT4;
	   OUT5 <= OUT5;
	   OUT6 <= OUT6;
	   OUT7 <= data_in;
	   end

	default: begin
	   OUT0 <= OUT0;
	   OUT1 <= OUT1;
	   OUT2 <= OUT2;
	   OUT3 <= OUT3;
	   OUT4 <= OUT4;
	   OUT5 <= OUT5;
	   OUT6 <= OUT6;
	   OUT7 <= OUT7;
	   end

endcase

end 

end //always

assign data_out = (readnum == 3'b000) ? OUT0 :
              (readnum == 3'b001) ? OUT1 :
              (readnum == 3'b010) ? OUT2 :
              (readnum == 3'b011) ? OUT3 :
              (readnum == 3'b100) ? OUT4 :
              (readnum == 3'b101) ? OUT5 :
              (readnum == 3'b110) ? OUT6 :
              (readnum == 3'b111) ? OUT7 :
              1'b0; // Default case if none of the select lines match (should be impossible)





endmodule