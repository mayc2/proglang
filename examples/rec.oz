
%% Recursive definitions in lambda-calculus
%% Recursion combinator Y

%% Defining factorial in pure lambda calculus

%% This expression (call it F) takes a function (call it G) and
%% returns a function that computes the factorial of a number.

declare F =
fun {$ G}
   fun {$ N}
      if N==0 then
	 1
      else
	 N * {G N-1}
      end
   end
end

%% What can we apply it to, to get the factorial function?

%% {F F} is not well defined: type of F is (Z->Z)->(Z->Z) 

%% actually, you can apply F to itself but the resulting function cannot be
%% applied to anything.

%% {F I} is well defined:  it returns n * (n-1) (for n>0) but it
%% does not return the desired factorial function, e.g.:

declare I = fun {$ X} X end
{Browse {{F I} 5}}

%% how do we get factorial?
%% we need a procedure X representing factorial, i.e.,
%% (F X) = X
%% Notice that G itself in the construction above is supposed to
%% compute the factorial function.

%% In the factorial example, the following lambda-expression does the job:

declare X =
{fun {$ Z}
    {fun {$ G}
	fun {$ N}
	   if N==0 then
	      1
	   else
	      N * {G N-1}
	   end
	end
     end
     fun {$ Y}
	{{Z Z} Y}
     end
     }
 end
 fun {$ Z}
    {fun {$ G}
	fun {$ N}
	   if N==0 then
	      1
	   else
	      N * {G N-1}
	   end
	end
     end
     fun {$ Y}
	{{Z Z} Y}
     end
     }
 end
}

{Browse {{F X} 5}}

{Browse {X 5}}

%% Such X can be defined in terms of the recursive function F as follows
%% X = (Y F)

%% where Y is the recursion combinator (in normal order)

declare Y =
fun {$ F}
   {fun {$ X}
       {F {X X}}
    end
    fun {$ X}
       {F {X X}}
    end
   }
end

% Do not try the normal order Y combinator
%(in applicative order, it goes into an infinite loop)
% {Browse {{F {Y F}} 5}}

%% here in applicative order (after eta-expansion) so that it
%% terminates with applicative order reduction
declare Y =
fun {$ F}
   {fun {$ X}
       {F fun {$ Y}
	     {{X X} Y}
	  end
       }
    end
    fun {$ X}
       {F fun {$ Y}
	     {{X X} Y}
	  end
       }
    end
   }
end

%% the type of Y is ((Z->Z)->(Z->Z))->(Z->Z)

declare X = {Y F}

{Browse {{F X} 5}}

%% notice that (Y f) = (f (Y f)) by the construction above.

{Browse {X 5}}

{Browse {{F {Y F}} 5}}

%% thus, here is the "pure" lambda-calculus expression computing factorial:
%% (assuming that lambda calculus has beed extended with 0, 1, -, *, =, if)

declare Factorial =
{fun {$ F}
    {fun {$ X}
	{F fun {$ Y}
	      {{X X} Y}
	   end
	}
     end
     fun {$ X}
	{F fun {$ Y}
	      {{X X} Y}
	   end
	}
     end
    }
 end
 fun {$ G}
    fun {$ N}
       if N==0 then
	  1
       else
	  N * {G N-1}
       end
    end
 end
}

{Browse {Factorial 6}}

%% Fortunately, in Oz, we can more easily define recursive procedures.
declare
fun {Fact X}
   if X==0 then 1
   else X*{Fact X-1} end
end

{Browse {Fact 6}}

%% which is syntactic sugar for:
declare Fact =
fun {$ X}
   if X==0 then 1
   else X*{Fact X-1} end
end

%% which itself is represented as a procedure of arity 2 in the Oz kernel language.

{Browse {Fact 10}}

{Browse {Fact 100}}

