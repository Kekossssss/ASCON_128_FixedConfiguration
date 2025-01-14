//Author : Guilloux
//Module : Bloc de permutation pour le decryptage
//Last modified : 01/04/2024


import ascon_pack::*;


`timescale 1ns/1ps


module permutationBloc_decrypt
(
	//Entrées de données (S,P,K)
	input type_state registerS_i,
	input logic [63:0] cipher_i,
	input logic [127:0] key_i,
	//Différentes entrées de sélections
	input logic sel_mux_perm_i,
	input logic sel_muxData_perm_i,
	input logic [3:0] round_i,
	input logic write_enable_data_i,
	input logic write_enable_cipher_i,
	input logic write_enable_tag_i,
	input logic en_xor_begin_data_i,
	input logic en_xor_begin_key_i,
	input logic en_xor_end_lsb_i,
	input logic en_xor_end_key_i,
	//Clock et reset
	input logic clk_i,
	input logic rst_i,
	//Sorties de données (S,C,T)
	output logic [63:0] data_o,
	output logic [127:0] tag_o
);
//Description des connexions internes
	type_state registerS_s;
	logic [63:0] data_s;
	logic [127:0] tag_s;
	type_state mux_to_xorbegin_s;
	type_state xorbegin_to_muxData_s;
	type_state muxData_to_cst_s;
	type_state cst_to_sub_s;
	type_state sub_to_lin_s;
	type_state lin_to_xorend_s;
	type_state xorend_to_reg_s;
//Initialisation des différents blocs
	////Initialisation du multiplexeur
	mux_state Mux1 (
		sel_mux_perm_i, registerS_i, registerS_s, mux_to_xorbegin_s
	);
	////Initialisation du xor begin
	xor_begin_perm XorBegin (
		en_xor_begin_data_i, en_xor_begin_key_i, key_i, cipher_i, mux_to_xorbegin_s, xorbegin_to_muxData_s
	);
	////Initialisation du multiplexeur pour le remplacement de la donnée chiffrée
	mux_state MuxData (
		sel_muxData_perm_i, xorbegin_to_muxData_s, {cipher_i,xorbegin_to_muxData_s[1],xorbegin_to_muxData_s[2],xorbegin_to_muxData_s[3],xorbegin_to_muxData_s[4]}, muxData_to_cst_s
	);
	////Initialisation de l'addition de constante
	constant_addition Cst1 (
		muxData_to_cst_s, round_i, cst_to_sub_s
	);
	////Initialisation de la couche de substitution
	substitution_cover Sub1 (
		cst_to_sub_s, sub_to_lin_s
	);
	////Initialisation de la couche de diffusion linéaire
	linear_diffusion Lin1 (
		sub_to_lin_s, lin_to_xorend_s
	);
	////Initialisation du xor end
	xor_end_perm XorEnd (
		en_xor_end_lsb_i, en_xor_end_key_i, key_i, lin_to_xorend_s, xorend_to_reg_s
	);
	////Initialisation des registres de sortie
	//Initialisation de la sortie de data
	state_register_w_en RegData (
		clk_i, rst_i, write_enable_data_i, xorend_to_reg_s, registerS_s
	);
	//Initialisation de la sortie du mot chiffre
	register_w_en #(64) RegMot (
		clk_i, rst_i, write_enable_cipher_i, xorbegin_to_muxData_s[0], data_s
	);
	//Initialisation de la sortie du tag
	register_w_en #(128) RegTag (
		clk_i, rst_i, write_enable_tag_i, {xorend_to_reg_s[3],xorend_to_reg_s[4]}, tag_s
	);
//Mise a jour de la valeur de sortie sur la sortie du registre de data
	assign data_o = data_s;
	assign tag_o = tag_s;
endmodule : permutationBloc_decrypt
				
