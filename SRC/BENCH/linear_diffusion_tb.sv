//Author : Guilloux
//Module : Test bench de la couche de diffusion linéaire
//Last modified : 20/03/2024

import ascon_pack::*;

`timescale 1ns/1ps

module linear_diffusion_tb ();
	type_state registerS_i_s;
	type_state registerS_o_s;
	//Instanciation du composant
	linear_diffusion DUT (
		registerS_i_s,registerS_o_s);
	//Stimuli de test
	initial begin
		//Initialisation de la data
		registerS_i_s[0] = 64'h78e2cc41faabaa1a;
		registerS_i_s[1] = 64'hbc7a2e775aababf7;
		registerS_i_s[2] = 64'h4b81c0cbbdb5fc1a;
		registerS_i_s[3] = 64'hb22e133e424f0250;
		registerS_i_s[4] = 64'h044d33702433805d;
		//Pause de 50ns
		#50;
		//Reinitialisation de la data pour 2nd test
		registerS_i_s[0] = 64'h1642cee0845634e5;
		registerS_i_s[1] = 64'h17397d1b2a296525;
		registerS_i_s[2] = 64'h49dbe29ab8516baf;
		registerS_i_s[3] = 64'h110e5ecc42a8a463;
		registerS_i_s[4] = 64'hb16f79e94eb17171;
	end
endmodule : linear_diffusion_tb
