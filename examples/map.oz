%map
declare
fun {Map F L}
   case L
   of nil then nil
   [] H|T then
      {F H}|{Map F T}
   end
end
{Browse {Map fun {$ X} X*X end [1 2 3]}}
