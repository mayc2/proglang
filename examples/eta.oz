%
% Eta-conversion
%
declare Increment = fun {$ X} X+1 end

{Browse {Increment 5}}

declare Inc = fun {$ X} {Increment X} end

{Browse {Inc 6}}

% Inc can be simplified to Increment using eta-reduction
% also called "inlining" in compiler optimizations
declare Inc = Increment

{Browse {Inc 6}}
