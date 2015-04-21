
%
%%% Sequence Combinators
%

% Normal order sequencing combinator, Z should not appear free in Y

declare Seq = fun {$ X Y} { fun {$ Z} Y end X } end

declare Display = fun {$ X}
		     {Browse X}
		     X
		  end

declare X = {Seq {Display 1} {Display 2}}

% Let us attempt to create a reverse sequencing combinator:

declare RSeq = fun {$ X Y} { fun {$ Z} X end Y } end

declare X = {RSeq {Display 3} {Display 4}}

% Exercise: why does the normal order sequencing combinator not work
% in an applicative order (call by value) language?

%
% Applicative order Reverse Sequencing combinator
%
declare ARSeq = fun {$ X Y} { fun {$ Z} {X} end {Y} } end

declare X = {ARSeq fun {$} {Display 3} end
	           fun {$} {Display 4} end}
% the use of functions with no arguments (also called "thunks") to
% wrap (and delay the evaluation of) expressions enables us to
% simulate call by name in a call by value language.

%
% Applicative order Reverse Sequencing combinator
%
declare ARSeq2 = fun {$ X Y} { fun {$ Z} {X} end Y } end

declare X = {ARSeq2 fun {$} {Display 3} end
	           {Display 4}}

