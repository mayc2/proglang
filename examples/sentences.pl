% "Learn Prolog Now!"  Exercise 2.3

word(article,a). 
word(article,every). 
word(noun,criminal). 
word(noun,'big kahuna burger'). 
word(verb,eats). 
word(verb,likes). 

sentence(Word1,Word2,Word3,Word4,Word5):-
	word(article,Word1), 
	word(noun,Word2), 
	word(verb,Word3), 
	word(article,Word4), 
	word(noun,Word5). 

printsentences :-
	sentence(W1,W2,W3,W4,W5),
	write([W1,W2,W3,W4,W5]), nl,
	fail.

allsentences(L):-
	findall([W1,W2,W3,W4,W5],sentence(W1,W2,W3,W4,W5),L).
