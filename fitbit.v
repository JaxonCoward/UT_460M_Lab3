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
    output [31:0]count,
    output [3:0]an,
    output [6:0]seg
    );
    
    reg [31:0]step_count;
    reg [15:0]distance_covered;//fixed point, 1 digit
    reg [3:0]initial_activity_count;
    reg [15:0]high_activity_time;
    
    pulse_generator step_input(CLK, START, MODE, pulse, current_second);

    //Step counter 
    reg low_received;

    //distance counter
    reg [11:0]distance_counter;

    //Initial counter
    reg [11:0]initial_counter
    reg [3:0]last_second;

    initial begin
        SI = 0;
        step_count = 0;
        distance_covered = 0;
        initial_activity_count = 0;
        high_activity_time = 0;

        low_received = 1;
        distance_counter = 0;
        initial_counter = 0;
        last_second = 0;
    end

    always @(posedge CLK) begin

        //STEP COUNT
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

        //DISTANCE COVERED
        if(distance_counter == 2048)begin
            distance_covered <= distance_covered + 1;
            distance_counter <= 0;
        end
        else begin
            distance_counter <= distance_counter + 1;
        end

        //FIRST 9 SECONDS
        if(current_second < 10)begin
            initial_counter <= initial_counter + 1;
            if(current_second > last_second)begin
                last_second <= current_second;
                initial_counter <= 0;

                if(initial_counter > 32)begin
                    initial_activity_count <= initial_activity_count + 1;
                end
            end
        end

        //HIGH ACTIVITY TIME

    end

    
    
endmodule