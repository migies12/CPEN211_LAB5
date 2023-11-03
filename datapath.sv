
module datapath(write, vsel, loada, loadb, asel, bsel, loadc, loads, datapath_in,
		 clk, readnum, writenum, shift, ALUop, Z_out, datapath_out);

  input [15:0] datapath_in;
  input clk, write, vsel, loada, loadb, asel, bsel, loadc, loads;
  input [2:0] writenum, readnum;
  input [1:0] shift, ALUop;
 
  output [15:0] datapath_out;
  output reg Z_out;

  reg [15:0] Ain, Bin,data_out, A_out, B_out, ALU_out, B_shift, data_in, sout;
  reg Z;

  assign data_in = vsel ? datapath_in: datapath_out;

  regfile registers (.data_in(data_in), .writenum(writenum),
			 .write(write), .readnum(readnum), .clk(clk), .data_out(data_out));

  vDFF #(16) A (.clk(clk), .D(data_out), .Q(A_out));
  vDFF #(16) B (.clk(clk), .D(data_out), .Q(B_out));
  vDFF #(16) C (.clk(clk), .D(ALU_out), .Q(datapath_out));
  vDFF status (.clk(clk), .D(Z), .Q(Z_out));

 shifter shifter (.in(B_out), .shift(shift), .sout(sout));

  assign Ain = (asel == 1) ? 16'b0 : A_out;
  assign Bin = (bsel == 1) ? {11'b0, datapath_in[4:0]} : sout;


  ALU calculator (.Ain(Ain), .Bin(Bin), .ALUop(ALUop), .out(ALU_out) , .Z(Z));


endmodule