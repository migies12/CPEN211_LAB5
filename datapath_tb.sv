

module datapath_tb();

  
   // Inputs
     reg [15:0] sim_datapath_in, sim_data_out;
     reg sim_clk, sim_write, sim_vsel, sim_loada, sim_loadb, sim_asel, sim_bsel, sim_loadc, sim_loads;
     reg [2:0] sim_writenum, sim_readnum;
     reg [1:0] sim_shift, sim_ALUop;
	
	reg err;
 

    // Outputs
     wire [15:0] sim_datapath_out;
     wire  sim_Z_out;
    
    // Instantiate the module under test
    datapath DUT (
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
		err = 0;

//////////////////////////////////////////////////////////////////////////////////////////////////
//TEST #1: Adding 2 and 7 left shifted by 1 (14) which outputs 10000
$display("Test #1: Adding 2 and 7 left shifted by 1 (14) which outputs 10000 using R0 and R1");
	//Write 7 to R0 and 2 to R1
	sim_clk = 0;
	#2;
    sim_write = 1'b1;
	sim_vsel = 1;	  //mux select Dataath_in as input
	sim_writenum = 0; //Write to R0
	sim_datapath_in = 16'd7; //16 bit value of 7 in dec
	
	sim_clk = 1'b1;
    #5;
	sim_clk = 0;
	#2;

	sim_writenum = 1;
	sim_datapath_in = 16'd2;
	sim_clk = 1'b1;

	#5;
	sim_clk = 0;
	#2;

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
	#2;

	//Load R0 to b

	sim_readnum = 0;
	sim_loada = 0;
	sim_loadb = 1;
	sim_bsel = 0;
	sim_shift = 2'b01; //Left shift by 1
	sim_ALUop = 2'b00; //ADD
	sim_loads = 0;
	
	sim_clk = 1;
	
	#5;
	sim_clk = 0;
	#2;

	// Load into C, and write to R2

	sim_loadb = 0;
	sim_loadc = 1;
	sim_vsel = 0;
	sim_writenum = 2;
	sim_write = 1;
	sim_clk = 1;

	#5;
	sim_clk = 0;
	#2;
	sim_clk = 1;
	sim_loadc = 0;

	$display("Read R3 Output is %b, we expected %b", sim_datapath_out, 16'd16);
	
	if(~(sim_datapath_out == 16'd16)|| sim_Z_out == 1) err = 1;
	
//////////////////////////////////////////////////////////////////////////////////////////////////
//TEST #2: Subtracting 13 and 4 right shifted by 1 (14) which outputs 1011 in R2 and R0
$display("TEST #2: Subtracting 13 and 4 right shifted by 1 (14) which outputs 1011");
	//Write 13 to R2
	sim_clk = 0;
	#2;
    sim_write = 1'b1;
	sim_vsel = 1;	  //mux select Dataath_in as input
	sim_writenum = 2'b10; //Write to R2
	sim_datapath_in = 16'd13; //16 bit value of 13 in dec
	
	sim_clk = 1'b1;
    #5;
	sim_clk = 0;
	#2;

	//Write 4 to R0
	sim_writenum = 0;
	sim_datapath_in = 16'd4;
	sim_clk = 1'b1;

	#5;
	sim_clk = 0;
	#2;

	//Load R2 (13) to a
	sim_write = 1'b0;
	sim_readnum = 2'd2;
	sim_loada = 1;
	sim_loadb = 0;
	sim_loadc = 0;
	sim_asel = 0;
	
	sim_clk = 1;
	#5;
	sim_clk = 0;
	#2;

	//Load R0 (4) to b

	sim_readnum = 0;
	sim_loada = 0;
	sim_loadb = 1;
	sim_bsel = 0;
	sim_shift = 2'b10; //Right shift by 1
	sim_ALUop = 2'b01; //subtract
	sim_loads = 0;
	
	sim_clk = 1;
	
	#5;
	sim_clk = 0;
	#2;

	// Load into C, and write to R2

	sim_loadb = 0;
	sim_loadc = 1;
	sim_vsel = 0;
	sim_writenum = 2;
	sim_write = 1;
	sim_clk = 1;

	#5;
	sim_clk = 0;
	#2;
	sim_clk = 1;

	$display("Read datapath out, Output is %b, we expected %b", sim_datapath_out, 16'd11);

	if((sim_datapath_out != 16'd11) || sim_Z_out == 1) err = 1;

	//////////////////////////////////////////////////////////////////////////////////////////////////
	//Test #3: ANDING Ain = 23045 and Bin = 19213
	$display("TEST #3: ANDING Ain = 23045 and Bin = 19213");
	
	//Write 23045 to R4
	sim_clk = 0;
	#2;
    sim_write = 1'b1;
	sim_vsel = 1;	  //mux select Dataath_in as input
	sim_writenum = 3'b100; //Write to R4
	sim_datapath_in = 16'd23045; //16 bit value of 23045 in dec
	sim_clk = 1'b1;

    #5;
	sim_clk = 0;
	#2;

	//Write 19213 to R1
	sim_writenum = 1;
	sim_datapath_in = 16'd19213;
	sim_clk = 1'b1;

	#5;
	sim_clk = 0;
	#2;

	//Load R4 (23045) to a
	sim_write = 1'b0;
	sim_readnum = 3'b100;
	sim_loada = 1;
	sim_loadb = 0;
	sim_loadc = 0;
	sim_asel = 0;
	
	sim_clk = 1;
	#5;
	sim_clk = 0;
	#2;

	//Load R1 (19213) to b

	sim_readnum = 1;
	sim_loada = 0;
	sim_loadb = 1;
	sim_bsel = 0;
	sim_shift = 2'b00;
	sim_ALUop = 2'b10; //And
	sim_loads = 0;
	
	sim_clk = 1;
	#5;
	sim_clk = 0;
	#2;

	// Load into C, and write to R2

	sim_loadb = 0;
	sim_loadc = 1;
	sim_vsel = 0;
	sim_writenum = 2;
	sim_write = 1;
	
	sim_clk = 1;
	#5;
	sim_clk = 0;
	#2;
	sim_clk = 1;

	$display("Read datapath out, Output is %b, we expected %b", sim_datapath_out, 16'd23045 & 16'd19213);

	if((sim_datapath_out != (16'd23045 & 16'd19213)) || sim_Z_out == 1) err = 1;

	//////////////////////////////////////////////////////////////////////////////////////////////////
	//Test #4: Notting Bin: 1
	$display("TEST #4: Notting Bin: 1");
	
	//Write 1111111100000101 to R5
	sim_clk = 0;
	#2;
    sim_write = 1'b1;
	sim_vsel = 1;	  //mux select Dataath_in as input
	sim_writenum = 3'b101; //Write to R5
	sim_datapath_in = 16'b1111111100000101; //16 bit value of 1 in dec
	sim_clk = 1'b1;
    #5;
	sim_clk = 0;
	#2;

	
	//Load R5 to b
	sim_write = 1'b0;
	sim_readnum = 3'b101;
	sim_loada = 0;
	sim_loadb = 1;
	sim_loadc = 0;
	sim_asel = 0;
	
	sim_clk = 1;
	#5;
	sim_clk = 0;
	#2;

	sim_loadb = 0;
	sim_bsel = 0;
	sim_shift = 2'b11;
	sim_ALUop = 2'b11; //not
	sim_loads = 0;
	
	sim_clk = 1;
	#5;
	sim_clk = 0;
	#2;

	// Load into C, and write to R2

	sim_loadb = 0;
	sim_loadc = 1;
	sim_vsel = 0;
	sim_writenum = 2;
	sim_write = 1;
	sim_clk = 1;

	#5;
	sim_clk = 0;
	#2;
	sim_clk = 1;

	$display("Read datapath out, Output is %b, we expected %b", sim_datapath_out, 16'b0000000001111101);

	if((sim_datapath_out != 16'b0000000001111101)|| sim_Z_out == 1) err = 1;

	//////////////////////////////////////////////////////////////////////////////////////////////
	//TEST SETTING ASEL AND BSEL TO 1 to make sure it uses 16'b0 for A and 11'b0+4'b[datapath_in]
	//Test #5: Setting ASEL to 1
	$display("Test #5: setting ASEL to 1, should make A all zeros");
	
	//Write 23045 to R4
	sim_clk = 0;
	#2;
    sim_write = 1'b1;
	sim_vsel = 1;	  //mux select Dataath_in as input
	sim_writenum = 3'b100; //Write to R4
	sim_datapath_in = 16'd23045; //16 bit value of 23045 in dec
	sim_clk = 1'b1;

    #5;
	sim_clk = 0;
	#2;

	//Write 19213 to R1
	sim_writenum = 1;
	sim_datapath_in = 16'd19213;
	sim_clk = 1'b1;

	#5;
	sim_clk = 0;
	#2;

	//Load R4 (23045) to a
	sim_write = 1'b0;
	sim_readnum = 3'b100;
	sim_loada = 1;
	sim_loadb = 0;
	sim_loadc = 0;
	sim_asel = 1;
	
	sim_clk = 1;
	#5;
	sim_clk = 0;
	#2;

	//Load R1 (19213) to b

	sim_readnum = 1;
	sim_loada = 0;
	sim_loadb = 1;
	sim_bsel = 0;
	sim_shift = 2'b00;
	sim_ALUop = 2'b00; //Add
	sim_loads = 0;
	
	sim_clk = 1;
	#5;
	sim_clk = 0;
	#2;

	// Load into C, and write to R2

	sim_loadb = 0;
	sim_loadc = 1;
	sim_vsel = 0;
	sim_writenum = 2;
	sim_write = 1;
	
	sim_clk = 1;
	#5;
	sim_clk = 0;
	#2;
	sim_clk = 1;

	$display("Read datapath out, Output is %b, we expected %b", sim_datapath_out, 16'd19213);

	if((sim_datapath_out != (16'd19213)) || sim_Z_out == 1) err = 1;

	///////////////////////////////////////////////////////////////////////////////////////////////
	//Test 6: setting ASEL and BSEL to 1, should make A all zeros and b different
	$display("Test #6: setting ASEL and BSEL to 1, should make A all zeros and b different");
	
	//Write 23045 to R4
	sim_clk = 0;
	#2;
    sim_write = 1'b1;
	sim_vsel = 1;	  //mux select Dataath_in as input
	sim_writenum = 3'b100; //Write to R4
	sim_datapath_in = 16'd23045; //16 bit value of 23045 in dec
	sim_clk = 1'b1;

    #5;
	sim_clk = 0;
	#2;

	//Write 19213 to R1
	sim_writenum = 1;
	sim_datapath_in = 16'd19213;
	sim_clk = 1'b1;

	#5;
	sim_clk = 0;
	#2;

	//Load R4 (23045) to a
	sim_write = 1'b0;
	sim_readnum = 3'b100;
	sim_loada = 1;
	sim_loadb = 0;
	sim_loadc = 0;
	sim_asel = 1;
	
	sim_clk = 1;
	#5;
	sim_clk = 0;
	#2;

	//Load R1 (19213) to b

	sim_readnum = 1;
	sim_loada = 0;
	sim_loadb = 1;
	sim_bsel = 1;
	sim_shift = 2'b00;
	sim_ALUop = 2'b00; //Add
	sim_loads = 0;
	
	sim_clk = 1;
	#5;
	sim_clk = 0;
	#2;

	// Load into C, and write to R2

	sim_loadb = 0;
	sim_loadc = 1;
	sim_vsel = 0;
	sim_asel = 1;
	sim_writenum = 2;
	sim_write = 1;
	
	sim_clk = 1;
	#5;
	sim_clk = 0;
	#2;
	sim_clk = 1;

	$display("Read datapath out, Output is %b, we expected %b", sim_datapath_out, {11'b0, sim_datapath_in[4:0]});

	if((sim_datapath_out != ({11'b0, sim_datapath_in[4:0]}) || sim_Z_out == 1)) err = 1;

	//////////////////////////////////////////////////////////////////////////////////////////////
	//TEST z_out to be 1 when output is zero
	//Test #7: Setting ASEL to 0
	$display("Test #5: setting ASEL to 1, should make A all zeros");
	
	//Write 23045 to R4
	sim_clk = 0;
	#2;
    sim_write = 1'b1;
	sim_vsel = 1;	  //mux select Dataath_in as input
	sim_writenum = 3'b100; //Write to R4
	sim_datapath_in = 16'd23045; //16 bit value of 23045 in dec
	sim_clk = 1'b1;

    #5;
	sim_clk = 0;
	#2;

	//Write 0 to R1
	sim_writenum = 1;
	sim_datapath_in = 16'd0;
	sim_clk = 1'b1;

	#5;
	sim_clk = 0;
	#2;

	//Load R4 (23045) to a
	sim_write = 1'b0;
	sim_readnum = 3'b100;
	sim_loada = 1;
	sim_loadb = 0;
	sim_loadc = 0;
	sim_asel = 1;
	
	sim_clk = 1;
	#5;
	sim_clk = 0;
	#2;

	//Load R1 (0) to b

	sim_readnum = 1;
	sim_loada = 0;
	sim_loadb = 1;
	sim_bsel = 0;
	sim_shift = 2'b00;
	sim_ALUop = 2'b00; //Add
	sim_loads = 0;
	
	sim_clk = 1;
	#5;
	sim_clk = 0;
	#2;

	// Load into C, and write to R2

	sim_loadb = 0;
	sim_loadc = 1;
	sim_vsel = 0;
	sim_asel = 1;
	sim_writenum = 2;
	sim_write = 1;
	
	sim_clk = 1;
	#5;
	sim_clk = 0;
	#2;
	sim_clk = 1;

	$display("Read datapath out, Output is %b, we expected %b", sim_datapath_out, 16'd0);

	if((sim_datapath_out != (16'd0) || sim_Z_out != 1)) err = 1;


    end

endmodule
