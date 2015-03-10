declare
fun {Beta X}
   case X of nil then X
   [] H|T then
      {Beta H}#{Beta T}
   elseif {IsTuple X} then
      X.1
   else
      X
   end
end
%{Browse {Simplify lambda(x lambda(y [y x]))}}
{Browse {Simplify [[lambda(b lambda(t lambda(e [[b t] e]))) lambda(x lambda(y x))] x]}}

declare L1 L2
fun {Find Input}
   if {IsAtom Input} then Input
   else
      case Input of H|T then
	 {Simplify H L1} andthen {Simplify T L2}
      [] lambda(x lambda(y [y x])) then
	 {Check lambda(x lambda(y [y x]))}
      else
	 no
      end
   end
end

%{Browse {Beta [lambda(x x) y]}}
%{Browse {Beta [lambda(x lambda(y [y x])) [y w]]}}
