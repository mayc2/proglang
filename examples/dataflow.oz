
% Concurrent programming
thread
   P in
   P = {Pascal 21}
   {Browse P}
end
{Browse 99*99}

thread
   local P in
      P = {Pascal 21}
      {Browse P}
   end
end
{Browse 99*99}

thread {Browse 99*99} end
{Browse {Pascal 21}}

% Dataflow
declare X
thread
   {Delay 5000} X=99
end
thread {Browse {Pascal 24}} end
{Browse start} {Browse X*X}

declare X
thread
   {Browse start} {Browse X*X}
end
{Delay 5000} X=99

