//Author : Guilloux
//Module : TestBench du module regroupant les différents composants (Module finale du projet)
//Last modified : 13/04/2024


import ascon_pack::*;


`timescale 1ns/1ps


module ASCON_Top_decrypt_tb ();
//Description des connectiques du module
	//Clock et reset du module
	logic clk_s = 1'b1;
	logic rst_s = 1'b0;
	//Entrees logiques
	logic start_s;
	logic cipher_valid_s;
	//Entrees de valeurs
	logic [63:0] cipher_s;
	logic [127:0] key_s;
	logic [127:0] nonce_s;
	//Sorties logiques
	logic end_s;
	logic data_valid_s;
	//Sorties de valeurs
	logic [63:0] data_s;
	logic [127:0] tag_s;
//Instanciation du composant
	ASCON_Top_decrypt DUT (
		//Clock et reset du module
		.clk_i(clk_s),
		.rst_i(rst_s),
		//Entrees logiques
		.start_i(start_s),
		.cipher_valid_i(cipher_valid_s),
		//Entrees de valeurs
		.cipher_i(cipher_s),
		.key_i(key_s),
		.nonce_i(nonce_s),
		//Sorties logiques
		.end_o(end_s),
		.data_valid_o(data_valid_s),
		//Sorties de valeurs
		.data_o(data_s),
		.tag_o(tag_s)
	);
//Initialisation de la clock
	always begin
		assign  clk_s = ~clk_s;
     		#10;
   	end
//Debut du test du composant
	initial begin
		start_s = 1'b0;
		cipher_valid_s = 1'b0;
		key_s = 128'h8A55114D1CB6A9A2BE263D4D7AECAAFF;
		nonce_s = 128'h4ED0EC0B98C529B7C8CDDF37BCD0284A;
		#105;
		rst_s = 1'b1;
		#20;
		start_s = 1'b1;
		#20;
		start_s = 1'b0;
		#240;
		//Entree de A
		cipher_s = 64'h4120746F20428000;
		cipher_valid_s = 1'b1;
		#60;
		cipher_valid_s = 1'b0;
		#100;
		//Entree de P1
		cipher_s = 64'h280B24434ED6562A;
		cipher_valid_s = 1'b1;
		#60;
		cipher_valid_s = 1'b0;
		#100;
		//Entree de P2
		cipher_s = 64'h3DB788372D54E22E;
		cipher_valid_s = 1'b1;
		#60;
		cipher_valid_s = 1'b0;
		#80;
		//Entree de P3
		cipher_s = 64'h62915709271AF8ec;
		cipher_valid_s = 1'b1;
		#60;
		cipher_valid_s = 1'b0;
	end
endmodule : ASCON_Top_decrypt_tb
		
