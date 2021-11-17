`timescale 1 ns / 1 ps


module pixelSensorFsm(
   input logic clk,
   input logic reset,
   output logic erase,
   output logic expose,
   output logic read,
   output logic convert

);
   parameter integer c_erase = 5;
   parameter integer c_expose = 255;
   parameter integer c_convert = 255;
   parameter integer c_read = 5;

   parameter ERASE=0, EXPOSE=1, CONVERT=2, READ=3, IDLE=4;

   logic convert_stop;
   logic [2:0] state,next_state;  
   integer counter;

   always_ff @(negedge clk ) begin
      case(state)
        ERASE: begin
           erase <= 1;
           read <= 0;
           expose <= 0;
           convert <= 0;
        end
        EXPOSE: begin
           erase <= 0;
           read <= 0;
           expose <= 1;
           convert <= 0;
        end
        CONVERT: begin
           erase <= 0;
           read <= 0;
           expose <= 0;
           convert = 1;
        end
        READ: begin
           erase <= 0;
           read <= 1;
           expose <= 0;
           convert <= 0;
        end
        IDLE: begin
           erase <= 0;
           read <= 0;
           expose <= 0;
           convert <= 0;

        end
      endcase
   end 

   always_ff @(posedge clk or posedge reset) begin
      if(reset) begin
         state = IDLE;
         next_state = ERASE;
         counter  = 0;
         convert  = 0;
      end
      else begin
         case (state)
           ERASE: begin
              if(counter == c_erase) begin
                 next_state <= EXPOSE;
                 state <= IDLE;
              end
           end

           EXPOSE: begin
              if(counter == c_expose) begin
                 next_state <= CONVERT;
                 state <= IDLE;
              end
           end

           CONVERT: begin
              if(counter == c_convert) begin
                 next_state <= READ;
                 state <= IDLE;
              end
           end

           READ:
             if(counter == c_read) begin
                state <= IDLE;
                next_state <= ERASE;
             end
             
           IDLE:
             state <= next_state;
         endcase 
         if(state == IDLE)
           counter = 0;
         else
           counter = counter + 1;
      end
   end 
endmodule
