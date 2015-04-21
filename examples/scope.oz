
% A variable V
declare
V = 9999*9999
{Browse V*V}

declare Z
{Browse Z}

V = Z

% Variables can only be assigned once.
% The following will produce an error:

V=9999

{Browse V}

% declare V ... is the same as "local V in ..." with no end.
% this new V hides the previous V
declare V = 10
W =20

{Browse V}

% but the original value is still visible through Z
{Browse Z}

% a locally scoped V hides the global V temporarily 
local R V in
   R = 20
   V = 30
   {Browse [R V]}
end

local R V in
   R = 20
   V = 30
   {Browse [R V]}
   local V = 40 in
      {Browse [R V]}
   end
   {Browse V}
end


{Browse V}

% out of scope:
{Browse R}

{Browse Z}

% single assignment for variables does NOT allow:
V = V + 1
% plus remember "=" in Oz really means unification, not assignment.
