

module tb_regfile();

  
   // Inputs
    reg [15:0] sim_data_in;
    reg [2:0] sim_writenum, sim_readnum;
    reg sim_write, sim_clk;

    // Outputs
    wire [15:0] sim_data_out;
    
    // Instantiate the module under test
    regfile uut (
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

	//Set R3 to 30. Read should automatically be updated

	sim_clk = 0;
	#2;
	
	sim_data_in = 30;
	sim_clk = 1'b1;
        #5;
	$display("Read new R3 Output is %b, we expected %b", sim_data_out, sim_data_in);
	sim_clk = 0;
	#2;
    end
    

endmodule
