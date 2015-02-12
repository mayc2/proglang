sum([],0).
sum([H|T], Total):-
	sum(T, S),
	Total is H+S.
circle(a,1).
circle(b,2).
circle(c,3).
circle(d,4).
circle(e,5).
circle(f,6).
circle(g,7).
circle(h,8).
circle(i,9).
side(A,B,C):-
	circle(A,X),
	circle(B,Y),
	circle(C,Z),
	X \== Y, X \==Z, Y \==Z,
	sum([X,Y,Z],S),
	S is 17.
puzzle(Solution):-
	side(A,B,D),
	side(A,C,F),
	side(D,E,F),
	side(D,G,I),
	side(I,H,F),
	A \== E, A \== G, A \== H, A \== I,
	B \== C, B \== E, B \== F, B \== G, B \== H, B \== I,
	C \== D, C \== E, C \== G, C \== H, C \== I,
	D \== F, E \== G, E \== H, E \== I, F \== G,
	Solution = [A,B,C,D,E,F,G,H,I].
