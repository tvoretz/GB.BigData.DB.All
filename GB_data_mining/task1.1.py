import requests

url = 'https://icobench.com/icos'
data = []

for i in range(1, 470):
	params = {'page': i}
	result = requests.get(url, params=params)
	f = open("icobench_ico_page_{}.html".format(i), "w+", encoding='utf-8')
	f.write(result.text)
	f.close

print("Done")

