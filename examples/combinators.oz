
declare Square = fun {$ X} X*X end
declare Increment = fun {$ X} X+1 end

%%% Combinators

% Identity combinator

declare I = fun {$ X} X end

{Browse {I 5}}
{Browse {I Square}}

% Application combinator

declare App = fun {$ F X} {F X} end

{Browse {App Square 7}}

% Function composition combinator:

declare Compose = fun {$ F G}
		     fun {$ X}
			{F {G X}}
		     end
		  end

{Browse {{Compose Square Increment} 5}}

% Sequencing combinator, Z should not appear free in Y

declare Seq = fun {$ X Y} { fun {$ Z} Y end X } end

{Browse {Seq 3 4}}

% Curry as combinator

declare Curry =
fun {$ F}
   fun {$ X}
      fun {$ Y}
	 {F X Y}
      end
   end
end

declare Plus = fun {$ X Y} X+Y end

declare PlusC = {Curry Plus}

{Browse {{PlusC 2} 3}}

declare ComposeC = {Curry Compose}

declare IncrementC = {ComposeC Increment}

declare SquaredPlusOne = {IncrementC Square}

declare IncrementTwice = {IncrementC Increment}

{Browse {IncrementTwice 5}}

declare SquaredPlusOne =
            {{ComposeC Increment} Square}

{Browse {SquaredPlusOne 4}}

{Browse {{IncrementC fun {$ X} X+2 end} 4}}
