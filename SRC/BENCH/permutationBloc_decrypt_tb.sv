//Author : Guilloux
//Module : Test Bench de la permutation avec les XOR en etrée et sortie
//Last modified : 02/04/2024


import ascon_pack::*;


`timescale 1ns/1ps


module permutationBloc_decrypt_tb ();
	//Initialisation des broches de connexion du test bench
	//Entrées de données du module (S,P,K)
	type_state registerS_i_s;
	logic [63:0] cipher_s;
	logic [127:0] key_s;
	//Différentes entrées de sélections du module
	logic sel_mux_perm_s;
	logic sel_muxData_perm_s;
	logic [3:0] round_s;
	logic write_enable_data_s;
	logic write_enable_cipher_s;
	logic write_enable_tag_s;
	logic en_xor_begin_data_s;
	logic en_xor_begin_key_s;
	logic en_xor_end_lsb_s;
	logic en_xor_end_key_s;
	//Clock et reset
	logic clk_s = 1'b1;
	logic rst_s;
	//Sorties de données du module (S,C,T)
	logic [63:0] data_s;
	logic [127:0] tagout_s;
	//Instanciation du composant
	permutationBloc_decrypt DUT (
		.registerS_i(registerS_i_s),
		.cipher_i(cipher_s),
		.key_i(key_s),
		.sel_mux_perm_i(sel_mux_perm_s),
		.sel_muxData_perm_i(sel_muxData_perm_s),
		.round_i(round_s),
		.write_enable_data_i(write_enable_data_s),
		.write_enable_cipher_i(write_enable_cipher_s),
		.write_enable_tag_i(write_enable_tag_s),
		.en_xor_begin_data_i(en_xor_begin_data_s),
		.en_xor_begin_key_i(en_xor_begin_key_s),
		.en_xor_end_lsb_i(en_xor_end_lsb_s),
		.en_xor_end_key_i(en_xor_end_key_s),
		.clk_i(clk_s),
		.rst_i(rst_s),
		.data_o(data_s),
		.tag_o(tagout_s)
	);
	genvar i;
	//Initialisation de la clock
	always begin
		assign  clk_s = ~clk_s;
     		#10;
   	end
	//Debut du test du composant
	initial begin
		registerS_i_s[0] = 64'h80400c0600000000;
		registerS_i_s[1] = 64'h8a55114d1cb6a9a2;
		registerS_i_s[2] = 64'hbe263d4d7aecaaff;
		registerS_i_s[3] = 64'h4ed0ec0b98c529b7;
		registerS_i_s[4] = 64'hc8cddf37bcd0284a;
		key_s = 128'h8a55114d1cb6a9a2be263d4d7aecaaff;
		cipher_s = 64'h4120746F20428000;
		rst_s = 1'b0;
		sel_mux_perm_s = 1'b0;
		sel_muxData_perm_s = 1'b0;
		round_s = 4'h0;
		write_enable_data_s = 1'b1;
		write_enable_cipher_s = 1'b0;
		write_enable_tag_s = 1'b0;
		en_xor_begin_data_s = 1'b0;
		en_xor_begin_key_s = 1'b0;
		en_xor_end_lsb_s = 1'b0;
		en_xor_end_key_s = 1'b0;
		#105;
		rst_s = 1'b1;
		#20;
		sel_mux_perm_s = 1'b1;
		round_s = 4'h1;
		#20;
		round_s = 4'h2;
		#20;
		round_s = 4'h3;
		#20;
		round_s = 4'h4;
		#20;
		round_s = 4'h5;
		#20;
		round_s = 4'h6;
		#20;
		round_s = 4'h7;
		#20;
		round_s = 4'h8;
		#20;
		round_s = 4'h9;
		#20;
		round_s = 4'ha;
		#20;
		round_s = 4'hb;
		en_xor_end_key_s = 1'b1;
		#20;
		round_s = 4'h6;
		en_xor_begin_data_s = 1'b1;
		en_xor_end_key_s = 1'b0;
		write_enable_cipher_s = 1'b1;
		#20;
		write_enable_cipher_s = 1'b0;
		write_enable_data_s = 1'b0;
		en_xor_begin_data_s = 1'b0;
	end
endmodule : permutationBloc_decrypt_tb	
