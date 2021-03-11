`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2021 07:25:23 PM
// Design Name: 
// Module Name: pulse_generator
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


module pulse_generator(
    input CLK,
    input START, 
    input [1:0]MODE,
    output OUT,
    output [7:0]SECONDS
    );
    
    reg pulse;
    reg [31:0]counter;

    reg [31:0]second_counter;
    reg [7:0]seconds_passed;

    assign OUT = pulse;
    assign SECONDS = seconds_passed;

    initial begin
        pulse = 0;
        counter = 0;
        second_counter = 0;
        seconds_passed = 0;
    end

    always @(posedge CLK) begin
        counter <= counter + 1;
        second_counter <= second_counter + 1;

        if(second_counter == 200000000)begin
            if(seconds_passed < 145)begin
                seconds_passed <= seconds_passed + 1;
            end
        end

        if(!START) begin
            pulse <= 0;
            counter <= 0;
            second_counter <= 0;
            seconds_passed <= 0;
        end
        else begin
            case (MODE)
                00: begin
                        if(counter == 1562500) begin //1562500 = 32 pulses per second (1/x)/10ns
                            pulse <= pulse ^ 1;
                            counter <= 0;
                        end
                    end
                01: begin
                        if(counter == 781250) begin //781250 = 64 pulses per second (1/x)/10ns
                            pulse <= pulse ^ 1;
                            counter <= 0;
                        end
                    end
                10: begin
                        if(counter == 390625) begin //390625 = 128 pulses per second (1/x)/10ns
                            pulse <= pulse ^ 1;
                            counter <= 0;
                        end
                    end
                11: begin
                        if(seconds_passed < 1)begin
                            if(counter == 10000000) begin //10000000 = 20 pulses per second (1/x)/10ns
                                pulse <= pulse ^ 1;
                                counter <= 0;
                            end
                        end
                        else if(seconds_passed < 2)begin
                            if(counter == 6060606) begin //6060606 = 33 pulses per second (1/x)/10ns
                                pulse <= pulse ^ 1;
                                counter <= 0;
                            end
                        end
                        else if(seconds_passed < 3)begin
                            if(counter == 3030303) begin //3030303 = 66 pulses per second (1/x)/10ns
                                pulse <= pulse ^ 1;
                                counter <= 0;
                            end
                        end
                        else if(seconds_passed < 4)begin
                            if(counter == 7407407) begin //7407407 = 27 pulses per second (1/x)/10ns
                                pulse <= pulse ^ 1;
                                counter <= 0;
                            end
                        end
                        else if(seconds_passed < 5)begin
                            if(counter == 2857142) begin //2857142 = 70 pulses per second (1/x)/10ns
                                pulse <= pulse ^ 1;
                                counter <= 0;
                            end
                        end
                        else if(seconds_passed < 6)begin
                            if(counter == 6666666) begin //6666666 = 30 pulses per second (1/x)/10ns
                                pulse <= pulse ^ 1;
                                counter <= 0;
                            end
                        end
                        else if(seconds_passed < 7)begin
                            if(counter == 10526315) begin //10526315 = 19 pulses per second (1/x)/10ns
                                pulse <= pulse ^ 1;
                                counter <= 0;
                            end
                        end
                        else if(seconds_passed < 8)begin
                            if(counter == 6666666) begin //6666666 = 30 pulses per second (1/x)/10ns
                                pulse <= pulse ^ 1;
                                counter <= 0;
                            end
                        end
                        else if(seconds_passed < 9)begin
                            if(counter == 6060606) begin //6060606 = 33 pulses per second (1/x)/10ns
                                pulse <= pulse ^ 1;
                                counter <= 0;
                            end
                        end
                        else if(seconds_passed < 73)begin
                            if(counter == 2898550) begin //2898550 = 69 pulses per second (1/x)/10ns
                                pulse <= pulse ^ 1;
                                counter <= 0;
                            end
                        end
                        else if(seconds_passed < 79)begin
                            if(counter == 5882352) begin //5882352 = 34 pulses per second (1/x)/10ns
                                pulse <= pulse ^ 1;
                                counter <= 0;
                            end
                        end
                        else if(seconds_passed < 144)begin
                            if(counter == 1612903) begin //1612903 = 124 pulses per second (1/x)/10ns
                                pulse <= pulse ^ 1;
                                counter <= 0;
                            end
                        end
                        else begin // No pulses
                            pulse <= 0;
                            counter <= 0;
                        end
                    end
            endcase
        end
    end

    
    
endmodule