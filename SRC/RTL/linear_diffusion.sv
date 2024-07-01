//Author : Guilloux
//Module : Couche de diffusion lineaire
//Last modified : 20/03/2024


import ascon_pack::*;


`timescale 1ns/1ps


module linear_diffusion
(
	input type_state registerS_i,
	output type_state registerS_o
);
//Description des opérations de décalage des bits
	assign registerS_o[0] = registerS_i[0] ^ {registerS_i[0][18:0],registerS_i[0][63:19]} ^ {registerS_i[0][27:0],registerS_i[0][63:28]};
	assign registerS_o[1] = registerS_i[1] ^ {registerS_i[1][60:0],registerS_i[1][63:61]} ^ {registerS_i[1][38:0],registerS_i[1][63:39]};
	assign registerS_o[2] = registerS_i[2] ^ {registerS_i[2][0],registerS_i[2][63:1]} ^ {registerS_i[2][5:0],registerS_i[2][63:6]};
	assign registerS_o[3] = registerS_i[3] ^ {registerS_i[3][9:0],registerS_i[3][63:10]} ^ {registerS_i[3][16:0],registerS_i[3][63:17]};
	assign registerS_o[4] = registerS_i[4] ^ {registerS_i[4][6:0],registerS_i[4][63:7]} ^ {registerS_i[4][40:0],registerS_i[4][63:41]};
endmodule : linear_diffusion
