// Filename        : compteur_round.sv
// Description     : package definition
// Author          : Jean-Baptiste RIGAUD
// Created On      : Sat Oct 14 15:30:30 2023
// Last Modified By: Kévin GUILLOUX
// Last Modified On: Wed April 03 20:38:00 2024
// Update Count    : 1
// Status          : Unknown, Use with caution!

import ascon_pack::*;


`timescale 1 ns/ 1 ps


module compteur_round 
   (
    input logic 	clock_i,
    input logic 	resetb_i,
    input logic 	en_i,
    input logic 	init_p6_i,
    input logic 	init_p12_i,
    output logic [3 : 0] round_o      
    );

   logic [3:0] cpt_s;
   
   always_ff @(posedge clock_i or negedge resetb_i)
     begin
	if (resetb_i == 1'b0) begin
	   cpt_s <= 0;
	end
	else begin 
	   if (en_i == 1'b1) 
	     begin
		if (init_p12_i==1'b1) begin
		   cpt_s<=0;
		end 
		else if (init_p6_i==1'b1) begin
		   cpt_s<=6;
		end 
		else cpt_s <= cpt_s+1;
	     end
	end
     end
   assign round_o = cpt_s;
endmodule: compteur_round


