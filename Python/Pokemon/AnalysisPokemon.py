from pprint import pprint 
#import requests
import csv
import os
import DashCore as db

areas=db.areas_name
os.system("/bin/mkdir base")
#total_zh_name=[]
#total_en_name=[]
#total_jp_name=[]
#total_attribute=[]
#total_egg=[]
#total_ability_hidden=[]
for item in areas:
    file=open(f"./dict/{item}.html",'r')
    context=file.read()
    print(context.encode)
    context=context.partition('<tbody>')[2] #begin with table
    context=context.partition('</tbody>')[0] #end with table
    raw_pekemons=context.split('</tr>')
    zh_name=[]
    en_name=[]
    jp_name=[]
    attribute=[]
    egg=[]
    ability_hidden=[]
    abilities=[]
    power=[]
    for data in raw_pekemons:
        point=data.find('tooltip=')
        if (point==-1): #header
            continue
        zh_name.append(data[point+9:point+data[point:].find('"',9)])
        #total_zh_name.append(data[point+9:point+data[point:].find('"',9)])
        point=data.find('p.name_jp')
        jp_name.append(data[point+data[point:].find('>')+1:point+data[point:].find('<')])
        #total_jp_name.append(data[point+data[point:].find('>')+1:point+data[point:].find('<')])
        point=data.find('p.name_en')
        en_name.append(data[point+data[point:].find('>')+1:point+data[point:].find('<')])
        #total_en_name.append(data[point+data[point:].find('>')+1:point+data[point:].find('<')])
        point=data.find('p.type_b" class="')
        templist=[]
        templist.append(data[point+data[point:].find('>')+1:point+data[point:].find('<')])
        #total_attribute.append(data[point+data[point:].find('>')+1:point+data[point:].find('<')])
        point=point+10
        if data[point+30:].find('p.type_b" class="')!=-1:
            point=point+data[point+30:].find('p.type_b" class="')
            templist.append(data[point+data[point:].find('>')+1:point+data[point:].find('<')])  
            #total_attribute.append(data[point+data[point:].find('>')+1:point+data[point:].find('<')])  
        #print(templist)
        attribute.append(templist)
        #print(attribute)
        #c=input()
        point=data.find('p.egg_group_b')
        temp=data[point+data[point:].find('>')+1:point+data[point:].find('<')]
        if (temp.find('+')!=-1):
            egg.append(temp.split('+'))
            #for egg_locate in temp.split('+'):
            #    total_egg.append(egg_locate)
        point=data.find('p.ability')
        temp=data[point+data[point:].find('>')+1:point+data[point:].find('<')]
        if (temp.find('/')!=-1):
            abilities.append(temp.split('/'))
        point=data.find('p.ability_hidden')
        ability_hidden.append(data[point+data[point:].find('>')+1:point+data[point:].find('<')])
        #total_ability_hidden.append(data[point+data[point:].find('>')+1:point+data[point:].find('<')])
        #print(ability_hidden)
        point=data.find('p.ev_defeated')
        point=point+data[point:].find('class="ng-binding ng-scope"')
        temp=[]
        temp.append(int(data[point+data[point:point+40].find('>')+1:point+data[point:point+40].find('<')]))
        for i in range(1,6):
            point=point+data[point+1:].find('class="ng-binding ng-scope"')
            temp.append(int(data[point+data[point:].find('>')+1:point+data[point:].find('<')]))    
            #print(temp)
            #print(point)
            point=point+10
        power.append(temp)
        #print(power)
    file.close()

    with open(f'./base/{item}.csv','w', newline='',encoding="utf-8") as f_output:
        writer=csv.writer(f_output)
        writer.writerow(['中文名','英文名','日文名','属性','生蛋区','特性','隐藏特性','面板'])
        writer.writerows(zip(zh_name,en_name,jp_name,attribute,egg,abilities,ability_hidden,power))

#total_zh_name=list(set(total_zh_name))
#total_en_name=list(set(total_en_name))
#total_jp_name=list(set(total_jp_name))
#total_attribute=list(set(total_attribute))
#total_ability_hidden=list(set(total_ability_hidden))
#total_egg=list(set(total_egg))

#with open('text.txt','w') as file:
#    file.write('zh_name='+str(total_zh_name)+f'\n')
#    file.write('en_name='+str(total_en_name)+f'\n')
#    file.write('jp_name='+str(total_jp_name)+f'\n')
#    file.write('attribute='+str(total_attribute)+f'\n')
#    file.write('ability_hidden='+str(total_ability_hidden)+f'\n')
#    file.write('egg='+str(total_egg)+f'\n')