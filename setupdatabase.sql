CREATE DATABASE graphqlref;
CREATE USER graphqlref password 'graphqlref';
GRANT ALL PRIVILEGES ON DATABASE graphqlref TO graphqlref;

\c graphqlref

CREATE TABLE countries (
    id int PRIMARY KEY,
    countryCode varchar(2) NOT NULL UNIQUE,
    name varchar(100) NOT NUll UNIQUE
);

GRANT ALL PRIVILEGES ON TABLE countries TO graphqlref;

--INSERT INTO countries VALUES ('0','AA','Aruba');
--INSERT INTO countries VALUES ('2','AE','United Arab Emirates');

COPY countries
FROM '/tmp/countries.csv' DELIMITER ',' CSV;
