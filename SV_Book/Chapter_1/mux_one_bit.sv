module mux_one_bit
	(output logic f,
	 input logic a, b, sel);
	
	and #2	g1 (f1, a, n_sel), 
				g2 (f2, b, sel);
	or #2		g3	(f, f1, f2);
	not 		g4 (n_sel, sel);
endmodule