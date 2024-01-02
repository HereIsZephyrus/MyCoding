from pprint import pprint 
import csv

file=open(f"./dict/ability.html",'r')
context=file.read()
context=context.partition('<tbody>')[2] #begin with table
context=context.partition('</tbody>')[0] #end with table
raw_ability=context.split('</tr>')
zh_name=[]
en_name=[]
jp_name=[]
discribe=[]
for data in raw_ability[1:]:
    pprint(data)
    point=data.find('a.name_zh')
    zh_name.append(data[point+data[point:].find('>')+1:point+data[point:].find('<')])
    point=point+data[point:].find('a.name_en')
    en_name.append(data[point+data[point:].find('>')+1:point+data[point:].find('<')])
    point=point+data[point:].find('a.name_jp')
    jp_name.append(data[point+data[point:].find('>')+1:point+data[point:].find('<')])
    point=point+data[point:].find('a.brief_description')
    discribe.append(data[point+data[point:].find('>')+1:point+data[point:].find('<')])
        
file.close()

with open(f'./base/ability.csv','w', newline='',encoding="utf-8") as f_output:
    writer=csv.writer(f_output)
    writer.writerow(['中文名','英文名','日文名','描述'])
    writer.writerows(zip(zh_name,en_name,jp_name,discribe))
