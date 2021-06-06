module clog2(
	input clk,
	input reset_n,
	input [18:0] val,
	output reg [31:0] out_val
);

reg [31:0] clog2 = 32'h0;
reg [18:0] in_val;
always @(posedge clk, negedge reset_n) begin
	if (!reset_n) begin
		out_val = 32'h0;
	end else begin
		in_val = val;
		for (clog2=0; in_val>0; clog2=clog2+1) begin
			in_val = in_val>>1;
		end
		out_val = clog2 - 1;
	end
end

/*
//get floor(log2(val))
function [31:0] getfloorclog2(input[18:0] val );
begin
	
	if ((val)>= 19'h40000) begin
		getfloorclog2 = 18;
	end else if ((val) >= 19'h20000) begin
		getfloorclog2 = 17;
	end else if ((val) >= 19'h10000) begin
		getfloorclog2 = 16;
	end else if ((val) >= 19'h08000) begin
		getfloorclog2 = 15;
	end else if ((val) >= 19'h04000) begin
		getfloorclog2 = 14;
	end else if ((val) >= 19'h02000) begin
		getfloorclog2 = 13;
	end else if ((val) >= 19'h01000) begin
		getfloorclog2 = 12;
	end else if ((val) >= 19'h00800) begin
		getfloorclog2 = 11;
	end else if ((val) >= 19'h00400) begin
		getfloorclog2 = 10;
	end else if ((val) >= 19'h00200) begin
		getfloorclog2 = 9;
	end else if ((val) >= 19'h00100) begin
		getfloorclog2 = 8;
	end else if ((val) >= 19'h00080) begin
		getfloorclog2 = 7;
	end else if ((val) >= 19'h00040) begin
		getfloorclog2 = 6;
	end else if ((val) >= 19'h00020) begin
		getfloorclog2 = 5;
	end else if ((val) >= 19'h00010) begin
		getfloorclog2 = 4;
	end else if ((val) >= 19'h00008) begin
		getfloorclog2 = 3;
	end else if ((val) >= 19'h00004) begin
		getfloorclog2 = 2;
	end else if ((val) >= 19'h00002) begin
		getfloorclog2 = 1;
	end else if ((val) >= 19'h00001) begin
		getfloorclog2 = 0;
	end else begin
		getfloorclog2 = 0;
		
	end
end
endfunction

always_ff @(posedge clk, negedge reset_n) begin
	if (!reset_n) begin
		out_val = 32'h0;
	end else begin
		out_val = getfloorclog2(val);
	end
end
*/

endmodule