#!/bin/sh
OUTFILE=stats.log
ERRORFILE=run.error
if [ ! -z $1 ]; then OUTFILE=$1; fi


function do_du
{
    path=$(grep 'dbpath' $1 | awk 'BEGIN{ FS="=";} {print $2;}') 
    if [ -n "$path" ] 
    then
        echo "[du '$path']" >> $OUTFILE
        du -h $path >> $OUTFILE 2>$ERRORFILE
    fi
}

echo "[lsof]" > $OUTFILE
lsof -c mongod >> $OUTFILE 2> $ERRORFILE
echo "[iostat]" >> $OUTFILE 
iostat  -c 20 >> $OUTFILE 2> $ERRORFILE
echo "[netstat]" >> $OUTFILE 
netstat -s >> $OUTFILE 2> $ERRORFILE
netstat -an >> $OUTFILE 2> $ERRORFILE
echo "[processes]" >> $OUTFILE
ps -elf | egrep 'UID|mongod' >> $OUTFILE 2> $ERRORFILE
echo "[ulimit]" >> $OUTFILE
ulimit -a >> $OUTFILE 2> $ERRORFILE
echo "[vmstat]" >> $OUTFILE
vmstat -c 5 >> $OUTFILE 2> $ERRORFILE 
echo "[mongostat]" >> $OUTFILE
mongostat -n 20 >> $OUTFILE 2> $ERRORFILE
echo "[df]" >> $OUTFILE
df -h  >> $OUTFILE 2> $ERRORFILE
echo "[mount]" >> $OUTFILE
mount  >> $OUTFILE 2> $ERRORFILE

for i in $(ls /etc/)
do
    do_du "/etc/"$i
done
