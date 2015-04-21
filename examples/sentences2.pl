% "Learn Prolog Now!"  Exercise 2.3
% Rewritten using Definite Clause Grammar rules

sentence --> article, noun, verb, article, noun.
article --> [a] | [every].
noun --> [criminal] | ['big kahuna burger'].
verb --> [eats] | [likes].

