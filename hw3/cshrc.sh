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
