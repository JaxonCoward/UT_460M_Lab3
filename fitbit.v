`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2021 09:16:23 PM
// Design Name: 
// Module Name: fitbit
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


module fitbit(
    input CLK,
    input START,
    input RESET,
    input [1:0]MODE,
    output reg SI
    );
    
    reg [31:0]step_count;
    reg [31:0]distance_covered;
    reg [3:0]initial_activity_count;
    reg [31:0]high_activity_time;

    reg low_received;

    pulse_generator step_input(CLK, START, MODE, pulse);

    initial begin
        step_count = 0;
        distance_covered = 0;
        initial_activity_count = 0;
        high_activity_time = 0;
        low_received = 1;
    end

    always @(posedge CLK) begin
        if(low_received && pulse)begin
            low_received <= 0;
            step_count <= step_count + 1;
        end
        else if(!low_received && !pulse)begin
            low_received <= 1;
        end

        if(step_count > 9999)begin
            SI <= 1;
        end
    end

    
    
endmodule