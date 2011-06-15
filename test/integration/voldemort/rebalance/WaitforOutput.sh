#!/bin/bash

set -x
if [ "$remote_call" == "" ]; then
  remote_call=eval
fi
if [ $# -gt 2 ]
then
  GREPSTR="("$1")|("$2")"
  LOGFILE=$3
  CMD=egrep
else
  GREPSTR=$1
  LOGFILE=$2
  CMD=grep
fi

$remote_call "$CMD \"$GREPSTR\" $LOGFILE" > /dev/null 2>&1
echo entering wait loop....
while [ "$?" -ne "0" ]
do
  sleep 3
  $remote_call "$CMD \"$GREPSTR\" $LOGFILE" > /dev/null 2>&1
done
echo exited wait loop!!!
