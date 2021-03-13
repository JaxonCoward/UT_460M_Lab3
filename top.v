`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2021 6:22:32 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk, 
    input [3:0]sw,
    output [0:0]led,
    output [3:0] an,
    output [6:0] seg
    );

    wire [31:0]step_count;
    wire [15:0]distance_covered;//fixed point, 1 digit
    wire [3:0]initial_activity_count;
    wire [15:0]high_activity_time;

    wire start = sw[0];
    wire reset = sw[1];
    wire [1:0]mode = sw[3:2];

    fitbit(clk, start, start, mode, led[0], step_count, distance_covered, initial_activity_count, high_activity_time);

    sevenseg(clk, reset, step_count, distance_covered, initial_activity_count, high_activity_time, an, seg); 
endmodule
