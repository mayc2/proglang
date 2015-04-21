%length
declare
fun {Length L}
   case L
   of nil then 0
   [] H|T then 1+{Length T}
   end
end
{Browse {Length [a b c d]}}

