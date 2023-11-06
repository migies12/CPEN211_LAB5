//defining two bit binary numbers
`define TWO_BIT_ZERO 2'b00
`define TWO_BIT_ONE  2'b01
`define TWO_BIT_TWO  2'b10
`define TWO_BIT_THREE  2'b11

//defining some 16 bit decimal numbers
`define DECIMAL_2   16'b0000000000000010
`define DECIMAL_2   16'b0000000000000010
`define DECIMAL_3   16'b0000000000000011
`define DECIMAL_5   16'b0000000000000101
`define DECIMAL_12  16'b0000000000001100
`define DECIMAL_24  16'b0000000000011000
`define DECIMAL_26  16'b0000000000011010
`define DECIMAL_25  16'b0000000000011001
`define DECIMAL_49  16'b0000000000110001
`define DECIMAL_51  16'b0000000000110011
`define DECIMAL_36  16'b0000000000100100
`define DECIMAL_378 16'b0000000110111010
`define DECIMAL_43975 16'b1010101101000111
`define DECIMAL_15615 16'b0011011111111111
`define DECIMAL_8295  16'b0010001101000111

module ALU_tb;
reg [15:0] sim_Ain, sim_Bin;
reg [1:0] sim_ALUop;
wire [15:0] sim_out;
wire sim_Z;
reg err;

ALU DUT(.Ain(sim_Ain),.Bin(sim_Bin),.ALUop(sim_ALUop),.out(sim_out),.Z(sim_Z));

initial begin
err = 0;
//Test #1: Testing addition 
$display("Test 1: Addition");
sim_Ain = `DECIMAL_2;
sim_Bin = `DECIMAL_49;
sim_ALUop = `TWO_BIT_ZERO; #3;
if (sim_out != `DECIMAL_51) err = 1; #3;
if (sim_Z == 1) err = 1; #3;
$display("Z is %b", sim_Z);
$display("We are expecting %b and getting %b", `DECIMAL_51, sim_out);

//Test #2: Testing subtraction 
$display("Test 2: Subtraction");
sim_Ain = `DECIMAL_24;
sim_Bin = `DECIMAL_12;
sim_ALUop = `TWO_BIT_ONE; #3;
if (sim_out != `DECIMAL_12) err = 1; #3;
if (sim_Z == 1) err = 1; #3;
$display("Z is %b", sim_Z);
$display("We are expecting %b and getting %b", `DECIMAL_12, sim_out);

//Test #3: Testing anding 
$display("Test 3: Anding");
sim_Ain = `DECIMAL_43975;
sim_Bin = `DECIMAL_15615;
sim_ALUop = `TWO_BIT_TWO; #3;
if (sim_out != `DECIMAL_8295) err = 1; #3;
if (sim_Z == 1) err = 1; #3;
$display("Z is %b", sim_Z);
$display("We are expecting %b and getting %b", `DECIMAL_8295, sim_out);

//Test #4: Testing Notting B 
$display("Test 4: Notting B");
sim_Bin = `DECIMAL_15615;
sim_ALUop = `TWO_BIT_THREE; #3;
if (sim_out != 16'b1100100000000000 ) err = 1; #3;
if (sim_Z == 1) err = 1; #3;
$display("Z is %b", sim_Z);
$display("We are expecting %b and getting %b", 16'b1100100000000000, sim_out);
 
//Test #5: Testing Zero output
$display("Test 4: Changing Z");
sim_Bin = `DECIMAL_12;
sim_Ain = `DECIMAL_12;
sim_ALUop = `TWO_BIT_ONE; #3;
if (sim_out != 16'b0000000000000000 ) err = 1; #3;
if (sim_Z == 0) err = 1; #3;
$display("Z is %b", sim_Z);
$display("We are expecting %b and getting %b", 16'b0000000000000000, sim_out);
end

endmodule 