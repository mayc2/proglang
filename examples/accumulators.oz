
% Accumulators

declare
proc {Increment N0 N}
	N = N0 + 1
end
proc {Square N0 N}
	N = N0 * N0
end
proc {IncSquare N0 N}
   N1 in
   {Increment N0 N1}
   {Square N1 N}
end

declare V
{IncSquare 2 V}
{Browse V}

{Browse {IncSquare 3 $}}

{Browse {IncSquare 4}}

% Merge-sort example

declare
fun {Merge Xs Ys}
   case Xs # Ys
   of nil # Ys then Ys
   [] Xs # nil then Xs
   [] (X|Xr) # (Y|Yr) then
      if X =< Y then X|{Merge Xr Ys}
      else Y|{Merge Xs Yr} end
   end
end

declare
proc {MergeSort1 N S0 S Xs}
   if N==0 then S = S0 Xs = nil
   elseif N ==1 then X in X|S = S0 Xs = [X]
   else %% N > 1
      local S1 Xs1 Xs2 NL NR in
	 NL = N div 2
	 NR = N - NL
	 {MergeSort1 NL S0 S1 Xs1}
	 {MergeSort1 NR S1 S Xs2}
	 Xs = {Merge Xs1 Xs2}
      end
   end
end

{Browse {MergeSort [3 1 8 7 2 9]}}

% functional version

declare
fun {MergeSort Xs}
   Ys in
   {MergeSort1 {Length Xs} Xs _ Ys}
   Ys
end

declare
fun {MergeSort Xs}
   fun {MergeSortAcc L1 N}
      if N == 0 then
	 nil # L1
      elseif N == 1 then
	 [L1.1] # L1.2
      elseif N > 1 then
	 NL = N div 2
	 NR = N - NL
	 Ys # L2 = {MergeSortAcc L1 NL}
	 Zs # L3 = {MergeSortAcc L2 NR}
      in
	 {Merge Ys Zs} # L3
      end
   end
in
   {MergeSortAcc Xs {Length Xs}}.1
end

{Browse {MergeSort [3 1 8 7 2 9]}}

% Machine instructions example

declare SeqCode ExprCode

proc {SeqCode Es C0 C N0 N}
   case Es
   of nil then C = C0 N = N0
   [] E|Er then N1 C1 in
      {ExprCode E C0 C1 N0 N1}
      {SeqCode Er C1 C N1 N}
   end
end

proc {ExprCode Expr C0 C N0 N}
   case Expr
   of plus(Expr1 Expr2) then C1 N1 in
      C1 = plus|C0
      N1 = N0 + 1
      {SeqCode [Expr2 Expr1] C1 C N1 N}
   [] minus(Expr1 Expr2) then C1 N1 in
      C1 = minus|C0
      N1 = N0 + 1
      {SeqCode [Expr2 Expr1] C1 C N1 N}
   [] I andthen {IsInt I} then
      C = push(I)|C0
      N = N0 + 1
   end
end

local Code Size in
   {ExprCode plus(plus(2 3) minus(5 4)) nil Code 0 Size}
   {Browse Size#Code}
end

% shorter version

declare 
proc {ExprCode Expr C0 C N0 N}
   case Expr
   of plus(Expr1 Expr2) then
      {SeqCode [Expr2 Expr1] plus|C0 C N0 + 1 N}
   [] minus(Expr1 Expr2) then
 	{SeqCode [Expr2 Expr1] minus|C0 C N0 + 1 N}
   [] I andthen {IsInt I} then
      C = push(I)|C0
      N = N0 + 1
   end
end

% using functions rather than procedures

declare ExprCode SeqCode

fun {ExprCode Expr t(C0 N0) }
   case Expr
   of plus(Expr1 Expr2) then
      {SeqCode [Expr2 Expr1] t(plus|C0 N0 + 1)}
   [] minus(Expr1 Expr2) then
      {SeqCode [Expr2 Expr1] t(minus|C0 N0 + 1)}
   [] I andthen {IsInt I} then
      t(push(I)|C0 N0 + 1)
   end
end

fun {SeqCode Es T}
   case Es
   of nil then T
   [] E|Er then 
      {SeqCode Er {ExprCode E T}}
   end
end

{Browse {ExprCode plus(plus(2 3) minus(5 4)) t(nil 0)}}

