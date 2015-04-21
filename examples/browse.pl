browse(File) :- 
  seeing(Old),    /* save for later */ 
  see(File),          /* open this file */ 
  repeat, 
  read(Data),      /* read from File */ 
  process(Data),    
  seen,                /* close File */ 
  see(Old),          /*  previous read source */ 
  !.                        /* stop now */ 

process(end_of_file) :- !. 
process(Data) :-  write(Data), nl, fail. 
