
% emulating Prolog in Oz

% rainy
declare Rainy Cold Snowy

fun {Rainy} choice seattle [] rochester end end
fun {Cold} rochester end

proc {Snowy X}
   {Rainy X}
   {Cold X}
end

{Browse {Search.base.all proc {$ C} {Rainy C} end}}

{Browse {Search.base.all Snowy}}
