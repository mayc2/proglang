
% emulating Prolog in Oz

% append
declare Append
proc {Append Xs Ys Zs}
   choice Xs = nil Zs = Ys
   [] X Xr Zr in Xs=X|Xr Zs=X|Zr {Append Xr Ys Zr}
   end
end

% new search query
declare P
proc {P S} X Y in {Append X Y [1 2 3]} S=[X Y] end

% new search engine
declare E
E = {New Search.object script(P)}

% calculate and display one at a time
{Browse {E next($)}}

% calculate all
{Browse {Search.base.all P}}


