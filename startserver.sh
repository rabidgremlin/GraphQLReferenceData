#!/bin/bash

service postgresql start
postgraphile -n 0.0.0.0 -c postgres://graphqlref:graphqlref@0.0.0.0/graphqlref --enhance-graphiql --dynamic-json