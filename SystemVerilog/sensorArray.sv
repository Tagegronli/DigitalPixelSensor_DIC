module SENSOR_ARRAY (
    input logic BIAS, 
    input logic RAMP,
    input logic ERASE,
    input logic EXPOSE,
    input logic READ,
    inout [7:0] DATA1,
    inout [7:0] DATA2,
    inout [7:0] DATA3,
    inout [7:0] DATA4
);
    parameter  real dv_pixel1 = 0.5;
    parameter real dv_pixel2 = 0.8;
    PIXEL_SENSOR #(.dv_pixel(dv_pixel1)) sens1(BIAS, RAMP, ERASE, EXPOSE, READ, DATA1);
    PIXEL_SENSOR #(.dv_pixel(dv_pixel1)) sens2(BIAS, RAMP, ERASE, EXPOSE, READ, DATA2);
    PIXEL_SENSOR #(.dv_pixel(dv_pixel2)) sens3(BIAS, RAMP, ERASE, EXPOSE, READ, DATA3);
    PIXEL_SENSOR #(.dv_pixel(dv_pixel2)) sens4(BIAS, RAMP, ERASE, EXPOSE, READ, DATA4);
endmodule