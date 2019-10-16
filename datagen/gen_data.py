import pandas as pd

# load countries data
countries = pd.read_csv('countries.dat', delimiter=',', names = ['name','code','oa_code','dst'])

# drop uneeded columns
countries = countries[['code','name']]


# show sample of data
print(countries)


# load airports data
airports = pd.read_csv('airports.dat', delimiter=',', names = ['apid','name','city','country','iata','icao','y','x','elevation','timezone','dst','tz_id','type','source'])

# show sample of data
print(airports)

# rename for joining 
countries.columns  = ['country_code','country']

airports_with_country_codes = pd.merge(countries, airports, on='country', how='inner')

print(airports_with_country_codes)

countries = airports_with_country_codes[['country_code','country']]
countries = countries.drop_duplicates().reset_index(drop=True)

print(countries)

# save final data to new .csv
countries.to_csv('../countries.csv', sep=',', header=False, index=True)


cities = airports_with_country_codes[['country_code','city']]
cities = cities.drop_duplicates().reset_index(drop=True)

print(cities)

# save final data to new .csv
cities.to_csv('../cities.csv', sep=',', header=False, index=True)