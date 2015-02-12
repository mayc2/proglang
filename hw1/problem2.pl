:- [read_line].

noun(train) --> [train].
noun(bike) --> [bike].
noun(flight) --> [flight].
noun(person) --> [person].

verb(flew) --> [flew].
verb(left) --> [left].
verb(arrived) --> [arrived].
verb(stayed) --> [stayed].

det(a) --> [a].
det(the) --> [the].
det(every) --> [every].

sentence(X,Y)  --> np(X), vp(Y), end.
np(X,Y) --> det(X), nom(Y).
nom(X) --> noun(X).

vp(X) --> verb(X).

end --> ['.'].

parse(Sentence) :- phrase(sentence(Sentence),Sentence).
check_input :- read_line(Sent),parse(Sent),write(Sent).

% parse(Tree,Sentence) :- phrase(sentence(Tree),Sentence).
% check_input :- read_line(Sent),parse(Tree,Sent),write(Tree).