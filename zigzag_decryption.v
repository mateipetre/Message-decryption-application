`timescale 1ns / 1ps

module zigzag_decryption #(
				parameter D_WIDTH = 8,
				parameter KEY_WIDTH = 8,
				parameter MAX_NOF_CHARS = 50,
				parameter START_DECRYPTION_TOKEN = 8'hFA
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

// TODO: Implement ZigZag Decryption here
   /* reg[7:0] data_reg [0 : MAX_NOF_CHARS - 1];
    reg[7:0] i, j, k, count_l, l, count_j, size, aux1, aux2;
    always @(posedge clk) begin
        // se pun busy si valid_o pe 0
        if(!rst_n) begin
            busy <= 0;
            valid_o <= 0;
        end
        // daca busy e pus pe 1 valid_o va fi pus si el
        // busy si valid_o nu trebuie sa fie puse pe 1 in acelasi timp
        if(busy == 1)
            valid_o <= 1;
        // cazul in care se citesc caracterele
        // si se pun secvential in vector
        if(valid_i == 1 && data_i != START_DECRYPTION_TOKEN) begin
            data_reg[i] <= data_i;
            data_o <= 0;
            i <= i + 1;
            l <= -1;
            size <= i;
            j <= 0;
            k <= -1;
            count_j <= (size + 1) / 2;
            count_l <= -1;
        end 
        // se pune busy pe 1
        else if(data_i == START_DECRYPTION_TOKEN) begin
            busy <= 1;
        end
        // se afiseaza caracterele secvential
        // caracterul j din output va fi
        // caracterul j*key_N - (key_N*key_M - 1)*k din vector
        // iar k-ul se va incrementa de fiecare data
        // cand s-au afisat cate key_M caractere
        else begin
            if(k == size - 1) begin
                busy <= 0;
                valid_o <= 0;
                k <= 0;
            end
            else begin
                // =
                k <= k + 1;
            end
            aux1 <= l;
            aux2 <= j;
            if(k == l) begin
                data_o <= data_reg[count_l];
                l <= l + 1;
            end
            else
            if(k == j) begin
                data_o <= data_reg[count_j];
                j <= j + 1;
            end
            else
                data_o <= 0;
            if(l != aux1)
                count_l <= count_l + 1;
            if(j != aux2)
                count_j <= count_j + 1;
            i <= 0;
        end
    end
    */
endmodule
