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

declare
fun {Reduce Exp1 Exp2}
   case Exp1 of [E1 E2] then
      if {IsTuple E1} andthen {IsAtom E1.1} then {Beta E1 E2}
      else {Reduce E1 E2} end
   end
end

declare
fun {Run Exp}
   case Exp of [E1 E2] then
      if {IsTuple E1} andthen {IsAtom E1.1} then {Beta E1 E2}
      else {Reduce E1 E2} end
   [] X then
	if {IsAtom X} then X
	else 'lambda('#X.1#' '#X.2#')' end
   end

end

%{Browse {Run [lambda(x [x y]) lambda(x [x x])]}}
%{Browse {Run [lambda(x [x y]) y]}}
{Browse {Run [[lambda(y lambda(x [y x])) lambda(x [x x])] y]}}