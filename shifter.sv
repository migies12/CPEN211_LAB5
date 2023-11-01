//defining two bit binary numbers
`define TWO_BIT_ZERO 2'b00
`define TWO_BIT_ONE  2'b01
`define TWO_BIT_TWO  2'b10
`define TWO_BIT_THREE  2'b11

module shifter(in,shift,sout);
input [15:0] in;
input [1:0] shift;
output reg [15:0] sout;

always @(shift or in) begin 
    case(shift)
        `TWO_BIT_ZERO: sout = in;
        `TWO_BIT_ONE: sout = in << 1;
        `TWO_BIT_TWO: sout = in >> 1;
        `TWO_BIT_THREE: sout = $signed(in) >>> 1;
        default: sout = 16'bx;
    endcase
end

endmodule

