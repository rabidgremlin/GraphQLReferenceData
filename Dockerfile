# using Ubuntu LTS base to make it easier to get things set up
FROM ubuntu:18.04

# update the packages lists
RUN apt-get update

# distable interaction during package installs
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# install postgres and node
RUN apt-get -y install postgresql postgresql-contrib nodejs npm

# install postgraphile and plugins
RUN npm install -g postgraphile @graphile-contrib/pg-simplify-inflector

# copy .csv files with reference data into container
COPY countries.csv /tmp/countries.csv
COPY cities.csv /tmp/cities.csv
COPY airports.csv /tmp/airports.csv

# copy database setup scripts into container
COPY setupdatabase.sql /tmp/setupdatabase.sql

# create, setup and populate database. Need to do this as user postgres
USER postgres
RUN service postgresql start && \   
    psql -f /tmp/setupdatabase.sql 
USER root

# copy startup script to server
COPY startserver.sh / 
RUN chmod u+x startserver.sh

# set startupscript as entry point
ENTRYPOINT [ "./startserver.sh" ]

# postgraphile runs on port 5000 by default.
EXPOSE 5000
