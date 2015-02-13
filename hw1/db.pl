:- [read_line].
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%grammar for the set of sentences
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%sentence end terminator
end --> ['.'].
q_end --> ['?'].

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

%Present Verbs
pres_verb(pres_verb(leave)) --> [leave].
pres_verb(pres_verb(fly)) --> [fly].
pres_verb(pres_verb(arrive)) --> [arrive].
pres_verb(pres_verb(stay)) --> [stay].

%Fillers -- "did not"
f1(f1(did)) --> [did].
f2(f2(not)) --> [not].

%Nominal
nom(nom(Word)) --> noun(Word).

%Verb Phrase, expects a verb
vp(vp(Word)) --> verb(Word).

%Noun Phrase, expects a determiner and noun
np(np(Word1,Word2)) --> det(Word1), nom(Word2).

%sentence, exepects a noun phrase and verb phrase
s(s(S,V)) --> np(np(S)), verb(verb(V)), end, convert(V,Nv), assert(mem(S,Nv)).

%convert past to present for easier comparison
convert(convert(left,N)) --> N = leave.
convert(convert(stayed,N)) --> N = fly.
convert(convert(flew,N)) --> N = arrive.
convert(convert(arrived,N)) --> N = stay.

%contra-sentence
cs(cs(S,V)) --> [did], np(np(S)), pres_verb(pres_verb(V)), q_end, solve(S,V,B), output(B).

%solve, and return yes ot no
solve(S,V,Bool):-
	mem(S,V), Bool is 1. 
solve(S,V,Bool):-
	Bool is 0,mem(S,V).

%output
output(0):- write(no).
output(1):- write(yes).	

%Check enables us to check for question or statement sentence
check(check(Tree)) --> s(Tree) | cs(Tree).

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
