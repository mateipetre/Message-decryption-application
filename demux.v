`timescale 1ns / 1ps

module demux #(
		parameter MST_DWIDTH = 32,
		parameter SYS_DWIDTH = 8
	)(
		// Clock and reset interface
		input clk_sys,
		input clk_mst,
		input rst_n,
		
		//Select interface
		input[1:0] select,
		
		// Input interface
		input [MST_DWIDTH -1  : 0]	 data_i,
		input 						 valid_i,
		
		//output interfaces
		output reg [SYS_DWIDTH - 1 : 0] 	data0_o,
		output reg     						valid0_o,
		
		output reg [SYS_DWIDTH - 1 : 0] 	data1_o,
		output reg     						valid1_o,
		
		output reg [SYS_DWIDTH - 1 : 0] 	data2_o,
		output reg     						valid2_o
    );
	
	
	// TODO: Implement DEMUX logic
	reg[MST_DWIDTH - 1 : 0] data_reg;
	reg [1:0] i;
	always @(posedge clk_sys) begin
	   if(valid_i == 1) begin
	       data_reg <= data_i;
	       valid0_o <= 0;
	       valid1_o <= 0;
	       valid2_o <= 0;
	       data0_o <= 0;
	       data1_o <= 0;
	       data2_o <= 0;
	       i <= 2'b00;
	   end
	   else begin
	       case(select)
	           2'b00: begin
	               if(i <= 2'b11) begin
	                   data0_o <= {data_reg[8*i + 7], data_reg[8*i + 6], data_reg[8*i + 5],
                               data_reg[8*i + 4], data_reg[8*i + 3], data_reg[8*i + 2],
                               data_reg[8*i + 1], data_reg[8*i]};
	                   valid0_o <= 1;
	                   i <= i + 1;
	               end
	               else begin 
	                   data0_o <= 0;
	                   valid0_o <= 0;
	                   i <= 2'b00;
	               end
	           end
	           2'b01: begin
	               if(i <= 2'b11) begin
	                   data1_o <= {data_reg[8*i + 7], data_reg[8*i + 6], data_reg[8*i + 5],
                               data_reg[8*i + 4], data_reg[8*i + 3], data_reg[8*i + 2],
                               data_reg[8*i + 1], data_reg[8*i]};
	                   valid1_o <= 1;
	                   i <= i + 1;
	               end
	               else begin
	                   data1_o <= 0;
	                   valid1_o <= 0;
	                   i <= 2'b00;
	               end
	           end
	           2'b10: begin
	               if(i <= 2'b11) begin
	                   data2_o <= {data_reg[8*i + 7], data_reg[8*i + 6], data_reg[8*i + 5],
                               data_reg[8*i + 4], data_reg[8*i + 3], data_reg[8*i + 2],
                               data_reg[8*i + 1], data_reg[8*i]};
	                   valid2_o <= 1;
	                   i <= i + 1;
	               end
	               else begin
	                   data2_o <= 0;
	                   valid2_o <= 0;
	                   i <= 2'b00;
	               end
	           end
	       endcase
	   end
	end
endmodule
