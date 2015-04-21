
%
%% Higher-Order Programming
%

%% Exponential
declare Exp =
fun {$ B N}
   if N==0 then
      1
   else
      B * {Exp B N-1}
   end
end

{Browse {Exp 2 5}}
{Browse {Exp 2 30}}
{Browse {Exp 2 100}}
{Browse {Exp 2 1000}}

%% Powers of 2
%% recall the Curry combinator
declare Curry =
fun {$ F}
   fun {$ X}
      fun {$ Y}
	 {F X Y}
      end
   end
end

declare TwoE= {{Curry Exp} 2}

{Browse {TwoE 100}}

%If Oz had Haskell semantics, we could write:
% TwoE = {Exp 2}

%% Reverse curry
declare RCurry =
fun {$ F}
   fun {$ X}
      fun {$ Y}
	 {F Y X}
      end
   end
end

%% Square function revisited
declare Square = {{RCurry Exp} 2}

{Browse {Square 5}}

