`timescale 1ns / 1ps

module mux #(
		parameter D_WIDTH = 8
	)(
		// Clock and reset interface
		input clk,
		input rst_n,
		
		//Select interface
		input[1:0] select,
		
		// Output interface
		output reg[D_WIDTH - 1 : 0] data_o,
		output reg				    valid_o,
				
		//output interfaces
		input [D_WIDTH - 1 : 0] 	data0_i,
		input   					valid0_i,
		
		input [D_WIDTH - 1 : 0] 	data1_i,
		input   					valid1_i,
		
		input [D_WIDTH - 1 : 0] 	data2_i,
		input     					valid2_i
    );
	
	//TODO: Implement MUX logic here
	reg[D_WIDTH - 1 : 0] data_reg, aux;
    always @(posedge clk) begin
        case(select)
            2'b00: begin
                if(valid0_i == 1) begin
                    data_reg <= data0_i;
                    data_o <= 0;
                    valid_o <= 0;
                end
                else if(data_reg != 0 && valid0_i == 0) begin
                    aux <= data_reg;
                    data_o <= aux;
                    valid_o <= 1;
                    data_reg <= 0;
                end
                else begin
                    data_o <= 0;
                    valid_o <= 0;
                    //data_reg <= 0;
                end
            end
            2'b01: begin
                if(valid1_i == 1) begin
                    data_reg <= data1_i;
                    data_o <= 0;
                    valid_o <= 0;
                end
                else if(data_reg != 0 && valid1_i == 0) begin
                    aux <= data_reg;
                    data_o <= aux;
                    valid_o <= 1;
                    data_reg <= 0;
                end
                else begin
                    data_o <= 0;
                    valid_o <= 0;
                    //data_reg <= 0;
                end
            end
            2'b10: begin
                if(valid2_i == 1) begin
                    data_reg <= data2_i;
                    data_o <= 0;
                    valid_o <= 0;
                end
                else if(data_reg != 0 && valid2_i == 0) begin
                    aux <= data_reg;
                    data_o <= aux;
                    valid_o <= 1;
                    data_reg <= 0;
                end
                else begin
                    data_o <= 0;
                    valid_o <= 0;
                    //data_reg <= 0;
                end
            end
        endcase
    end
endmodule
