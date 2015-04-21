
% Pascal triangle row auxiliary functions

declare
fun {ShiftLeft L}
   case L of H|T then
      H|{ShiftLeft T}
   else [0]
   end
end
fun {ShiftRight L}  0|L end

% Generic programming

declare fun {OpList Op L1 L2} 
	case L1 of H1|T1 then
		case L2 of H2|T2 then
	 	      {Op H1 H2}|{OpList Op T1 T2}
		end
   	else nil end
end

declare fun {GenericPascal Op N}
   if N==1 then [1]
   else L in L = {GenericPascal Op N-1}
      {OpList  Op {ShiftLeft L} {ShiftRight L}}
   end
end

% L in is syntactic sugar for local L in ... end
declare fun {GenericPascal Op N}
   if N==1 then [1]
   else
      local L in
	 L = {GenericPascal Op N-1}
	 {OpList  Op {ShiftLeft L} {ShiftRight L}}
      end
   end
end

declare fun {Add N1 N2} N1+N2 end
declare fun {Xor N1 N2} 
	if N1==N2 then 0 else 1 end
end

declare fun {Pascal N} {GenericPascal Add N} end
declare fun {ParityPascal N} 
	{GenericPascal Xor N} 
end

{Browse {Pascal 5}}
{Browse {Pascal 24}}
{Browse {ParityPascal 5}}
{Browse {ParityPascal 24}}



% using Curry
% recall the Curry combinator
declare Curry =
fun {$ F}
   fun {$ X}
      fun {$ Y}
	 {F X Y}
      end
   end
end

declare Pascal = {{Curry GenericPascal} Add}

% In some functional programming languages with
% first-class support for currying (e.g. Haskell):
% declare Pascal = {GenericPascal Add}

{Browse {Pascal 24}}
