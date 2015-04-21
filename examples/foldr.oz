%sumlist
declare 
fun {SumList L}
   case L
   of nil then 0
   [] H|T then H+{SumList T}
   end
end
{Browse {SumList [1 2 3 4]}}

%sub
declare
fun {Sub X Y L}
   case L
   of nil then nil
   [] H|T then
      if H == X then Y | {Sub X Y T}
      else H | {Sub X Y T}
      end
   end
end
{Browse {Sub 2 4 [1 2 3 2]}} % displays [1 4 3 4]

%map
declare
fun {Map F L}
   case L
   of nil then nil
   [] H|T then
      {F H}|{Map F T}
   end
end
{Browse {Map fun {$ X} X*X end [1 2 3 4]}} % displays [1 4 9 16]

%sub using map
declare
fun {Sub X Y L}
   {Map fun {$ Z} if Z == X then Y else Z end end L}
end
{Browse {Sub 2 4 [1 2 3 2]}}

%foldr
declare 
fun {FoldR F U L}
   case L
   of nil then U
   [] H|T then {F H {FoldR F U T}}
   end
end
{Browse {FoldR Number.'+' 0 [1 2 3 4]}}
{Browse {FoldR Number.'*' 1 [1 2 3 4]}}

% sumlist as foldr application
declare
fun {SumList L}
   {FoldR Number.'+' 0 L}
end
{Browse {SumList [1 2 3 4]}}

% productlist as foldr application
declare
fun {ProductList L}
   {FoldR Number.'*' 1 L}
end
{Browse {ProductList [1 2 3 4]}}

% append as foldr aplication
declare
fun {Append L1 L2}
   {FoldR fun {$ H T} H|T end L2 L1}
end
{Browse {Append [1 2] [3 4]}}

% map as foldr application
declare
fun {Map F L}
   {FoldR fun {$ H T} {F H}|T end nil L}
end
{Browse {Map fun {$ X} X*X end [1 2 3 4]}}

% filter as foldr application
declare
fun {Filter P L}
   {FoldR fun {$ H T}
	     if {P H} then
		H|T
	     else T end
	  end nil L}
end
{Browse {Filter fun {$ A} A < 3 end [1 2 3 4]}}

% remove as filter application
declare
fun {Remove X L}
   {Filter fun {$ V} V \= X end L}
end
{Browse {Remove 2 [1 2 3 4]}}

%% recall the curry combinator
declare Curry =
fun {$ F}
   fun {$ X}
      fun {$ Y}
	 {F X Y}
      end
   end
end

% remove using curry
declare
fun {RemoveC X}
   {{Curry Remove} X}
end
Remove2 = {RemoveC 2}
{Browse {Remove2 [1 2 3 4]}}
{Browse {Remove2 [1 2 3 2]}}

%after eta-reduction, the equivalent form:
declare RemoveC = {Curry Remove}
Remove1 = {RemoveC 1}
Remove4 = {RemoveC 4}
{Browse {Remove1 [1 2 3 4]}}
{Browse {Remove4 [1 2 3 4]}}


% map reduce
declare
fun {MapReduce MapF ReduceF}
   fun {$ L}
      {ReduceF {Map MapF L}}
   end
end

declare SumSquares =
{MapReduce
 fun {$ X} X*X end
 fun {$ L} {FoldR Number.'+' 0 L} end
}
{Browse {SumSquares [1 2 3 4]}}

declare Square = fun {$ X} X*X end
declare SumSquares = {MapReduce Square SumList}
{Browse {SumSquares [1 2 3 4]}}

% a three argument curry combinator version here
declare Curry32 =
fun {$ F}
   fun {$ X Y}
      fun {$ Z}
	 {F X Y Z}
      end
   end
end

declare
Sub24 = {{Curry32 Sub} 2 4}
{Browse {Sub24 [1 2 3 2]}}

declare
SumList = {{Curry32 FoldR} Number.'+' 0}
SumSquares = {MapReduce Square SumList}
{Browse {SumSquares [1 2 3 4]}}

% after eta-expansion of SumList, the equivalent form:
declare
SumList =
fun {$ L}
   {{{Curry32 FoldR} Number.'+' 0} L}
end


%freevars
declare
fun {FreeVars E}
   case E
   of [F A] then {Append {FreeVars F} {FreeVars A}}
   [] lambda(V E) andthen {IsAtom V} then {Remove V {FreeVars E}}
   [] V andthen {IsAtom V} then [V]
   else raise illFormedExpression(E) end
   end
end
{Browse {FreeVars lambda(x x)}}
{Browse {FreeVars x}}
{Browse {FreeVars [lambda(x x) y]}}
{Browse {FreeVars [lambda(x x) x]}}
{Browse {FreeVars lambda(x [x x])}}
{Browse {FreeVars [lambda(x [x x]) lambda(x [x x])]}}

%iscombinator
declare
fun {IsCombinator E}
   {FreeVars E} == nil
end
{Browse {IsCombinator lambda(x x)}}
{Browse {IsCombinator x}}
{Browse {IsCombinator [lambda(x x) y]}}
{Browse {IsCombinator [lambda(x x) x]}}
{Browse {IsCombinator lambda(x [x x])}}
{Browse {IsCombinator [lambda(x [x x]) lambda(x [x x])]}}

{Browse {IsCombinator [lambda(x x)]}}