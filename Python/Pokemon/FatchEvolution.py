from pprint import pprint 
from lxml import html
import requests
from bs4 import BeautifulSoup
import csv
import pandas as pd
import numpy as np
url=''.join('https://wiki.52poke.com/zh-hans/宝可梦进化等级列表').encode('utf-8')
headers={"User-Agent" : "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36(KHTML,like Gecko) Chrome/79.0.3945.88 Safari/537.36",
  "Accept" : "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
  "Connection" : "keep-alive"}

#page = requests.get(url)
kb1=open('./IE/evolution.kfb','w')
kb2=open('./IE/evolution.txt','w')
with open('./dict/Evolution.html','r') as file:
    page=file.read()
    soup=BeautifulSoup(page,'html.parser')
    table=soup.find('table',class_='b-神奇宝贝百科 bg-神奇宝贝百科 roundy eplist sortable jquery-tablesorter')
    mediate={}
    evlove={}
    for data in table.find_all('tbody'):
        rows=data.find_all('tr')
        for row in rows:
            #print(row)
            typeline=row.find_all('td')
            after=typeline[2].text.replace('\n','')
            before=typeline[4].text.replace('\n','')
            terminal=typeline[5].text.replace('\n','')
            if (after==before):
              continue
            if (terminal=='✔' and before in mediate):
              kb1.write(f'evolution({mediate[before]},{after})\n')
              kb2.write(f'evolution({mediate[before]},{after})\n')
              evlove[mediate[before]]=after
            else:
              kb1.write(f'evolution({before},{after})\n')
              kb2.write(f'evolution({before},{after})\n')
              mediate[before]=after
            #print(f'evolution({before},{after}),{terminal}\n')
            #c=input()
              
with open('./dict/Level.html','r') as file:
    page=file.read()
    soup=BeautifulSoup(page,'html.parser')
    table=soup.find('table',class_='roundy sortable bg-神奇宝贝百科 bd-神奇宝贝百科 eplist jquery-tablesorter')
    for data in table.find_all('tbody'):
        rows=data.find_all('tr')
        rows=rows[:len(rows)-1]
        for row in rows:
            #print(row)
            typeline=row.find_all('td')
            name=typeline[2].text.replace('\n','')
            level=typeline[3].text.replace('\n','')
            kb1.write(f'level_limit({level},{name})\n')
            kb2.write(f'level_limit({level},{name})\n')
            #print(f'level_limit({level},{name})')
            #c=input()
kb1.close()
kb2.close()