//Author : Guilloux
//Module : Tableau de la couche de substitution
//Last modified : 20/03/2024


import ascon_pack::*;


`timescale 1ns/1ps


module substitution_table
(
	input logic [4:0] data_i,
	output logic [4:0] data_o
);
//Logique de la table de substitution
	always_comb begin : subst1
		case (data_i)
			5'h00 : data_o = 5'h04;
			5'h01 : data_o = 5'h0b;
			5'h02 : data_o = 5'h1f;
			5'h03 : data_o = 5'h14;
			5'h04 : data_o = 5'h1a;
			5'h05 : data_o = 5'h15;
			5'h06 : data_o = 5'h09;
			5'h07 : data_o = 5'h02;
			5'h08 : data_o = 5'h1b;
			5'h09 : data_o = 5'h05;
			5'h0a : data_o = 5'h08;
			5'h0b : data_o = 5'h12;
			5'h0c : data_o = 5'h1d;
			5'h0d : data_o = 5'h03;
			5'h0e : data_o = 5'h06;
			5'h0f : data_o = 5'h1c;
			5'h10 : data_o = 5'h1e;
			5'h11 : data_o = 5'h13;
			5'h12 : data_o = 5'h07;
			5'h13 : data_o = 5'h0e;
			5'h14 : data_o = 5'h00;
			5'h15 : data_o = 5'h0d;
			5'h16 : data_o = 5'h11;
			5'h17 : data_o = 5'h18;
			5'h18 : data_o = 5'h10;
			5'h19 : data_o = 5'h0c;
			5'h1a : data_o = 5'h01;
			5'h1b : data_o = 5'h19;
			5'h1c : data_o = 5'h16;
			5'h1d : data_o = 5'h0a;
			5'h1e : data_o = 5'h0f;
			5'h1f : data_o = 5'h17;
		endcase
	end : subst1
endmodule : substitution_table

