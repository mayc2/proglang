append([],L,L).
append([H|T],A,[H|L]) :- append(T,A,L).
