%%
%% On "local", "declare" and "declare ... in":
%%

%% Make sure you run this code sequentially in a "fresh" Oz session
%% (one where X, Y, Z, etc have not been declared)

% programs with free variables (not declared, not bound) are not "runnable":
X = 0

I = proc {$ X Y} Y=X end

%% "local" creates a variable identifier with a restricted scope. e.g.,

local X in
   X = 1
   {Browse X}
end

{Browse X}    % error:  variable X not introduced

%% Syntactic sugar for the above creation and initialization of X is
%% as follows:

local X = 1 in
   {Browse X}
end

%%  lexical scope:  a variable refers to the closest enclosing declaration

local X in  % creates a variable <x1> in the store
   X = 1
   local X in  % creates a variable <x2> in the store
      X = 2
      {Browse X}  % refers to <x2>
   end
   {Browse X}  % refers to <x1>
end

{Browse X}  % error: variable X not introduced

%% syntactic sugar:  variable creation and initialization

local X = 1 in
   local X = 2 in
      {Browse X}  % refers to <x2>
   end
   {Browse X}  % refers to <x1>
end

{Browse X}  % error:  variable X not introduced

      
%% syntactic sugar for:    ...
%%                            local X in
%%                               <statement>
%%                            end
%%                         ...
%% is:
%%                         ... X in
%%                           <statement>
%%                         ...
%%
%% Note it has to appear in some enclosing expression: "..."
%% e.g.,

if 2>1 then
   local X in
      X = 1
      {Browse X}
   end
else
   local X in
      X = 2
      {Browse X}
   end
end

% becomes:

if 2>1 then X in 
   X = 1
   {Browse X}
else X in
   X = 2
   {Browse X}
end

%% the syntactic sugar for creation and initialization can still be
%% used, e.g.:

if 2>1 then X = 1 in 
   {Browse X}
else X = 2 in
   {Browse X}
end

%% Be careful when using "X in"  syntactic sugar, not to capture free
%% occurrences of X, e.g.:

local X = 0 in
   if 2>1 then
      local X = 1 in
	 {Browse X}
      end
      {Browse X}   % refers to <x0>, it is free in "if..." statement
   else
      local X = 2 in
	 {Browse X}
      end
   end
end

% but after wrong use of syntactic sugar:

local X = 0 in
   if 2>1 then X = 1 in 
      {Browse X}
      {Browse X}   % wrongly refers to <x1>, became captured
   else X = 2 in
      {Browse X}
   end
end

%% "declare" is ONLY used in the interactive system (not in standalone
%%  programs), it creates a new variable identifier in the global
%%  environment.
%%
%%  You can think of:
%%
%%      declare X
%%  as
%%      local X in <rest-of-session> end
%%
%%  That is X is available to the rest of the interactive session
%%

declare X    % creates a new unbound variable in the store
             % X is created in the global environment to map to
             % the unbound variable in the store

{Browse X}   % displays X as an unknown value

declare Y

Y = X

Y = 1        % updates the value in the store to 1
             % both X and Y refer to the same value

X = 2        % fails, because of single-assignment store.

local X in   % creates a *different* variable in the store,
             % and "hides" global X inside its scope
   X = 2
   {Browse X}
end

{Browse X}   % but the global environment binding is still there
             % after execution of the "local X in ... end"

X = 2        % error:  X already has the value 1, "1 = 2" fails

X = 2-1      % compatible with store, accepted.

declare X = 2  % creates a NEW variable in the store, hides
               % previous X for remainder of session
               % it is syntactic sugar for:
               %        declare X
               %        X = 2

{Browse X}

{Browse Y}     % but value was also available from variable Y


%%  "declare X in <statement>" restricts <statement> so that
%%  it can declare no new global variables

declare X Y in
X = 1 Y = 2
{Browse X+Y}

declare X Y in
X = 1 Y = 2 Z = X+Y
{Browse Z}
% error:  variable Z not introduced

declare X Y Z in
X = 1 Y = 2 Z = X+Y
{Browse Z}

declare X Y in
X = 1 Y = 2 Z = X+Y
{Browse Z}
% works because Z is already declared, and assignment is compatible

declare X Y in
X = 3 Y = 4 Z = X+Y
{Browse Z}
% fails because Z is already declared, but assignment is incompatible

declare X Y Z in
X = 1 Y = 2 Z = X+Y
{Browse Z}
% always works because X, Y, and Z are created fresh in the store

declare W
{Browse W}
X = 2 Y = 1  % works because X and Y are mapped to fresh store values

declare W in
{Browse W}
X = 3 Y = 4   % error: X and Y are already bound to incompatible values

declare W
{Browse W}
X = 3 Y = 4   % X and Y get brand new store values,
              % notice significance of "in"

W = X+Y       % updates the last value created by "declare W",
              % which hides previous versions of "W".


