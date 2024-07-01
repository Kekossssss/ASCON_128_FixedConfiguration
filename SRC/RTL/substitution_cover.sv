//Author : Guilloux
//Module : Couche de substitution
//Last modified : 17/03/2024


import ascon_pack::*;


`timescale 1ns/1ps


module substitution_cover 
(
	input type_state registerS_i,
	output type_state registerS_o
);
//Description du tableau de substitution
	genvar i;
	generate
		for (i=0;i<64;i++) begin : subst1
			substitution_table replacer (
				{registerS_i[0][i],registerS_i[1][i],registerS_i[2][i],registerS_i[3][i],registerS_i[4][i]},{registerS_o[0][i],registerS_o[1][i],registerS_o[2][i],registerS_o[3][i],registerS_o[4][i]});
		end : subst1
	endgenerate
endmodule : substitution_cover

