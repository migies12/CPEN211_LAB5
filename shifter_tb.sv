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

module shifter_tb;

reg [15:0] sim_in;
reg [1:0] sim_shift;
wire [15:0] sim_sout;
reg err;

shifter DUT(.in(sim_in),.shift(sim_shift),.sout(sim_sout));

initial begin 
err = 0;
//Test #1: Testing staying the same 
$display("Test 1: Stays the same");
sim_in = `DECIMAL_15615;
sim_shift = `TWO_BIT_ZERO;#3;
if (sim_sout != `DECIMAL_15615) err = 1; #3;
$display("We are expecting %b and getting %b", `DECIMAL_15615, sim_sout);

//Test #2: Testing left Shift 
$display("Test 2: Left Shift");
sim_in = `DECIMAL_43975;
sim_shift = `TWO_BIT_ONE;#3;
if (sim_sout != 16'b0101011010001110) err = 1; #3;
$display("We are expecting %b and getting %b", 16'b0101011010001110, sim_sout);

//Test #3: Testing right Shift 
$display("Test 3: Right Shift");
sim_in = `DECIMAL_43975;
sim_shift = `TWO_BIT_TWO; #3;
if (sim_sout != 16'b0101010110100011) err = 1; #3;
$display("We are expecting %b and getting %b", 16'b0101010110100011, sim_sout);

//Test #4: Testing arithmetic Shift - conserve a zero sign at front for positive 
$display("Test 4: Arithmetic Shift - Conserve 0/positive");
sim_in = 16'b0101010110100011;
sim_shift = `TWO_BIT_THREE; #3;
if (sim_sout != 16'b0010101011010001) err = 1; #3;
$display("We are expecting %b and getting %b", 16'b0010101011010001, sim_sout);

//Test #5: Testing arithmetic Shift - conserve a 1 at front for negative 
$display("Test 5: Arithmetic Shift - Conserve 1 for negative");
sim_in = 16'b1111000011001111;
sim_shift = `TWO_BIT_THREE; #3;
if (sim_sout != 16'b1111100001100111) err = 1; #3;
$display("We are expecting %b and getting %b", 16'b1111100001100111, sim_sout);

end

endmodule