:- [read_line].
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%grammar for the set of sentences
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%sentence end terminator
end --> ['.'].
q_end --> ['?'].

%Determiners
det(a) --> [a].
det(the) --> [the].
det(every) --> [every].

%Nouns
noun(noun(train)) --> [train].
noun(noun(flight)) --> [flight].
noun(noun(bike)) --> [bike].
noun(noun(person)) --> [person].

%Verbs- convert past to present
verb(verb(leave)) --> [left] | [leave].
verb(verb(stay)) --> [stayed] | [stay].
verb(verb(fly)) --> [flew] | [fly].
verb(verb(arrive)) --> [arrived] | [arrive].
 
%Name
name(name(Word)) --> [Word].
holder(h(the)) --> [the].
holder(h(the)) --> [a].

:- dynamic statement/3.
:- dynamic statement/4.

%sentence, exepects a noun phrase and verb phrase
sentence(s(D,S,N,V)) --> holder(D), noun(S), name(N), verb(V), end, {assert(statement(S,N,V))}.
sentence(s(D,S,N,V)) --> holder(D), noun(S), name(N), [did], [not], verb(V), end, {assert(statement(S,N,[not],V))}.

%question
question(cs(D,S,N,V)) --> [did], det(D), noun(S), verb(V), q_end, {solve(D,S,N,V,B), output(B)}.

%solve, and return yes or no
solve(D,S,N,V,Bool):-
	D = a,
	(statement(S,N,V), ! -> Bool is 1; Bool is 0).
solve(D,S,N,V,Bool):-
	D = every,
	(statement(S,N,[not],V), ! -> Bool is 0; Bool is 1).

%output
output(0):- write(no), nl.
output(1):- write(yes), nl.	

%Check enables us to check for question or statement sentence
check(check(Tree)) --> sentence(Tree) | question(Tree).

%Loop that parses sentences
loop:-
	read_line(Sentence),
	parse(_Tree,Sentence),
	loop.

%parse predicate
parse(Tree,Sentence):-
	phrase(check(Tree),Sentence).
