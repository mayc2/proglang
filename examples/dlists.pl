
% Difference Lists

append_dl(S1,E1,S2,E2,S1,E2) :- E1=S2.

dl2list(X,Y,[]):- X == Y, !.
dl2list([H|T],E,[H|L]):-dl2list(T,E,L).

