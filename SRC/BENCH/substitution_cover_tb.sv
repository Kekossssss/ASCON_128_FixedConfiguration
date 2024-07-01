//Author : Guilloux
//Module : Test bench de la couche de substitution
//Last modified : 20/03/2024

import ascon_pack::*;

`timescale 1ns/1ps

module substitution_cover_tb ();
	type_state registerS_i_s;
	type_state registerS_o_s;
	//Instanciation du composant
	substitution_cover DUT (
		registerS_i_s,registerS_o_s);
	//Stimuli de test
	initial begin
		//Initialisation de la registerS_i
		registerS_i_s[0] = 64'h80400c0600000000;
		registerS_i_s[1] = 64'h8a55114d1cb6a9a2;
		registerS_i_s[2] = 64'hbe263d4d7aecaa0f;
		registerS_i_s[3] = 64'h4ed0ec0b98c529b7;
		registerS_i_s[4] = 64'hc8cddf37bcd0284a;
		//Pause de 50ns
		#50;
		//Reinitialisation de la registerS_i pour 2nd test
		registerS_i_s[0] = 64'ha71b22fa2d0f5150;
		registerS_i_s[1] = 64'hb11e0a9a608e0016;
		registerS_i_s[2] = 64'h076f27ad4d99d506;
		registerS_i_s[3] = 64'ha72ac1ad8440b0b7;
		registerS_i_s[4] = 64'h0657b0d6eaf9c1c4;
	end
endmodule : substitution_cover_tb
