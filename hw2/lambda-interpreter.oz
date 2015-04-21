%Alpha renaming
fun {FindFree Exp}
   case Exp of ex(A B) then [{FindFree A} {FindFree B}]
   [] l(A B) then {FindFree B}
   [] [H T] then [{FindFree H} {FindFree T}]
   else Exp end
end

%Eta reduction
declare
fun {Simplify Var C}
   case C of [H T] then
      if Var\=H andthen Var\=T then
	 [H T]
      else
	 nil
      end
   else
      if Var\=C then
	 C
      else
	 nil
      end
   end
end
fun {FindVar Var}
   case Var of ex(A B) then
      {FindVar [{Eta A} {Eta B}]}
   else
      Var
   end
end
fun {Eta3 X}
   case X of ex(A B) then
      [{Eta A} {Eta B}]
   else
      {Eta X}
   end
end
fun {Eta2 E V}
   case E of ex(A B) then
      {Eta2 [{Eta3 A} {Eta3 B}] V}
   [] [C D] then
      if {Simplify V C}==nil then
	 l(V E)
      else
	 C
      end
   else
      E
   end
end
fun {Eta Exp}
   case Exp of l(V E) then
      {Eta2 E V}
   [] ex(E) then
      {Eta E}
   else
      Exp
   end
end
%{Browse {Eta ex(l(x [y x]))}}
%{Browse {Eta l(x ex(ex(l(x [y x]) l(x [z x])) x))}} 

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
fun {Beta2 Exp1 Exp2}
   case Exp1 of l(V E) then {Explore E V Exp2}
   end
end
fun {Beta Exp}
   case Exp of ex(T1 T2) then B in
      B = {Beta2 {Beta T1} {Beta T2}}
      case B of [B1 B2] then
	 case B1 of l(V E) then {Beta2 B1 B2}
	 else B1 end
      else B end
   [] ex(E) then {Beta E}
   [] l(V E) then l(V {Beta E})
   [] [E1 E2] then [{Beta E1} {Beta E2}]
   [] V then V
   end
end
%{Browse {Beta ex(l(x l(y [y x])) [y w])}} %lambda(z [z [y w]])
%{Browse {Beta ex(l(x l(y [x y])) [y w])}} %[y w]
%{Browse {Beta ex(l(x x) y)}} %y
%{Browse {Beta ex(ex(l(y l(x [y x])) l(x [x x])) y)}} %[y y]
%{Browse {Beta ex(ex(ex(l(b l(t l(e [[b t] e]))) l(x l(y x))) x) y)}} %x
%{Browse {Beta ex(l(y ex(l(x l(y [x y])) y)) [y w])}} %[y w]

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
   Tree Lambda B R in
   Tree = {Check Exp}
   Lambda = {Test Tree}
   %Lambda
   %R = {Alpha Lambda}
   B = {Beta Lambda}
   {Eta B}
end

%Calls to Main Program: Test Cases
%{Browse {Run [lambda(x lambda(y [y x])) [y w]]}} %lambda(z [z [y w]])
%{Browse {Run [lambda(x lambda(y [x y])) [y w]]}} %[y w]
%{Browse {Run [lambda(x x) y]}} %y
%{Browse {Run lambda(x [y x])}} %y
%{Browse {Run [[lambda(y lambda(x [y x])) lambda(x [x x])] y]}} %[y y]
%{Browse {Run [[[lambda(b lambda(t lambda(e [[b t] e]))) lambda(x lambda(y x))] x] y]}} %x
%{Browse {Run lambda(x [[lambda(x [y x]) lambda(x [z x])] x])}} %[y z]
%{Browse {Run [lambda(y [lambda(x lambda(y [x y])) y]) [y w]]}} %[y w]
