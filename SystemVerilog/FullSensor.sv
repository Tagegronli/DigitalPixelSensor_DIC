module Sensor (
    input logic reset,
    input logic clk,
    inout [31:0] data
);
    
    logic BIAS, RAMP_CLK, erase, expose, read, convert;

    parameter integer expose_time = 255;

    SENSOR_ARRAY array(BIAS, RAMP_CLK,erase, expose, read, data[7:0], data[15:8], data[23:16], data[31:24]);
    pixelSensorFsm #(.c_expose(expose_time)) fsm(clk, reset, erase, expose, read, convert);

    assign RAMP_CLK = convert ? clk : 0;
    assign BIAS = expose ? clk : 0;

    logic[7:0] counter;

    assign data[7:0] = read ? 8'bZ : counter;
    assign data[15:8] = read ? 8'bZ : counter;
    assign data[23:16] = read ? 8'bZ : counter;
    assign data[31:24] = read ? 8'bZ : counter;
    
    always @(posedge clk or posedge reset) begin
      if(reset) begin
         counter =0;
      end
      if(convert) begin
         counter +=  1;
      end
      else begin
         counter = 0;
      end
   end
endmodule