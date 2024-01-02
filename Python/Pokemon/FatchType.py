from pprint import pprint 
from lxml import html
import requests
from bs4 import BeautifulSoup
import csv
import pandas
url=''.join('https://wiki.52poke.com/wiki/属性相克表').encode('utf-8')
headers={"User-Agent" : "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36(KHTML,like Gecko) Chrome/79.0.3945.88 Safari/537.36",
  "Accept" : "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
  "Connection" : "keep-alive"}

page = requests.get(url)
soup=BeautifulSoup(page.text,'html.parser')
table=soup.find('table',class_='roundy hover at-c')

for data in table.find_all('tbody'):
    rows=data.find_all('tr')
typeline=rows[1].find_all('td')
types=['']
for i in range(len(typeline)):
    types.append(typeline[i].text.replace('\n',''))

file=open('./dict/type.csv','w',newline='',encoding='utf-8')
writer=csv.writer(file)
writer.writerow(types)

rows=rows[2:len(rows)-1] #abandon the head and tail
for line in rows:
    relations=line.find_all('td')
    row=[types[rows.index(line)]]
    for i in range(1,len(relations)):
        row.append(relations[i].text.replace('\n',''))
    writer.writerow(row)
print(types)
print(len(types))

file.close()