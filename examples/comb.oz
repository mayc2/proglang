
declare
fun {Fact N}
   if N==0 then 1 else N*{Fact N-1} end
end

{Browse {Fact 100}}

% Composing functions
% number of combinations of r items from n

declare
fun {Comb N R}
   {Fact N} div ({Fact R}*{Fact N-R})
end

{Browse {Comb 3 2}}

{Browse {Comb 55 2}}

