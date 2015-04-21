natural(1).
natural(N) :- natural(M), N is M+1.

myloop(N) :- N > 0, natural(I),
	write(I), nl,
	I = N, 
	!, fail.

myloop2(N) :- N > 0, natural(I), I=<N,
	write(I), nl,
	I = N, !.
