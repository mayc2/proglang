
% Lists
declare
H=1
T = [2 3 4 5]
{Browse H|T}  % This will show [1 2 3 4 5]

{Browse [1]|[2 3 4 5]}

declare  L = [5 6 7 8]
{Browse L.1}
{Browse L.2}

declare L = [[1] 2 3 4 5]
{Browse L.1}

{Browse L.2.1}

{Browse L.1.1}

% "." is not allowed for numbers:
{Browse L.1.1.2}

{Browse L.1.2}

case L of H|T then {Browse H} {Browse T} end

declare L = [1 2 3 4]

{Browse L}

{Browse {List.nth L 2}}


% On records
declare R=rec(f1:v1 f2:v2)
{Browse R}

declare R2=rec(f2:v2 f1:v1)
{Browse R2}

{Browse R==R2}

{Browse {Arity R}}

{Browse {Arity R}.1}

{Browse {Label R}}

{Browse {Arity Ctr4}}

{Browse R.f1}

{Browse R.({Arity R}.1)}

{Browse {Width R}}

case R of
   rec(f1:F1 f2:F2)
then
   {Browse F1}
   {Browse F2}
else
   {Browse 'nor a rec(f1:v1 f2:v2) record'}
end

declare RecList = rec(f:[1 2 3])
{Browse RecList}

% a tuple is a record
% whose implicit features are 1,2,3...
{Browse r(a)}

{Browse r(a)==r(1:a)}

{Browse r(a)==r(f1:a)}

{Browse r(a).1}

% a list is a tuple is a record
{Browse [1]}

{Browse '|'(1 nil)}

{Browse '|'(1:1 2:nil)}

{Browse {Label [1]}}

{Browse {Width [1]}}

{Browse {Width [1 2 3 4 5 6]}}



%following uses fail
{Browse {List.nth L 0}}

{Browse {List.nth L 5}}

{Browse {List.nth nil 1}}

%Oz bug!?:  The following works:
case L of E1|E2|T then {Browse E1} end

% but the following seems to crash:
case L of E1|E2|T then {Browse E1} {Browse E2} {Browse T} end

case L of E1|E2|T then {Browse E2} end

% the following works:
case L of H1|T1 then
   case T1 of H2|T2 then
      {Browse H2}
   end
end

% inside a local statement, things work as expected:
local L=[1 2 3 4] in
   case L of E1|E2 then
      {Browse E2}
   end
   case L of E1|E2|E3 then
      {Browse E2}
   end
   case L of E1|E2|E3|E4 then
      {Browse E2}
   end
   case L of E1|E2|E3|E4|nil then
      {Browse E2}
   end
   case L of E1|E2|E3|E4|E5 then
      {Browse E2}
   end
   case L of E1|E2|E3|E4|E5|E6 then
      {Browse E2}
   else {Browse 'no match'}
   end
end

% in a single statement, it works:
declare
L = [1 2 3 4]
case L of E1|E2|E3|E4 then
      {Browse E2}
end

% but in two separate statements, it crashes:
declare
L = [1 2 3 4]

case L of E1|E2|E3|E4 then
      {Browse E2}
end

% that seems to isolate the Mozart/Oz implementation bug!


