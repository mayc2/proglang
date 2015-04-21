
%%
%% Lambda-calculus representation of non-negative integers
%%
%% |0| = \x.x
%% |n+1| = \x.|n|
%% 

declare Zero = I

declare Succ =
fun {$ N}
   fun {$ X}
      N
   end
end

declare Pred =
fun {$ N}
   {N Zero}  % when applied to 0 it returns 0.
end

%% You can then implement Add by using recursion and Succ,
%% and you can implement Multiply by using recursion and Add.
%%
%% assuming pure lambda calculus has been extended with "Not", "true"
%% and "IsProcedure"

declare IsZero? =
fun {$ N}
   {Not {IsProcedure {N true}}}
end

{Browse {IsZero Zero}}

{Browse {IsZero {Succ Zero}}}

{Browse {IsZero {Pred {Succ Zero}}}}

%%
%% to facilitate printing the numbers in Oz
%%

declare LambdaNumber = 
fun {$ N}
   if {IsZero N} then
      0
   else
      1+{LambdaNumber {Pred N}}
   end
end

%% e.g.:

{Browse {LambdaNumber {Succ {Succ Zero}}}}

% exercise: implement Add for the lambda calculus representation of
% numbers

%{Browse {LambdaNumber {Add {Succ Zero} Zero}}}

