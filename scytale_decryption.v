`timescale 1ns / 1ps

module scytale_decryption #(
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
			input[KEY_WIDTH - 1 : 0] key_N,
			input[KEY_WIDTH - 1 : 0] key_M,
			
			// Output interface
			output reg[D_WIDTH - 1:0] data_o,
			output reg valid_o,
			output reg busy
    );
// TODO: Implement Scytale Decryption here
    // declar un vector de maxim 50 de caractere
    reg[7:0] data_reg [0 : MAX_NOF_CHARS - 1];
    reg[7:0] i, j, k, count;
    // logica e secventiala
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
            j <= -1;
            k <= 0;
            count <= -1;
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
            if(j == key_N*key_M - 1) begin
                busy <= 0;
                valid_o <= 0;
                j <= 0;
            end
            else begin
                // =
                j <= j + 1;
            end
            // count se reseteaza de fiecare data
            // cand s-au facut key_M afisari
            if(count == key_M - 1) begin
                // =
                k <= k + 1;
                count <= 0;
            end
            else begin
                count <= count + 1;
            end
            if(k < key_N)
                data_o <= data_reg[j*key_N - (key_N*key_M - 1)*k];  
            else
                data_o <= 0;
            i <= 0;
        end
    end
endmodule

