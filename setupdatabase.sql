-- Create the database
CREATE DATABASE graphqlref;
CREATE USER graphqlref password 'graphqlref';
GRANT ALL PRIVILEGES ON DATABASE graphqlref TO graphqlref; -- in production we'd want to reduce these rights

-- switch to graphqlref database
\c graphqlref

-- create the countries table
CREATE TABLE countries (
    country_code varchar(2) PRIMARY KEY,
    name varchar(100) NOT NUll UNIQUE
);
GRANT ALL PRIVILEGES ON TABLE countries TO graphqlref; -- in production we'd want to reduce these rights

-- create the cities table
CREATE TABLE cities (
    id int PRIMARY KEY,
    country_code varchar(2) NOT NUll REFERENCES countries(country_code),
    name varchar(100) NOT NUll,
    timezone_id varchar(30) NOT NUll
);
CREATE INDEX country_code_idx_cities ON cities(country_code); -- postgres doesn't create indexes for foreign keys
GRANT ALL PRIVILEGES ON TABLE cities TO graphqlref; -- in production we'd want to reduce these rights

-- create the airports table
CREATE TABLE airports (
    id int PRIMARY KEY,
    name varchar(100) NOT NUll,
    city_id int NOT NUll REFERENCES cities(id),
    country_code varchar(2) NOT NUll REFERENCES countries(country_code),
    iata_code varchar(3) UNIQUE,    
    icao_code varchar(4) UNIQUE,      
    latitude float NOT NUll,
    longitude float NOT NUll,
    elevation int NULL,
    timezone_id varchar(30) NOT NUll
);
CREATE INDEX country_code_idx_airports ON airports(country_code); -- postgres doesn't create indexes for foreign keys
CREATE INDEX city_id_idx_airports ON airports(city_id); -- postgres doesn't create indexes for foreign keys
GRANT ALL PRIVILEGES ON TABLE airports TO graphqlref; -- in production we'd want to reduce these rights

-- because we are using country_code instead of country_id we need to give postgraphile how we want to name these relationships
COMMENT ON CONSTRAINT "cities_country_code_fkey" on "cities" is E'@foreignFieldName cities\n@fieldName country';
COMMENT ON CONSTRAINT "airports_country_code_fkey" on "airports" is E'@foreignFieldName airports\n@fieldName country';

-- load the countries table from .csv file
COPY countries
FROM '/tmp/countries.csv' DELIMITER ',' CSV NULL AS '\N';

-- load the cities table from .csv file
COPY cities
FROM '/tmp/cities.csv' DELIMITER ',' CSV NULL AS '\N';

-- load the airports table from .csv file
COPY airports
FROM '/tmp/airports.csv' DELIMITER ',' CSV NULL AS '\N';
