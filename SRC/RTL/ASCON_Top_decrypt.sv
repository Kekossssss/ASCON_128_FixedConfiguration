//Author : Guilloux
//Module : Module regroupant les différents composants (Module finale du projet)
//Last modified : 15/04/2024


import ascon_pack::*;


`timescale 1ns/1ps


module ASCON_Top_decrypt
(
	//Clock et reset du module
	input logic clk_i,
	input logic rst_i,
	//Entrees logiques
	input logic start_i,
	input logic cipher_valid_i,
	//Entrees de valeurs
	input logic [63:0] cipher_i,
	input logic [127:0] key_i,
	input logic [127:0] nonce_i,
	//Sorties logiques
	output logic end_o,
	output logic data_valid_o,
	//Sorties de valeurs
	output logic [63:0] data_o,
	output logic [127:0] tag_o
);
// Description des connexions internes
	//Connectiques de controles internes
	logic sel_mux_perm_s;
	logic sel_muxData_perm_s;
	logic write_enable_data_s;
	logic write_enable_cipher_s;
	logic write_enable_tag_s;
	logic en_xor_begin_data_s;
	logic en_xor_begin_key_s;
	logic en_xor_end_lsb_s;
	logic en_xor_end_key_s;
	logic en_cpt_round_s;
	logic init_p6_s;
	logic init_p12_s;
	logic en_cpt_bloc_s;
	logic init_bloc_s;
	//Connectiques de valeurs/donnees internes
	logic [3:0] round_s;
	logic [1:0] bloc_s;
	type_state registerS_s;       //<----Utile uniquement pour l'initialisation
//Initialisation des différents blocs
	//Bloc de la Machine d'Etats Finis (FSM)
	FSM_decrypt FSM (
		.clk_i(clk_i),
		.rst_i(rst_i),
		.start_i(start_i),
		.cipher_valid_i(cipher_valid_i),
		.round_i(round_s),
		.bloc_i(bloc_s),
		.en_cpt_round_o(en_cpt_round_s),
		.en_cpt_bloc_o(en_cpt_bloc_s),
		.init_p6_o(init_p6_s),
		.init_p12_o(init_p12_s),
		.init_bloc_o(init_bloc_s),
		.sel_mux_perm_o(sel_mux_perm_s),
		.sel_muxData_perm_o(sel_muxData_perm_s),
		.write_enable_data_o(write_enable_data_s),
		.write_enable_cipher_o(write_enable_cipher_s),
		.write_enable_tag_o(write_enable_tag_s),
		.en_xor_begin_data_o(en_xor_begin_data_s),
		.en_xor_begin_key_o(en_xor_begin_key_s),
		.en_xor_end_lsb_o(en_xor_end_lsb_s),
		.en_xor_end_key_o(en_xor_end_key_s),
		.end_o(end_o),
		.data_valid_o(data_valid_o)
	);
	//Bloc de permutations et XOR
	permutationBloc_decrypt PermXOR (
		//Entrées de données (S,P,K)
		.registerS_i(registerS_s),
		.cipher_i(cipher_i),
		.key_i(key_i),
		//Différentes entrées de sélections
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
		//Clock et reset
		.clk_i(clk_i),
		.rst_i(rst_i),
		//Sorties de données (S,C,T)
		.data_o(data_o),
		.tag_o(tag_o)
	);
	//Bloc du compteur de round
	compteur_round CptRound (
		.clock_i(clk_i),
		.resetb_i(rst_i),
		.en_i(en_cpt_round_s),
		.init_p6_i(init_p6_s),
		.init_p12_i(init_p12_s),
		.round_o(round_s)
	);
	//Bloc du compteur de blocs
	compteur_blocs CptBlocs (
		.clock_i(clk_i),
    		.resetb_i(rst_i),
    		.en_i(en_cpt_bloc_s),
    		.init_bloc_i(init_bloc_s),
    		.bloc_o(bloc_s)
	);
//Initialisation de la connectique de travail data_s (La connectique de 320 bits)
	assign registerS_s[0] = 64'h80400C0600000000;
	assign registerS_s[1] = key_i[127:64];
	assign registerS_s[2] = key_i[63:0];
	assign registerS_s[3] = nonce_i[127:64];
	assign registerS_s[4] = nonce_i[63:0];
endmodule : ASCON_Top_decrypt
	
