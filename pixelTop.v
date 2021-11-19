
module pixelTop (
    input logic             clk,
    input logic             reset,
    input logic             vbn1,
	input logic	            ramp,
	input logic	            erase,
	input logic	            expose,
	input logic	            read0,
	input logic	            read1,
	input logic	            read2,
	input logic	            read3,
    input logic             convert,
	inout [7:0]             pixData
);

    pixelArray  pa(vbn1, ramp, reset, erase,expose, read0, read1, read2, read3, pixData);

    pixelState #(.c_erase(5),.c_expose(255),.c_convert(255),.c_read(5))
    fsm1(.clk(clk),.reset(reset),.erase(erase),.expose(expose),.read0(read0),.read1(read1),.read2(read2),.read3(read3),.convert(convert));

    //------------------------------------------------------------
    // DAC and ADC model
    //------------------------------------------------------------
    logic[7:0] data;

    // If we are to convert, then provide a clock via anaRamp
    // This does not model the real world behavior, as anaRamp would be a voltage from the ADC
    // however, we cheat
    assign ramp = convert ? clk : 0;

    // During expoure, provide a clock via anaBias1.
    // Again, no resemblence to real world, but we cheat.
    assign vbn1 = expose ? clk : 0;

    // If we're not reading the pixData, then we should drive the bus
    assign pixData = ((read0 || read1) || (read2 || read3)) ? 8'bZ: data;

    // When convert, then run a analog ramp (via anaRamp clock) and digtal ramp via
    // data bus.
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            data =0;
        end
        if(convert) begin
            data +=  1;
        end
        else begin
            data = 0;
        end
    end // always @ (posedge clk or reset)

    //------------------------------------------------------------
    // Readout from databus
    //------------------------------------------------------------
    logic [7:0] pixelDataOut;
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            pixelDataOut = 0;
        end
        else begin
            if((read0 || read1) || (read2 || read3))
            pixelDataOut <= pixData;
        end
    end
    
endmodule