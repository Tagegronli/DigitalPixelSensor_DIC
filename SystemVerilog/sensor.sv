module PIXEL_SENSOR
  (
   input logic BIAS,
   input logic RAMP_CLK,
   input logic ERASE,
   input logic EXPOSE,
   input logic READ,
   inout [7:0] DATA

   );

   real v_erase = 1.2;
   real lsb = v_erase/255;
   parameter real dv_pixel = 0.5;

   real vstore;
   logic cmp;
   real  ramp;

   logic [7:0] p_data;

   always @(ERASE) begin
      vstore = v_erase;
      p_data = 0;
      cmp  = 0;
      ramp = 0;
   end

   always @(posedge BIAS) begin
      if(EXPOSE)
        vstore = vstore - dv_pixel*lsb;
   end

   always @(posedge RAMP_CLK) begin
      ramp = ramp + lsb;
      if(ramp > vstore)
        cmp <= 1;
   end

   always_comb  begin
      if(!cmp) begin
         p_data = DATA;
      end

   end

   assign DATA = READ ? p_data : 8'bZ;

endmodule 
