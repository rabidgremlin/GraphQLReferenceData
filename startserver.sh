#!/bin/bash

# start up postgres
service postgresql start

# start postgraphile with following options:
#   -n 0.0.0.0   <- bind to public interfaces of container 
#   -c postgres://graphqlref:graphqlref@0.0.0.0/graphqlref <- database connection details
#   --no-ignore-rbac <- use postgres db permissions to restrict what is exposed via graphql
#   --disable-default-mutations <- reference data only so disable writes (mutations) 
#   --dynamic-json <- recommened allows dynamic JSON in inputs/outputs
#   --append-plugins @graphile-contrib/pg-simplify-inflector <- adds simplify inflector plugin which makes schema prettier
#   --enhance-graphiql <- turns on extract graphiql features
#
# see https://www.graphile.org/postgraphile/usage-cli/ for more details
postgraphile -n 0.0.0.0 -c postgres://graphqlref:graphqlref@0.0.0.0/graphqlref --no-ignore-rbac --disable-default-mutations --dynamic-json --append-plugins @graphile-contrib/pg-simplify-inflector --enhance-graphiql