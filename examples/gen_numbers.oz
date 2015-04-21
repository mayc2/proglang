% Generate a list of numbers [1...N]
local GenNumbers in
   fun {GenNumbers N}
      if (N == 0) then nil
      else {Append {GenNumbers N-1} [N]}
      end
   end
   {Browse {GenNumbers 5}}
end

% Using an accumulator does not require Append
local GenNumbers in 
   fun {GenNumbers N}
      local GenNumbersAcc in
	 fun {GenNumbersAcc N M}
	    if (M > N) then nil
	    else M|{GenNumbersAcc N M+1}
	    end
	 end
	 {GenNumbersAcc N 1}
      end
   end
   {Browse {GenNumbers 5}}
end

% N is lexically visible in GenNumbersAcc
local GenNumbers in 
   fun {GenNumbers N}
      local GenNumbersAcc in
	 fun {GenNumbersAcc M}
	    if (M > N) then nil
	    else M|{GenNumbersAcc M+1}
	    end
	 end
	 {GenNumbersAcc 1}
      end
   end
   {Browse {GenNumbers 5}}
end
