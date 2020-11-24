#!/bin/bash

if [[ $1 = 'cassandra' ]]; then
  # Create default keyspace for single node cluster
  CQL="CREATE KEYSPACE mykeyspace WITH REPLICATION = {'class': 'SimpleStrategy', 'replication_factor': 1};
  CREATE TABLE mykeyspace.user(
   id  int,
   name text,
   surname text,
   followerList list<int>,
   createdAt timestamp,
   PRIMARY KEY (id)
   );
   CREATE TABLE mykeyspace.user_followers(
   id  int,
   followerList list<int>,
   PRIMARY KEY (id)
   );"
  until echo $CQL | cqlsh; do
    echo "cqlsh: Cassandra is unavailable - retry later"
    sleep 2
  done &
fi

exec /docker-entrypoint.sh "$@"
