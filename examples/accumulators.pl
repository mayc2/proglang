
% Accumulator examples

increment(N0,N) :- N is N0 + 1.

square(N0,N) :- N is N0*N0.

inc_square(N0,N) :- increment(N0,N1), 
                    square(N1,N).

% Loop from 0 to N-1.  The accumulator is (M,N).

my_loop_from(N,N) :- !.
my_loop_from(M,N) :- M < N, write(M),nl,
                     M1 is M + 1,
                     my_loop_from(M1,N).

loop(N) :- my_loop_from(0,N).

% MergeSort

mergesort1(0,L,L,[]):-!.
mergesort1(1,[H|L],L,[H]):-!.
mergesort1(N,L0,L,Xs) :- NL is N // 2, 
                         NR is N - NL,
                         mergesort1(NL,L0,L1,Xs1),
			 mergesort1(NR,L1,L,Xs2),
			 merge(Xs1,Xs2,Xs).

mergesort(Xs,Ys):- length(Xs,N),
                   mergesort1(N,Xs,_,Ys).

% merge is already defined in Prolog, but here is a 
% possible definition:
merge1([],L,L) :- !.
merge1(L,[],L) :- !.
merge1([H1|T1],[H2|T2],[H1|L1]):- H1 =< H2, !,
                                  merge1(T1,[H2|T2],L1).
merge1([H1|T1],[H2|T2],[H2|L1]):- merge1([H1|T1],T2,L1).

