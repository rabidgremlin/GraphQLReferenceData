# Using GraphQL and Docker to serve reference data with no coding
Demo of how reference data services can be created and deployed with no coding, using GraphQL and docker.

# Running the demo

## 1. Build the docker image

1. Clone or download this repo
2. Run
```
docker build -t graphqlref .
```

## 2. Start the server
```
docker run --rm -it -p 5000:5000  graphqlref
```
You can press Ctrl+C to shutdown and clean up the image

## 3. Access the server

1. Access the webased GUI at  http://localhost:5000/graphiql
2. Access the GraphQL endpint at http://localhost:5000/graphql

For example:
```
curl -X POST 'http://localhost:5000/graphql' -H 'Content-Type: application/json' -d '{"query":"query AirportsInNZ {\n  country(countryCode: \"NZ\") {\n    airports {\n      nodes {\n        iataCode\n        name\n        elevation\n      }\n    }\n  }\n}\n","variables":null,"operationName":"AirportsInNZ"}' 
```

# License
The code in this repo is released under the Apache 2.0 License.

The sample data set used in this demo is built from the awesome OpenFlights data set.
**NOTE: This data is not under the Apache 2.0 license nor, is it for commercial and navigation use. See https://openflights.org/data.html#license for more details**