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


declare
fun {Check X}
   case X of [H T] then
      tree({Check H} {Check T})
   else
      X
   end
end
declare
fun {Redux Exp}
   T in
   T = {Check Exp}
   
end
{Inspect {Redux [[lambda(y lambda(x [y x])) lambda(x [x x])] y]}}


%{Browse {Run [lambda(x x) y]}}