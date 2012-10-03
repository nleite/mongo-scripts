#!/bin/sh
LOGFILE=mongodb-shardsvr.log
if [ ! -z $1 ]; then LOGFILE=$1; fi

if [ -f $LOGFILE ] 
    then
        echo "Looking for slow queries on $LOGFILE";
else
    echo "Cannot look into file $LOGFILE";
    exit -1;
fi

OUTFILE=slowqueries.out

if [ ! -z $2 ]; then OUTFILE=$2; fi

egrep "[0-9]{3,}ms" $LOGFILE | egrep -Ev "[0-9]{10,}ms" | awk '{ print $NF, $0}' | sort -rn > $OUTFILE
