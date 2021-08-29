`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:13:49 11/23/2020 
// Design Name: 
// Module Name:    decryption_regfile 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module decryption_regfile #(
			parameter addr_witdth = 8,
			parameter reg_width 	 = 16
		)(
			// Clock and reset interface
			input clk, 
			input rst_n,
			
			// Register access interface
			input[addr_witdth - 1:0] addr,
			input read,
			input write,
			input [reg_width -1 : 0] wdata,
			output reg [reg_width -1 : 0] rdata,
			output reg done,
			output reg error,
			
			// Output wires
			output reg[reg_width - 1 : 0] select,
			output reg[reg_width - 1 : 0] caesar_key,
			output reg[reg_width - 1 : 0] scytale_key,
			output reg[reg_width - 1 : 0] zigzag_key
    );

// TODO implementati bancul de registre.
    // declararea celor 4 registre pe 16 biti
	reg[reg_width - 1 : 0] select_register, caesar_key_register;
	reg[reg_width - 1 : 0] scytale_key_register, zigzag_key_register;
	
	// se va citi si scrie din/in registre sincron
	always @(posedge clk) begin
	    // initializare done si error
        error <= 0;
        done <= 0;
        // valorile registrelor se reseteaza cand e pus reset pe 0
		if(!rst_n) begin
			select_register <= 16'h0;
			caesar_key_register <= 16'h0;
			scytale_key_register <= 16'hFFFF;
			zigzag_key_register <= 16'h2;
		end
		else 
		// cand nu e pus reset-ul si write e pus pe 1
		// se scrie in registre
		if(write) begin
		   // se poate scrie doar la cele 4 adrese ale registrelor 
	       case(addr)
	           // se scrie in select_register si se pune done pe 1
	           16'h0: begin
	               select_register[1:0] <= wdata;
	               done <= 1;
	           end
	           // se scrie in caesar_key_register si se pune done pe 1
	           16'h10: begin
	               caesar_key_register <= wdata;
	               done <= 1;
	           end
	           // se scrie in scytale_key_register si se spune done pe 1
	           16'h12: begin
	               scytale_key_register <= wdata;
	               done <= 1;
	           end
	           // se scrie in zigzag_key_register si se pune done pe 1
	           16'h14: begin
	               zigzag_key_register <= wdata;
	               done <= 1;
	           end
	           // nu se scrie daca adresa nu e niciuna din cele 4
	           // si se activeaza error si done
	           default: begin 
	               error <= 1; 
	               done <= 1;
	           end
	       endcase
	   end 
	   else 
	   // cand nu e pus reset-ul si read e pus pe 1
	   // se citeste din registre
	   if(read) begin
	       // se poate citi doar de la cele 4 adrese ale registrelor 
	       case(addr)
	           // se citeste din select_register si se pune done pe 1
	           16'h0: begin
	               rdata <= select_register;
	               done <= 1;
	           end
	           // se citeste din caesar_key_register si se pune done pe 1
	           16'h10: begin
	               rdata <= caesar_key_register;
	               done <= 1;
	           end
	           // se citeste din scytale_key_register si se pune done pe 1
               16'h12: begin
	               rdata <= scytale_key_register;
	               done <= 1;
	           end
	           // se citeste din zigzag_register si se pune done pe 1
	           16'h14: begin
	               rdata <= zigzag_key_register;
	               done <= 1;
	           end
	           // nu se citeste daca adresa nu e una din cele 4
	           // si se activeaza error si done
	           default: begin
	               error <= 1;
	               done <= 1;
	           end
	       endcase
	   end
    end
    // se vor asigna asincron valorile din registre iesirilor
    // doar primii 2 biti din select_register
	always @(*) begin
	   select = select_register[1:0];
       caesar_key = caesar_key_register;
	   scytale_key = scytale_key_register;
	   zigzag_key = zigzag_key_register;
	end
endmodule
