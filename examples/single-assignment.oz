%
% On partial values
%
declare X Y Z
X = person(name:"George" age: Z)

% incompatible assignment
X = person(name:"David" age:Z)

% compatible assignment
X = person(name:Y age:25)

{Browse X}
{Browse Y}
{Browse Z}

% incompatible assignment produces error
declare
V = 10-5
V = 4
% anything here is ignored (after error)
{Browse 'never prints'}

{Browse V}  % V's assignment remains 5 from "10-5" above

declare
V = 10-5
V = 4+1
% on compatible assignment, computation proceeds
{Browse V}

declare Even Odd  % initially unbound

Even = fun {$ X}
   if X == 0 then true
   else {Odd X-1}
   end
end

% same as:
% fun {Even X}
%   if X == 0 then true
%   else {Odd X-1}
%   end
% end

% prints immediately
{Browse {Even 0}}

% waits for Odd to be defined
{Browse {Even 2}}

% same as:
declare Even = proc {$ X Y}
	  if X == 0 then Y = true
	  else {Odd X-1 Y}
	  end
       end

% same as:
declare Even =
proc {$ X Y}
   local B in
      B = (X == 0)
      if B then Y = true
      else
	 local Z in
	    Z = X-1
	    {Odd Z Y}
	 end
      end
   end
end

% prints immediately
{Browse {Even 0}}

% waits for Odd to be defined
{Browse {Even 3}}

{Browse Even}

Odd =
fun {$ X}
   if X == 0 then false
   else {Even X-1}
   end
end

% thread running '+' suspends until X becomes bound
declare X Y
Y = X+1

{Browse X}
{Browse Y}

X = 5

% literals are records with no fields
{Browse a() == a}

{Browse ~10}

{Browse a=='a'}

{Browse 'a' == a()}

{Browse bcd == 'bcd'}

{Browse X=='X'}

{Browse true=='true'}

% boolean is a data type:
{Browse true}

{Browse if true then 4 else 5 end}

{Browse if true then 4 end}

{Browse if false then 4 end}

{Browse if 5 == 2+2 then 4 end}

{Browse if false then 4 else 5 end}

% 'true' and 'false' are the only valid booleans
{Browse if 1 then 4 else 5 end}  % type error

declare
AThunk = proc {$} {Browse 'hi'} end

{AThunk}

