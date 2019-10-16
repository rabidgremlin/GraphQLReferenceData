FROM ubuntu:18.04

RUN apt-get update

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get -y install postgresql postgresql-contrib nodejs npm

RUN npm install -g postgraphile @graphile-contrib/pg-simplify-inflector

COPY countries.csv /tmp/countries.csv
COPY setupdatabase.sql /tmp/setupdatabase.sql

USER postgres
RUN service postgresql start && \   
    psql -f /tmp/setupdatabase.sql 

USER root
COPY startserver.sh / 
RUN chmod u+x startserver.sh

ENTRYPOINT [ "./startserver.sh" ]

EXPOSE 5000
