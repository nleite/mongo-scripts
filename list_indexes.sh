#!/bin/sh

INDEXCOMMAND="function(y){ print(y);  _db=db.getSisterDB(y); _db.system.indexes.find().forEach( function(x){ printjson(x);});}"
mongo --host $1 --eval "db.setSlaveOk(); ldbs=db.adminCommand( {listDatabases:1})['databases']; dbnames=[]; ldbs.forEach(function(x){ dbnames.push(x.name);}); dbnames.forEach($INDEXCOMMAND );"
