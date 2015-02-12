:- [read_line].
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%grammar for the set of sentences
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%sentence end terminator
end('.').

%Determiners
det(a).
det(the).
det(every).

%Nouns
noun(train).
noun(flight).
noun(bike).
noun(person).

%Verbs
verb(left).
verb(stayed).
verb(flew).
verb(arrived).

%Nominal
nom(Word):-
	noun(Word).

%Verb Phrase, expects a verb
vp(Word):-
	verb(Word).

%Noun Phrase, expects a determiner and noun
np(Word1,Word2):-
	det(Word1),
	nom(Word2).

%sentence, exepects a noun phrase and verb phrase
s(Phrase1,Phrase2):-
	np(Phrase1),
	vp(Phrase2),
	end.

%Loop that parses sentences
loop:-
	read_line(Sentence),
