gen_numbers(0,[]) :- !.
gen_numbers(N,L):- M is N-1,
	gen_numbers(M,L1),
	append(L1,[N],L).