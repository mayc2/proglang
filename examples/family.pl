male(carlos).
parent(carlos, tatiana). 
parent(carlos, catalina). 
father(X,Y) :- parent(X,Y), male(X).
sibling(X,Y) :- parent(Z,X), parent(Z,Y), X \= Y.