#!/bin/bash

cat sql/step_01.sql | envsubst | PGPASSWORD=$PG_PWD psql -h $PG_SERVER -p $PG_PORT -d $db -U $PG_USER -q -v myparam=test
