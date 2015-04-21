%%
%% Booleans in pure lambda calculus (normal order)
%%

declare LambdaTrue =
fun {$ X Y}
   X
end

declare LambdaFalse =
fun {$ X Y}
   Y
end

declare LambdaIf =
fun {$ B T E}
   {B T E}
end

%% e.g.:

{Browse {LambdaIf LambdaTrue 4 5}}
{Browse {LambdaIf LambdaFalse 4 5}}

% exercise: why is normal order an important assumption?
