:- [read_line].
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%grammar for the set of sentences
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
s(np(W,W1),Phrase2):-
	vp(Phrase2).

%Loop that parses sentences
lopp:-
	read_line(Sentence),
