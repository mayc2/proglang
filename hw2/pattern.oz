declare
fun {Beta Input}
   if {IsAtom Input} then Input
   else
      case Input of H|T then {Beta H}
      [] lambda(x lambda(y [y x])) then yes
      else
	 no
      end
   end
end
%{Browse {Beta [lambda(x x) y]}}
{Browse {Beta [lambda(x lambda(y [y x])) [y w]]}}
