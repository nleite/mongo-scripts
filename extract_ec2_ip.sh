#!/bin/sh

IN=$1
OUT=listaddress
if [ ! -z $2 ]; then
    OUT=$2;
fi

cat $IN | awk --FS=":" ' {print $2}' | awk 'BEGIN { FS = "." } ; { print $1 }' | sed 's/-/./g' | sed 's/ec2.//g' > $OUT
cat $OUT
