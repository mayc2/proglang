:- [read_line].
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%grammar for the set of sentences
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%sentence end terminator
end --> ['.'].

%Determiners
det(det(a)) --> [a].
det(det(the)) --> [the].
det(det(every)) --> [every].

%Nouns
noun(noun(train)) --> [train].
noun(noun(flight)) --> [flight].
noun(noun(bike)) --> [bike].
noun(noun(person)) --> [person].

%Verbs
verb(verb(left)) --> [left].
verb(verb(stayed)) --> [stayed].
verb(verb(flew)) --> [flew].
verb(verb(arrived)) --> [arrived].

%Nominal
nom(nom(Word)) --> noun(Word).

%Verb Phrase, expects a verb
vp(vp(Word)) --> verb(Word).

%Noun Phrase, expects a determiner and noun
np(np(Word1,Word2)) --> det(Word1), nom(Word2).

%sentence, exepects a noun phrase and verb phrase
s(s(S,V)) --> np(S), vp(V), end.

%Loop that parses sentences
loop:-
	read_line(Sentence),
	parse(Tree,Sentence),
	write(Tree),
	nl,
	loop.

%parse predicate
parse(Tree,Sentence):-
	phrase(s(Tree),Sentence).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extra credit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
loop_r:-
	read_line(Sentence),
	parse(Tree,Sentence),
	reverse(Tree,Reversed),
	write(Reversed),
	nl,
	loop_r.


reverse(Tree,Reversed):-
	phrase(reverse(Tree),Reversed).
reverse([]) --> [].
reverse([H|T]) --> reverse(T), [H].
