%Eta reduction
declare
fun {Simplify Exp}
   case Exp of ex(E) then {Simplify E} end
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
   [] ex(E) then {Beta E}
   [] l(V E) then l(V {Beta E})
   [] [E1 E2] then [{Beta E1} {Beta E2}]
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
%divides lambda expressions into tuples
declare
fun {Check X}
   case X of [H T] then
      case T of [A B] then
	 if {IsAtom A} andthen {IsAtom B} then
	    tree({Check H} [A B])
	 else
	    tree({Check H} tree({Check A} B))
	 end
      else
	 tree({Check H} T)
      end
   else
      X
   end
end
declare
fun {Test2 X Y}
   case X of tree(A B) then
      case B of [H T] then
	 if {IsAtom H} andthen {IsAtom T} then
	    ex({Test2 A B} [H T])
	 else
	    Tree in
	    Tree = {Check B}
	    ex({Test2 A B} ex({Test2 Tree.1 Tree.2}))
	 end
      else
	 ex({Test2 A B} {Test3 B})
      end
   [] lambda(A B) then
      case B of [H T] then
	 if {IsAtom H} andthen {IsAtom T} then
	    l({Test3 A} [H T])
	 else
	    Tree in
	    Tree = {Check B}
	    l({Test3 A} ex({Test2 Tree.1 Tree.2}))
	 end
      else
	 l({Test3 A} {Test3 B})
      end
   else
      {Test3 X}
   end
end
declare
fun {Test X}
   case X of tree(A B) then
      if {IsAtom A} andthen {IsAtom B} then
	 [A B]
      else
	 case B of tree(C D) then
	    ex({Test2 A B} {Test2 C D}) 
	 [] lambda(E F) then
	    case F of [H T] then
	       Tree in
	       Tree = {Check F}
	       ex(l(E {Test Tree}))
	    else
	       ex(l({Test2 E F} {Test3 F}))
	    end
	 else
	    ex({Test2 A B} {Test3 B})
	 end
      end
   [] lambda(A B) then
      case B of [H T] then
	 Tree in
	 Tree = {Check B}
	 ex(l(A {Test Tree})) 
      else
	 ex(l({Test2 A B} {Test3 B}))
      end
   else
      X
   end
end

%Extra Credit: Are Equal, comparing two lambda expressions to see if equal
declare
fun {AreEqual E1 E2}
   if E1==E2 then
      true
   %TO-DO: IMPLEMENT other cases
   %elseif 
   %  true
   else
      false
   end
end
%{Browse {AreEqual lambda(x x) lambda(y y)}}

%Main Run Function
declare
fun {Run Exp}
   Tree Lambda in
   Tree = {Check Exp}
   Lambda = {Test Tree}
   {Beta Lambda}
   %Lambda
end

%Calls to Main Program: Test Cases
%{Browse {Run [lambda(x lambda(y [y x])) [y w]]}} %lambda(z [z [y w]])
%{Browse {Run [lambda(x lambda(y [x y])) [y w]]}} %[y w]
%{Browse {Run [lambda(x x) y]}} %y
%{Browse {Run lambda(x [y x])}} %y
%{Browse {Run [[lambda(y lambda(x [y x])) lambda(x [x x])] y]}} %[y y]
{Browse {Run [[[lambda(b lambda(t lambda(e [[b t] e]))) lambda(x lambda(y x))] x] y]}} %x
%{Browse {Run lambda(x [[lambda(x [y x]) lambda(x [z x])] x])}} %[y z]
%{Browse {Run [lambda(y [lambda(x lambda(y [x y])) y]) [y w]]}} %[y w]
