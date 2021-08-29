`timescale 1ns / 1ps

module caesar_decryption #(
				parameter D_WIDTH = 8,
				parameter KEY_WIDTH = 16
			)(
			// Clock and reset interface
			input clk,
			input rst_n,
			
			// Input interface
			input[D_WIDTH - 1:0] data_i,
			input valid_i,
			
			// Decryption Key
			input[KEY_WIDTH - 1 : 0] key,
			
			// Output interface
			output reg busy,
			output reg[D_WIDTH - 1:0] data_o,
			output reg valid_o
    );

// TODO: Implement Caesar Decryption here
    always @(posedge clk) begin
        // busy e pus mereu pe 0 la caesar
        busy <= 0;
        // daca se citesc date sunt atribuite imediat iesirii
        // dar decriptate prin scaderea cheii
        if(valid_i != 0) begin
            data_o <= data_i - key;
            // se pune valid_o pe 1 cand se afiseaza caractere
            valid_o <= 1;
        end
        else begin
            // daca nu se ma afiseaza se pune pe 0
            valid_o <= 0;
        end
    end
endmodule

