PLA#3
Chris May - RCS ID: mayc2
and 
Avinash Singh - RCS ID: singha9 

We designed our project as follows:
  *MainProgram.salsa -- executes the program, initializing all actors for both the distributed and concurrent versions
  *Star.java and StarPair.java classes -- help with storing the data from the input file
  *Calculator.salsa (distributed only) -- helper actor that determines type of calculation to be computed, initializes actor of that calculation type and messages to calculate accordingly
  *ClosestNeighbors.salsa, FarthestNeighbors.salsa, IdealCapitalStar.salsa, IdealHubStar.salsa, IdealJailStar.salsa -- each calculation was treated as a seperate actor that can be messaged to calculate


We use the following script to set our environment up and then the following commands to compile and execute the program.

Environment Set-Up Script
---------------------------------------------------------------------------------------------

#!/bin/bash

export SWPATH=/home/chris/devtree
export SALSAPATH=$SWPATH/salsa
export SALSAVER='1.1.5'
export SALSAOPTS=''

# SALSA 1.x aliases
alias salsac='bash -xc '\''java -cp $SALSAPATH/salsa$SALSAVER.jar:. salsac.SalsaCompiler ${0}*.salsa; javac -classpath $SALSAPATH/salsa$SALSAVER.jar:. ${0}*.java'\'''
alias salsa='java -cp $SALSAPATH/salsa$SALSAVER.jar:.'
alias wwcns='java -cp $SALSAPATH/salsa$SALSAVER.jar:. wwc.naming.WWCNamingServer'
alias wwctheater='java -cp $SALSAPATH/salsa$SALSAVER.jar:. $SALSAOPTS wwc.messaging.Theater'

---------------------------------------------------------------------------------------------

Compiling (for concurrent): salsac concurrent/ 
Compiling (for distributed): salsac distributed/ 

Running (for concurrent): salsa concurrent/MainProgram <input_file> <nameServer> <theatersFile>
Running (for distributed): salsa distributed/MainProgram <input_file> <nameServer> <theatersFile>

*input_file -- the star input file
*nameSerer -- the name of the naimng server (default: localhost)
*theatersFile -- file contains all theaters available for use, listed by line (default: theatersFile.txt)




