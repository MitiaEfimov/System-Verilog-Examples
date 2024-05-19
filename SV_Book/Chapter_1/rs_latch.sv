module rs_latch
	(input logic r, s,
	 output logic q, q_n);
	 
	 or #5  g1 (q, r, f2),
			  g2 (q_n, s, f1);
	 not	  g3 (f1, q),
			  g4 (f2, q_n);
endmodule: rs_latch