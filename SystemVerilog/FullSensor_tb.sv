module Sensor_tb();
    logic reset;
    logic clk = 0;

    parameter integer clk_period = 100;
    parameter integer simlength = clk_period * 1500; 
    parameter integer resetlength = clk_period*5;

    tri logic [31:0] data;

    always #clk_period clk =~clk;

    parameter integer expose_time = 255;

    Sensor #(.expose_time(expose_time)) sensor(reset, clk, data);
    
   initial begin
        assign reset = 1; #resetlength
        assign reset = 0;

        $dumpfile("res.vcd");
        $dumpvars(0,Sensor_tb);

        #simlength
            $stop;
   end
endmodule