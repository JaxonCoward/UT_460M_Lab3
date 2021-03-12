`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2021 07:03:34 AM
// Design Name: 
// Module Name: sevenseg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: provides time multiplexing for 4 sevenseg displays and modulo for upto 4 digit numbers 

// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module sevenseg(
  input clk,
  input [31:0] step_count,
  input reset,
  output [3:0] an,
  output [6:0] seg
); 

// BCD instantiation
reg [3:0] bcdin = 0; // Input to BCD, output directly tied to seg
bcd b0 (bcdin, seg);

// Clock divider - Divide-by-2
reg count = 0;
wire slow_clk = count;
always @(posedge clk) count = count + 1;

// State register variables
reg [1:0] current = 0;
reg [1:0] next = 0;

// Sequential logic
always @(posedge slow_clk) current <= next;

// Combinational logic
reg [3:0] an_buf = 0;;
assign an = an_buf;
always @(*) begin
    if(reset) begin // Synchronous reset
        bcdin = 4'b0000;// Set outputs
        an_buf = 4'b1110;
        next = 0;// set next state
        end
    else begin
        case(current)
        0: begin // state 0
            bcdin = ((step_count % 1000) % 100) % 10;
            an_buf = 4'b1110; 
            next = 1; // set next state
            end
        1: begin // state 1
            bcdin = ((step_count % 1000) % 100)/10;
            an_buf = 4'b1101;
            next = 2;
            end
        2:begin
            bcdin = (step_count % 1000)/100;
            an_buf = 4'b1011;
            next = 3;
            end
        3:begin
            bcdin = step_count/1000;
            an_buf = 4'b0111;
            next = 0;
            end
        default: begin
            bcdin = 4'd0000;
            an_buf = 4'b1110;
            next = 1;
            end
        endcase
    end
end

endmodule
