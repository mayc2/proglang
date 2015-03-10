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
expression = fun {$ X Y} Y end
end

{Browse {Run [lambda(x x) y]}}