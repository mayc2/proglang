natural(1).
natural(N) :- natural(M), N is M+1.

% myloop fails as a goal
myloop(N) :- N > 0, natural(I),
	write(I), nl,
	I = N, 
	!, fail.

%myloop2 succeeds as a goal
myloop2(N) :- N > 0, natural(I),
	write(I), nl,
	I = N, !.
myloop2(_).

% myevenloop(3) goes on infinite loop:
myevenloop(N) :- N > 0, natural(I),
	J is I mod 2, J = 0,
	write(I), nl,
	I = N, 
	!, fail.

% myevenloop2(3) gets to 4:
myevenloop2(N) :- N > 0, natural(I),
	J is I mod 2, J = 0,
	write(I), nl,
	I >= N, 
	!, fail.

% loop body should always succeed as a goal to be able to reach loop
% end condition, e.g.:
printeven(N) :- K is N mod 2, K = 0,
	        write(N), nl.
printeven(_).

myevenloop3(N) :- N > 0, natural(I),
	printeven(I),
	I = N, !.
myevenloop3(_).

% myloop fails as a goal: outer loop never reaches end condition!
nestedloop(N,M):-
	N>0,
	natural(I),
	write(I),nl,
	myloop(M),nl,
	I=N,
	!,fail.

nestedloop2(N,M):-
	N>0,
	natural(I),
	write(I),nl,
	myloop2(M),nl,
	I=N,!.
nestedloop2(_,_).
