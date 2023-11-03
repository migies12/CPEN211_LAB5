

module datapath_tb();

  
   // Inputs
     reg [15:0] sim_datapath_in, sim_data_out;
     reg sim_clk, sim_write, sim_vsel, sim_loada, sim_loadb, sim_asel, sim_bsel, sim_loadc, sim_loads;
     reg [2:0] sim_writenum, sim_readnum;
     reg [1:0] sim_shift, sim_ALUop;
 
 

    // Outputs
     wire [15:0] sim_datapath_out;
     wire  sim_Z_out;
    
    // Instantiate the module under test
    datapath uut (
        .datapath_in(sim_datapath_in),
        .writenum(sim_writenum),
        .write(sim_write),
        .clk(sim_clk),
        .readnum(sim_readnum),
	.vsel(sim_vsel),
	.loada(sim_loada),
	.loadb(sim_loadb),
	.asel(sim_asel),
	.bsel(sim_bsel),
	.loadc(sim_loadc),
	.loads(sim_loads),
	.shift(sim_shift),
	.ALUop(sim_ALUop),
	.datapath_out(sim_datapath_out),
	.Z_out(sim_Z_out)
    );
    

    // Testbench stimulus
    initial begin


	//Write 7 to R0 and 2 to R1
	sim_clk = 0;
	#2
        sim_write = 1'b1;
	sim_vsel = 1;	  //mux select Dataath_in as input
	sim_writenum = 0; //Write to R0
	sim_datapath_in = 16'd7; //16 bit value of 7 in dec
	sim_clk = 1'b1;

        #5;
	sim_clk = 0;
	#2

	sim_writenum = 1;
	sim_datapath_in = 16'd2;
	sim_clk = 1'b1;

	#5;
	sim_clk = 0;
	#2

	//Load R1 to a
	
	sim_write = 1'b0;
	sim_readnum = 1;
	sim_loada = 1;
	sim_loadb = 0;
	sim_loadc = 0;
	sim_asel = 0;
	sim_clk = 1;
	

	#5;
	sim_clk = 0;
	#2

	//Load R0 to b

	sim_readnum = 0;
	sim_loada = 0;
	sim_loadb = 1;
	sim_bsel = 1;
	sim_shift = 2'b01; //Left shift by 1
	sim_ALUop = 2'b00; //ADD
	sim_loads = 0;
	
	sim_clk = 1;
	

	#5;
	sim_clk = 0;
	#2

	// Load into C, and write to R2

	sim_loadb = 0;
	sim_loadc = 1;
	sim_vsel = 0;
	sim_writenum = 2;
	sim_write = 1;
	sim_clk = 1;

	#5
	sim_clk = 0;
	#2

	$display("Read R3 Output is %b, we expected %b", sim_datapath_out, 16'd16);
	


	
	
	//if(~(sim_data_out == sim_data_in)) err = 1;
	


    end
    

endmodule
