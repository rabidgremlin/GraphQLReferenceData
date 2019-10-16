import pandas as pd

countries = pd.read_csv('countries.dat', delimiter=',', names = ['name','code','oa_code','dst'])

countries = countries[['code','name']]
countries.columns  = ['iso_code','name']

print(countries)

countries.to_csv('..\countries.csv', sep=',', header=False, index=True)