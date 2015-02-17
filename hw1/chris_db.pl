:- [read_line].
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%grammar for the set of sentences
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%sentence end terminator
end --> ['.'].
q_end --> ['?'].

%Determiners
determiner(det(a)) --> [a].
determiner(det(the)) --> [the].
determiner(det(every)) --> [every].

%Nouns
noun(n(train)) --> [train].
noun(n(flight)) --> [flight].
noun(n(bike)) --> [bike].
noun(n(person)) --> [person].

%Name predicate
name(na(N)) --> [N]. 

%Verbs
verb(v(leave)) --> [left].
verb(v(stay)) --> [stayed].
verb(v(fly)) --> [flew].
verb(v(arrive)) --> [arrived].

%Present Verbs
verb(v(leave)) --> [leave].
verb(v(fly)) --> [fly].
verb(v(arrive)) --> [arrive].
verb(v(stay)) --> [stay].

%Nominal
nominal(nom(Word)) --> noun(Word).

%Verb Phrase, expects a verb
verb_phrase(vp(Word)) --> verb(Word).

%Noun Phrase, expects a determiner and noun
noun_phrase(np(Word1,Word2)) --> determiner(Word1), nominal(Word2).

%database save
holder(h(the)) --> [the].
holder(h(the)) --> [a].
not(not(did)) --> [did].
not(not('did not')) --> [not].
database(db(D,S,N,C,V)) --> holder(h(D)), noun(S), name(N), not(C), verb(V).
%sentence, exepects a noun phrase, name, and verb phrase
sentence(s(D,S,N,V)) --> 
	determiner(det(D)), noun(n(S)), name(na(N)), verb(v(V)), end, 
	{
		assert(database(the,S,N,did,V))
	}.
sentence(s(D,S,N,V)) --> 
	determiner(det(D)), noun(n(S)), name(na(N)), [did], [not], verb(v(V)), end, 
	{
		assert(database(the,S,N,'did not',V))
	}.

%Question
question(q(D,S,V)) --> 
	[did], determiner(det(D)), noun(n(S)), verb(v(V)), q_end, 
	{
		solve(D,S,V)
	}.

%solve
solve(D,S,V):-
	D = every,
	(database(the,S,_,[not],V),! -> X is 0, X is 1).
solve(D,S,V):-
	D = a, 
	(database(the,S,_,did,V),! -> X is 1; X is 0),
%	findall(C,database(the,S,_,C,V),L),
%	value(L,X),
	output(X).
% = true -> 
%		value(L,X);
%		X is 0
%	), 
%	output(X).

value([],0).
value([H|T],N):-
	write(H),
	(T = [] -> (H \= did -> N is 0; N is 1)),
	(H =:= [did] -> write('changing n to 1'); value(T,N)).

%value(did,1).
%value('did not',0).

%output
output(0):- nl, write('no').
output(1):- nl, write('yes').	

%Check enables us to check for question or statement sentence
check(check(Tree)) --> sentence(Tree) | question(Tree).

%Loop that parses sentences
loop:-
	read_line(Sentence),
	parse(Tree,Sentence),
	write(Tree),
	nl,
	loop.

%parse predicate
parse(Tree,Sentence):-
	phrase(check(Tree),Sentence).
