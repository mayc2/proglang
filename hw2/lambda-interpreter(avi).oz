%Eta reduction
declare
fun {Simplify Exp}
   case Exp of ex(E) then {Simplify E}
      [] 
end


declare
fun {Eta2 Exp Var}
   case Exp of [E1 E2] then ex({Eta2 E1 Var} {Eta2 E2 Var})
   [] V then
      if V \= Var then V else nil end
   end
end

declare
fun {Eta Exp}
   case Exp of l(V E) then {Eta2 E V}
   [] ex(E) then {Eta E} end
end


%Beta implementation
declare
fun {Explore Exp Var Rep}
   case Exp of [E1 E2] then
      [{Explore E1 Var Rep} {Explore E2 Var Rep}]
   [] l(V E) then l(V {Explore E Var Rep})
   [] V then
      if V == Var then Rep else V end
   end
end

declare
fun {Beta2 Exp1 Exp2}
   case Exp1 of l(V E) then {Explore E V Exp2}
   end
end


declare
fun {Beta Exp}
   case Exp of ex(T1 T2) then B in
      B = {Beta2 {Beta T1} {Beta T2}}
      case B of [B1 B2] then
	 case B1 of l(V E) then {Beta2 B1 B2} end
      else B end
   [] l(V E) then l(V E)
   [] V then V
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Begin Chris's Code                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Splits up inner lambda statements into tuples for easier handling
declare
fun {Test3 X}
   case X of lambda(A B) then
      l({Test3 A} {Test3 B})
   else
      X
   end
end
declare
fun {Test2 X Y}
   case X of tree(A B) then
      ex({Test2 A B} {Test3 B})
   [] lambda(A B) then
      l({Test3 A} {Test3 B})
   else
      X
   end
end
declare
fun {Test X}
   case X of tree(A B) then
      case A of tree(C D) then
	 ex({Test2 A B} {Test3 B})
      else
	 ex({Test2 A B} B)
      end
   [] lambda(A B) then
      ex(l({Test2 A B} X.2))
   else
      X
   end
end

%divides labmda expressions into tuples
declare
fun {Check X}
   case X of [H T] then
      tree({Check H} T)
   else
      X
   end
end

%Main Run Function
declare
fun {Run Exp}
   Tree Lambda in
   Tree = {Check Exp}
   Lambda = {Test Tree}
   %Tree
   local B in
      B = {Beta Lambda}
      {Eta B}
   end
end

%Calls to Main Program: Test Cases 
%{Browse {Run [[lambda(y lambda(x [y x])) lambda(x [x x])] y]}}
%{Browse {Run [lambda(y lambda(x [y x])) lambda(x [x x])]}}
%{Browse {Run [lambda(x x) y]}}
{Browse {Run lambda(x [y x])}}
%{Browse {Run [[[lambda(b lambda(t lambda(e [[b t] e]))) lambda(x lambda(y x))] x] y]}}
%{Browse {Run lambda(x [[lambda(x [y x]) lambda(x [z x])] x])}}
