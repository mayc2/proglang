%loop function
declare
Run = fun {$ L}
	 %parse function? 
         %try beta
	 {Beta L}
         %check for renaming

         %then try eta
      end

%beta reduction function
declare
Beta = fun {$ Atom, Expression} 

	  
end

%eta reduction function


%alpha renaming function

%Beta implementation
declare
fun {Explore Exp Atom Rep}
   case Exp of [E1 E2] then
      [{Explore E1 Atom Rep} {Explore E2 Atom Rep}]
   [] X then
      if {IsAtom X} then
	 if X == Atom then Rep else X end
      elseif {IsTuple X} then {Explore X.2 Atom Rep} end
   end
end
declare
fun {Beta Exp1 Exp2}
   if {IsAtom Exp1.2} andthen Exp1.1 == Exp1.2 then Exp2
   else {Explore Exp1.2 Exp1.1 Exp2} end
end
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