"""Not too terrible script to create some sample data for the demo."""
import pandas as pd

print("Loading countries.dat....")

# load countries data
countries = pd.read_csv('countries.dat', delimiter=',', names = ['name','code','oa_code','dst'])

# drop uneeded columns
countries = countries[['code','name']]

print("Loading airports.dat....")

# load airports data
airports = pd.read_csv('airports.dat', delimiter=',', names = ['apid','name','city','country','iata','icao','y','x','elevation','timezone','dst','tz_id','type','source'])

# drop any records that don't have the data we require
airports = airports[airports.tz_id != '\\N']
airports = airports[airports.city != '\\N']
airports = airports[airports.country != '\\N']

# rename countries for joining 
countries.columns  = ['country_code','country']

# join airport data to country data using country name, inner join
airports_with_country_codes = pd.merge(airports, countries, on='country', how='inner')

# extract list of countries from joined data
countries = airports_with_country_codes[['country_code','country']]

# remove dups 
countries = countries.drop_duplicates()

# save final data country data to new .csv, will use country_code as natural key
countries.to_csv('../countries.csv', sep=',', header=False, index=False)

print("Wrote ../countries.csv")

# extract city data from airport data
cities = airports_with_country_codes[['country_code','city','tz_id']]

# drop dups and reindex
cities = cities.drop_duplicates().reset_index(drop=True)

# save final city data to new .csv, use index as id for city as no natural key
cities.to_csv('../cities.csv', sep=',', header=False, index=True)

print("Wrote ../cities.csv")

# convert index into column
cities['city_id'] = cities.index

# join cities back into airport/country data so that we can have city id for each airport, include tz as sometimes
# have city with same name in same country
airports_with_cities_id = pd.merge(airports_with_country_codes, cities, how='inner',  on=['city','country_code','tz_id'],validate='many_to_one')

# remove dups and reindex 
airports_with_cities_id = airports_with_cities_id.drop_duplicates().reset_index(drop=True)

# drop columns we don't want, _x names are due to dup column names in merges
airports = airports_with_cities_id[['name','city_id','country_code','iata','icao','y','x','elevation','tz_id']]

# check for dups just in case data was bad and messed up our joins
dup_airports = airports[airports.duplicated(['name','iata','icao'])]
if len(dup_airports) > 0:
    print("WARNING: Found duplicate airports. Check data!")
    print(dup_airports)

# save final airports data to new .csv, use index as id for city as no natural key
airports.to_csv('../airports.csv', sep=',', header=False, index=True)

print("Wrote ../airports.csv")
print("Done!")
