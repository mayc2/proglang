
% Pascal triangle row
declare
fun {Pascal N}
   if N==1 then [1]
   else
      {AddList
       {ShiftLeft {Pascal N-1}}
       {ShiftRight {Pascal N-1}}}
   end
end
fun {ShiftLeft L}
   case L of H|T then
      H|{ShiftLeft T}
   else [0]
   end
end
fun {ShiftRight L}  0|L end
% assumes lists of the same size
fun {AddList L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 H1+H2|{AddList T1 T2}
      end
   else nil end
end

{Browse {ShiftLeft [1 3 3 1]}}

{Browse {ShiftRight [1 3 3 1]}}

{Browse {AddList [1 2] [3 4]}}

{Browse {Pascal 5}}

{Browse {AddList [1] [2 3]}}

{Browse {AddList [2 3] [1]}}

{Browse {Pascal 24}}

% Polynomial-time Pascal triangle row
declare fun {FastPascal N}
   if N==1 then [1]
   else
       	local L in
	   L={FastPascal N-1}
	   {AddList {ShiftLeft L} {ShiftRight L}}
	end
   end
end

{Browse {FastPascal 5}}

{Browse {FastPascal 24}}

{Browse {FastPascal 86}}

% Lazy evaluation
declare
fun lazy {Ints N}
   N|{Ints N+1}
end

declare L = {Ints 0}

{Browse L}

{Browse L.1}

case L of A|B|C|_ then {Browse A+B+C} end

{Browse L.2.2.2.2.2.2.1}

case L of A|B|_ then {Browse A+B} end

% Lazy Pascal triangle
declare fun lazy {PascalList Row}
   Row | {PascalList 
                {AddList 
		    {ShiftLeft Row}
		    {ShiftRight Row}}}
end

declare
L = {PascalList [1]}
{Browse L}
{Browse L.1}

{Browse L.2.1}

{Browse L.2.2.1}

declare PascalRow =
fun {$ L N}
   if N == 1 then
      L.1
   else {PascalRow L.2 N-1}
   end
end

{Browse {List.nth L 10}}

{Browse {PascalRow L 15}}

      