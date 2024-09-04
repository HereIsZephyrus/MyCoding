from bs4 import BeautifulSoup
import json

my_list = [10, 20, 30, 40, 50]

with open('classification.html', 'r', encoding='utf-8') as file:
    html_content = file.read()

soup = BeautifulSoup(html_content, 'html.parser')

namespans = soup.find_all('span')
index = [0,1,2,4,5,7,9,10,12,13,14,16,20,21,22,25,27,28,29,30]
name = []
for (i, namespan) in enumerate(namespans):
    if i in index:
        name.append(namespan.text)

print(name)
with open('classify_name.json', 'w',encoding='utf-8') as file:
    json.dump(name, file)

# https://www.dianping.com/search/keyword/16/10_大悦城/g112r89797