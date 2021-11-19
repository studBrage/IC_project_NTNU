
`timescale 1 ns / 1 ps

module pixelTop_tb;

   logic clk =0;
   logic reset =0;
   parameter integer clk_period = 500;
   parameter integer sim_end = clk_period*2400;
   always #clk_period clk=~clk;

   //Analog signals
   logic              anaBias1;
   logic              anaRamp;

   //Digital
   wire             erase;
   wire             expose;
   wire             read0;
   wire             read1;
   wire             read2;
   wire             read3;
   wire             convert;

   tri[7:0]         pixData;

   pixelTop pxTop(clk, reset, anaBias1, anaRamp, erase, expose, read0, read1, read2, read3, connvert, pixData);
 
   initial
     begin
        reset = 1;

        #clk_period  reset=0;

        $dumpfile("pixelTop_tb.vcd");
        $dumpvars(0,pixelTop_tb);

        #sim_end
          $stop;

     end
    
endmodule