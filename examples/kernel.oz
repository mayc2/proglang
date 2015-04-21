
%% kernel language examples

local X in X = 1 end

local X Y T Z in
   X = 5
   Y = 10
   T = (X>=Y)
   if T then Z = X else Z = Y end
   {Browse Z}
end

% higher-level language example:

local I in
   fun {I X} X end
    {Browse {I 5}}
end

% translates to kernel language:

local I in                  
   I = proc {$ X Y} Y = X end  % function converted to a procedure
   local T in 
      {I 5 T}                  % nested procedure call expanded
      {Browse T}               % with temporary variable creation
   end
end

% a square routine in extended kernel language
% (with multiple variable initialization)

local S T in 
   S = proc {$ X Y} Y = X*X end
   {S 5 T}
   {Browse T}
end

% abstracting over statement "if X >= Y then Z = X else Z = Y end"
declare Max in
Max = proc {$ X Y Z}
   if X >= Y then Z = X else Z = Y
   end
end

{Browse {Max 5 7 $}}

% exercise:  translate above call into the kernel language.

% abstracting over partial set of free variable identifiers
declare LowerBound Y in
proc {LowerBound X Z}
   if X >= Y then Z = X else Z = Y end
end

{Browse {LowerBound 4}}  % blocks because Y is unbound
Y = 5  % cannot execute yet because this statement's thread is blocked.
{Browse 'does not happen if Y is bound to 7'}

Y = 7  % assigns 7 to Y's store variable and resumes the blocked
       % computation above.
       % In interactive environment, every statement is executed in a
       % separate thread.  Notice that the newline above the "Y = 7"
       % statement is therefore significant!
       % After {LowerBound 4} is displayed, "Y = 5" is executed
       % producing a failure: "7 = 5"

{Browse {LowerBound 6}}
{Browse {LowerBound 8}}

% exercise: add an empty line before "Y = 5" and execute these
% statements in a fresh Oz emulator (one not containing Y in the
% global environment).

%%  lexical scope revisited:
%%  a variable refers to the closest enclosing declaration

local X in  % creates a variable <x1> in the store
   X = 1
   local X in  % creates a variable <x2> in the store
      X = 2
      {Browse X}  % refers to <x2>
   end
   {Browse X}  % refers to <x1>
end

% Res appears free in following statement: not runnable.
local Arg1 Arg2 in
   Arg1 = 111*111
   Arg2 = 999*999
   Res = Arg1*Arg2
end

% No free variable identifiers:  runnable statement.
local Res in
   local Arg1 Arg2 in
      Arg1 = 111*111
      Arg2 = 999*999
      Res = Arg1*Arg2
   end
   {Browse Res}
end

% Creating procedure values:
local P Q in
   P = proc {$} {Q} end
   Q = proc {$} {Browse hello} end
   local Q in
      Q = proc {$} {Browse hi} end
      {P}
   end
end
% what does it display? why?

% Lexical scope
local P Q in
   thread
      local Q in
	 Q = proc {$} {Browse hi} end
	 {P}
      end
   end
   P = proc {$} {Q} end
   Q = proc {$} {Browse hello} end
end
% what does it display? why?

% On Browse vs Show
{Browse 'hi'}

declare Hi
{Browse Hi}

Hi = 5

{Show 'hi'}

declare Hi
{Show Hi}

Hi = 5

{Show Hi}

% On throwing exceptions and halting execution
{Browse 'test exception'}
raise 'error' end
{Browse 'does not print'}


declare Square

Square = fun {$ X} X*X end

% No procedure value unification in Oz: (program equivalence testing
% in general is undecidable)

Square = fun {$ X} X*X end
