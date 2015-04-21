
% Procedural syntax

declare proc {Square X Y} Y = X*X end

declare Z
{Square 5 Z}
{Browse Z}

{Browse {Square 5 $}}

% Functional syntax

declare fun {Square X} X*X end

{Browse {Square 9999}}

{Browse {Square 9999 $}}

% Lambda calculus style

declare Square = fun {$ X} X*X end

{Browse {Square 6}}

% Using anonymous function

{Browse {fun {$ X} X*X end 5}}

% Procedural and functional forms are equivalent

declare Increment = fun {$ X} X+1 end

{Browse {Increment 5}}

declare Increment = proc {$ X Y} Y = X+1 end

{Browse {Increment 5}}

declare Z
{Increment 5 Z}
{Browse Z}

{Browse {Increment 5 $}}

% Function composition combinator:
declare Compose = fun {$ F G}
		     fun {$ X}
			{F {G X}}
		     end
		  end

declare PlusOneSquared = {Compose Square Increment}

{Browse {PlusOneSquared 5}}

declare SquaredPlusOne = {Compose Increment Square}

{Browse {SquaredPlusOne 5}}

declare FourthPower = {Compose Square Square}

{Browse {FourthPower 2}}

declare PlusTwo={Compose Increment Increment}

{Browse {PlusTwo 4}}

{Browse {{Compose PlusTwo FourthPower} 5}}

% Scope of variables
local X = 2 in
   local F = fun {$ X}
		X * X    % these refer to the argument to F
	     end
   in {Browse {F X}}  % this occurrence of X refers to 2
   end
end

