%loop function
%declare
%Run = fun {$ L}
	 %parse function? 
         %try beta
%	 {Beta L}
         %check for renaming

         %then try eta
%end

%beta reduction function
%declare
%Beta = fun {$ Atom Expression} 

	  
%end

%eta reduction function


%alpha renaming function

%Beta implementation
declare
fun {Explore Exp Var Rep}
   case Exp of [E1 E2] then
      [{Explore E1 Var Rep} {Explore E2 Var Rep}]
   [] lambda(V E) then {Explore E Var Rep}
   [] V then
      if V == Var then Rep else V end
   end
end

declare
fun {Beta Exp1 Exp2}
   case Exp1 of tree(T1 T2) then L in
      L = {Beta T1 T2}
      {Beta L Exp2}
   [] lambda(V E) then
      case E of [H T] then
	 E = {Beta H T}
	 {Beta E Exp2}
      else {Explore E V Exp2} end
   end
end
	 
   %else {Explore Exp1.1 Exp2 Exp1.1} end
   %else {Explore (Exp1.1).2 (Exp1.1).1 Exp1.2} end

%divides lists occurences into tuples
declare
fun {Check X}
   case X of [H T] then
      tree({Check H} {Check T})
   else
      X
   end
end
%Main Run Function
declare
fun {Run Exp}
   T in
   T = {Check Exp}
   if {IsTuple T} then
      {Beta T.1 T.2}
   else
      T
   end
end
{Browse {Run [[lambda(y lambda(x [y x])) lambda(x [x x])] y]}}


%{Browse {Run [lambda(x x) y]}}