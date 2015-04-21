% Browser is more than standard output

declare X

{Browse X}

X = 10

% Difference lists

declare
fun {AppendD D1 D2}
   S1 # E1 = D1
   S2 # E2 = D2
in
   E1 = S2
   S1 # E2
end

local X Y in {Browse {AppendD (1|2|3|X)#X (4|5|Y)#Y}} end

declare X Y Z

{Browse {AppendD (1|2|3|X)#X (4|5|Y)#Y}} 

Y = (6|7|Z)

Y = nil

% a queue with difference lists

declare NewQueue Insert Delete EmptyQueue

fun {NewQueue}
   X in q(0 X X)
end

fun {Insert Q X}
   case Q of q(N S E)
   then E1 in
	   E=X|E1
	   q(N+1 S E1)
   end
end

fun {Delete Q X}
	case Q of q(N S E) then S1 in X|S1=S q(N-1 S1 E) end
end

fun {EmptyQueue Q} case Q of q(N S E) then N==0 end end

declare Q1 Q2 Q3 Q4

Q1 = {NewQueue}
{Browse Q1}

Q2 = {Insert Q1 a}
{Browse Q2}

Q3 = {Insert Q2 b}
{Browse Q3}

local X in Q4 = {Delete Q3 X} {Browse X} end
{Browse Q4}

% If we remove elements, before inserting elements:

declare Q1 Q2 Q3 Q4 Q5

Q1 = {NewQueue}
{Browse Q1}

local X in Q2 = {Delete Q1 X} {Browse X} end
{Browse Q2}

local X in Q3 = {Delete Q2 X} {Browse X} end
{Browse Q3}

Q4 = {Insert Q3 a}
{Browse Q4}

Q5 = {Insert Q4 b}
{Browse Q5}



% A problem with difference lists:
declare Q5
Q5 = {Insert Q2 c}
{Browse Q5}

   
% Flattening nested lists

declare
fun {IsLeaf N}
   {Not {IsList N}}
end

declare
fun {Flatten Xs}
case Xs
   of nil then nil
   [] X|Xr andthen {IsLeaf X} then
     X|{Flatten Xr}
   [] X|Xr  andthen {Not {IsLeaf X}} then
      {Append {Flatten X} {Flatten Xr}}
   end
end

{Browse {Flatten [[1] 2 [[3] 4]]}}

% flattening with difference lists

declare
proc {FlattenD Xs Ds}
   case Xs
   of nil then Y in Ds = Y#Y
   [] X|Xr andthen {IsLeaf X} then Y1 Y2 in
      {FlattenD Xr Y1#Y2}
      Ds = (X|Y1)#Y2
   [] X|Xr andthen {IsList X} then Y0 Y1 Y2 in
      Ds = Y0#Y2
      {FlattenD X Y0#Y1}
      {FlattenD Xr Y1#Y2}
   end
end

declare
fun {Flatten Xs}  Y in {FlattenD Xs Y#nil}  Y end

{Browse {FlattenD [[1] 2 [[3] 4]]}}

% reversing a list

declare
fun {Reverse Xs}
	case Xs
	of nil then nil
	[] X|Xr then {Append {Reverse Xr} [X]}
	end
end

{Browse {Reverse [1 2 3 4]}}

% using difference lists

declare
fun {ReverseD Xs}
   proc {ReverseD Xs Y1 Y}
      case Xs
      of nil then Y1=Y
      [] X|Xr then Y2 in
	 {ReverseD Xr Y1 Y2}
	 Y2 = X|Y
      end
   end
   R in
   {ReverseD Xs R nil}
   R
end

{Browse {ReverseD [1 2 3 4]}}

% making it iterative

declare
fun {ReverseD Xs}
   proc {ReverseD Xs Y1 Y}
      case Xs
      of nil then Y1=Y
      [] X|Xr then
	 {ReverseD Xr Y1 X|Y}
      end
   end
   R in
   {ReverseD Xs R nil}
   R
end
