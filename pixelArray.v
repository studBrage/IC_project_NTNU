

module pixelArray
	(
	input logic vbn1,
	input logic	ramp,
	input logic	reset,
	input logic	erase,
	input logic	expose,
	input logic	read0,
	input logic	read1,
	input logic	read2,
	input logic	read3,
	inout [7:0] data
	);

	parameter real dv_pixel0 = 0.2;
	parameter real dv_pixel1 = 0.4;
	parameter real dv_pixel2 = 0.6;
	parameter real dv_pixel3 = 0.8;
	
	PIXEL_SENSOR #(.dv_pixel(dv_pixel0))  ps0(vbn1, ramp, reset, erase, expose, read0, data);
	PIXEL_SENSOR #(.dv_pixel(dv_pixel1))  ps1(vbn1, ramp, reset, erase, expose, read1, data);
	PIXEL_SENSOR #(.dv_pixel(dv_pixel2))  ps2(vbn1, ramp, reset, erase, expose, read2, data);
	PIXEL_SENSOR #(.dv_pixel(dv_pixel3))  ps3(vbn1, ramp, reset, erase, expose, read3, data);

endmodule