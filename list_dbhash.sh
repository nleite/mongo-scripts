#!/bin/sh
DBHASHCOMMAND="function(y){ print(y);  _db=db.getSisterDB(y); x=_db.runCommand({dbhash:1}); printjson(x);}"
mongo --host $1 --eval "db.setSlaveOk(); ldbs=db.adminCommand( {listDatabases:1})['databases']; dbnames=[]; ldbs.forEach(function(x){ dbnames.push(x.name);}); dbnames.forEach($DBHASHCOMMAND );"
