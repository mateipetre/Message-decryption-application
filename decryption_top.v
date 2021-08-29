`timescale 1ns / 1ps

module decryption_top#(
			parameter addr_witdth = 8,
			parameter reg_width  = 16,
			parameter MST_DWIDTH = 32,
			parameter SYS_DWIDTH = 8
		)(
		// Clock and reset interface
		input clk_sys,
		input clk_mst,
		input rst_n,
		
		// Input interface
		input [MST_DWIDTH -1 : 0] data_i,
		input 					  valid_i,
		output busy,
		
		//output interface
		output [SYS_DWIDTH - 1 : 0] data_o,
		output      				valid_o,
		
		// Register access interface
		input[addr_witdth - 1:0] addr,
		input read,
		input write,
		input [reg_width - 1 : 0] wdata,
		output [reg_width - 1 : 0] rdata,
		output done,
		output error
		
    );
	
	
	// TODO: Add and connect all Decryption blocks
	wire [reg_width - 1 : 0] select, caesar_key, scytale_key, zigzag_key;
	wire [SYS_DWIDTH - 1 : 0] data0_o, data1_o, data2_o;
	wire valid0_o, valid1_o, valid2_o;
	wire busy0, busy1, busy2;
	wire [SYS_DWIDTH - 1 : 0] data_o_0, data_o_1, data_o_2;
	wire valid_o_0, valid_o_1, valid_o_2;
	
	decryption_regfile dr(clk_sys, rst_n, addr, read, write, wdata, rdata, done, error, select, caesar_key, scytale_key, zigzag_key);
    demux d(clk_sys, clk_mst, rst_n, select[1:0], data_i, valid_i, data0_o, valid0_o, data1_o, valid1_o, data2_o, valid2_o);
    caesar_decryption cd(clk_sys, rst_n, data0_o, valid0_o, caesar_key, busy0, data_o_0, valid_o_0);
    scytale_decryption sd(clk_sys, rst_n, data1_o, valid1_o, scytale_key[15:8], scytale_key[7:0], data_o_1, valid_o_1, busy1);
    zigzag_decryption zd(clk_sys, rst_n, data2_o, valid2_o, zigzag_key[7:0], busy2, data_o_2, valid_o_2);
    mux m(clk_sys, rst_n, select[1:0], data_o, valid_o, data_o_0, valid_o_0, data_o_1, valid_o_1, data_o_2, valid_o_2);
    assign busy = busy0 | busy1 | busy2;
    
endmodule
