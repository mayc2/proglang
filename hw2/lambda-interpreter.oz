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
   %{Beta Lambda}
   Lambda
end

%Calls to Main Program: Test Cases 
{Browse {Run [[lambda(y lambda(x [y x])) lambda(x [x x])] y]}}
{Browse {Run [lambda(x x) y]}}
{Browse {Run lambda(x [y x])}}
