not(P):- call(P), !, fail.
not(P).

:- dynamic why/1.

not2(P) :- call(P), assert(why(P)), !, fail.
not2(P).

