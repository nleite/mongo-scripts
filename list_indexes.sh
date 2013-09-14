#!/bin/sh


mongo --host $1 --eval " db.system.indexes.find().forEach( function(x){  printjson(x);})"


