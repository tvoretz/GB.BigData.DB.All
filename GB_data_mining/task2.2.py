import requests
import json

def create_url(page):
	return 'https://icorating.com/ico/all/load/?page={}&sort=investment_rating&direction=desc'.format(page)

# get last page
result = requests.get(create_url(page=1))
data = result.json()
last_page = data['icos']['last_page']

for page in range(1, last_page+1):
	result = requests.get(create_url(page=page))
	data = result.json()
	data_len = len(data['icos']['data'])

	for ico in range(0, data_len):
		current_ico = data['icos']['data'][ico]
		id = current_ico['id']
		f = open("{}.json".format(id), "w+", encoding='utf-8')
		json.dump(current_ico, f)
		f.close

print("Done")