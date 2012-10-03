OUTFILE=squeries.out
../turtle_queries.sh mongo.log $OUTFILE
cat $OUTFILE
rm -f $OUTFILE
