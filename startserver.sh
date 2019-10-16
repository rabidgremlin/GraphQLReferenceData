#!/bin/bash

service postgresql start
postgraphile -n 0.0.0.0 -c postgres://graphqlref:graphqlref@0.0.0.0/graphqlref --no-ignore-rbac --disable-default-mutations --dynamic-json --append-plugins @graphile-contrib/pg-simplify-inflector --enhance-graphiql