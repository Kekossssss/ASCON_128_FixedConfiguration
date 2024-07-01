//Author : Guilloux
//Module : Addition de constante Pc
//Last modified : 17/03/2024


import ascon_pack::*;


`timescale 1ns/1ps


module constant_addition 
(
	input type_state registerS_i,
	input logic [3:0] round_i,
	output type_state registerS_o
);
//Description de l'addition de constante
	assign registerS_o[0] = registerS_i[0];
	assign registerS_o[1] = registerS_i[1];
	//Addition
	assign registerS_o[2][63:8] = registerS_i[2][63:8];
	assign registerS_o[2][7:0] = registerS_i[2][7:0] ^ round_constant[round_i];
	assign registerS_o[3] = registerS_i[3];
	assign registerS_o[4] = registerS_i[4];
endmodule : constant_addition	
	
