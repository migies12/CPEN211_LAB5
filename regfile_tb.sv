

module regfile_tb();

  
   // Inputs
    reg [15:0] sim_data_in;
    reg [2:0] sim_writenum, sim_readnum;
    reg sim_write, sim_clk;
    reg err = 0;

    // Outputs
    wire [15:0] sim_data_out;
    
    // Instantiate the module under test
    regfile DUT (
        .data_in(sim_data_in),
        .writenum(sim_writenum),
        .write(sim_write),
        .clk(sim_clk),
        .readnum(sim_readnum),
	.data_out(sim_data_out)
    );
    

    // Testbench stimulus
    initial begin


	//Set R3 to 12 and read from R3
	sim_clk = 0;
	#2
        sim_write = 1'b1;
	sim_writenum = 3;
	sim_readnum = 3;
	sim_data_in = 12;
	sim_clk = 1'b1;
        #5;
	$display("Read R3 Output is %b, we expected %b", sim_data_out, sim_data_in);
	if(~(sim_data_out == sim_data_in)) err = 1;
	//Set R3 to 30. Read should automatically be updated

	sim_clk = 0;
	#2;
	
	sim_data_in = 30;
	sim_clk = 1'b1;
        #5;
	$display("Read new R3 Output is %b, we expected %b", sim_data_out, sim_data_in);
	if(~(sim_data_out == sim_data_in)) err = 1;
	sim_clk = 0;
	#2;

	//Set R1 to 5 and read from R3 (same val)
	sim_clk = 0;
	#2
        sim_write = 1'b1;
	sim_writenum = 1;
	sim_data_in = 5;
	sim_clk = 1'b1;
        #5;
	$display("Read R3 Output is %b, we expected %b", sim_data_out, 16'd30);
	if(~(sim_data_out == 16'd30)) err = 1;

	//Set R0 to 0 and read from R1
	sim_clk = 0;
	#2
	sim_writenum = 0;
	sim_readnum =1;
	sim_data_in = 0;
	sim_clk = 1'b1;
        #5;
	$display("Read R1 Output is %b, we expected %b", sim_data_out, 16'd5);
	if(~(sim_data_out == 16'd5)) err = 1;

	//Set R2 to 16'b1 and read from R1
	sim_clk = 0;
	#2
	sim_writenum = 2;
	sim_readnum = 0;
	sim_data_in = 16'b1111111111111111;
	sim_clk = 1'b1;
        #5;
	$display("Read R0 Output is %b, we expected %b", sim_data_out, 16'd0);
	if(~(sim_data_out == 16'd0)) err = 1;

	//Set R4 to 16'b1 and read from R2
	sim_clk = 0;
	#2
	sim_writenum = 4;
	sim_readnum = 2;
	sim_data_in = 16'd5689;
	sim_clk = 1'b1;
        #5;
	$display("Read R2 Output is %b, we expected %b", sim_data_out, 16'b1111111111111111);
	if(~(sim_data_out == 16'b1111111111111111)) err = 1;

	//Set R4 to 16'b1 and read from R2
	sim_clk = 0;
	#2
	sim_writenum = 5;
	sim_readnum = 4;
	sim_data_in = 16'd1100;
	sim_clk = 1'b1;
        #5;
	$display("Read R4 Output is %b, we expected %b", sim_data_out, 16'd5689);
	if(~(sim_data_out == 16'd5689)) err = 1;

	//Set R6 and read from R5
	sim_clk = 0;
	#2
	sim_writenum = 6;
	sim_readnum = 5;
	sim_data_in = 16'd69420;
	sim_clk = 1'b1;
        #5;
	$display("Read R5 Output is %b, we expected %b", sim_data_out, 16'd1100);
	if(~(sim_data_out == 16'd1100)) err = 1;

	//Set R6 and read from R5
	sim_clk = 0;
	#2
	sim_writenum = 7;
	sim_readnum = 6;
	sim_data_in = 16'd10;
	sim_clk = 1'b1;
        #5;
	$display("Read R6 Output is %b, we expected %b", sim_data_out, 16'd69420);
	if(~(sim_data_out == 16'd69420)) err = 1;

	//Read ONLY from R7
	sim_clk = 0;
	#2
	sim_write = 0;
	sim_writenum = 7;
	sim_readnum = 7;
	sim_data_in = 16'd11111111111111111111111111110;
	sim_clk = 1'b1;
        #5;
	$display("Read R7 Output is %b, we expected %b", sim_data_out, 16'd10);
	if(~(sim_data_out == 16'd10)) err = 1;


    end
    

endmodule