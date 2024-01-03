#coding:utf-8
#from pyke import knowledge_engine
#engine=knowledge_engine.engine('./IE')
#engine.activate('rules')
#engine.get_kb('pokemons').dump_specific_facts()

from bs4 import BeautifulSoup as bs
from DashCore import filterlist
from DashCore import zh_name as total
import EntityRecognizer as recognizer
import numpy as np
import TypeMatchupCalc as matchup
import pandas as pd
def satisfy(val,signal,bias):
    match signal:
        case '<':
            if (val-bias<0):
                return True
        case '=':
            if (abs(val)<bias):
                return True
        case '>':
            if (val+bias>0):
                return True
    return False

def CheckLevel(pokemon,level):
    checked=pokemon
    parent={}
    filename='./IE/evolution.txt'
    f=open(filename,'r')
    line=f.readline()
    while line:
        predicate=line.partition('(')[0]
        if (predicate=='evolution'):
            before=line.partition('(')[2].partition(',')[0]
            after=line.partition(',')[2].partition(')')[0]
            parent.update({after:before})
        if (predicate=='level_limit'):
            name=line.partition(',')[2].partition(')')[0]
            limit=int(line.partition('(')[2].partition(',')[0])
            #print(name,limit)
            #c=input()
            for body in pokemon:
                #print(parent)
                #print(body,name)
                if body in parent.keys() and parent[body]==name and limit>=level:
                    checked.remove(body)
        line=f.readline()
    f.close()
    return checked

def Infer(facts,universe):
    pokemon=universe
    filters=[]
    level=0
    for item in facts:
        if (item=='Level'):
            level=facts['Level']
            continue
        filters.append(filterlist[item])
    infered={'地区':[],'属性0':[],'属性1':[],'特性0':[],'特性1':[],'蛋0':[],'蛋1':[],'HP':[],'ATK':[],'DEF':[],'SPA':[],'SPD':[],'SPE':[]}
    filename='./IE/pokemons.txt'
    f = open(filename,'r')
    line = f.readline()
    #count=0
    if ('英文名' in filters) or ('日文名' in filters):
        while line:
            content=line.partition('(')[2].partition(')')[0].split(',')
            if (content[0]==facts['日文名']):
                return content[1]
            if (content[0]==facts['英文名']):
                return content[1]
            line = f.readline()
    else:
        while line:
            #print(line)
            predicate=line.partition('(')[0]
            if predicate in filters:
                content=line.partition('(')[2].partition(')')[0].split(',')
                #print(content)
                match predicate:
                    case 'live_in':
                        if (facts['地区']==content[1]):
                            infered['地区'].append(content[0])
                    case 'own_type':
                        for item in facts['属性']: 
                            if (item==content[0]):
                                infered['属性'+str(facts['属性'].index(item))].append(content[1])
                    case 'own_ability':
                        if (facts['特性']==content[0]):
                            infered['特性'].append(content[1])
                    case 'pit_egg':
                        for item in facts['蛋']: 
                            if (item.find(content[0])!=-1):#水中
                                infered['蛋'+str(facts['蛋'].index(item))].append(content[1])
                    case 'has_HP':
                        signal=facts['HP'][0]
                        val=(int(facts['HP'][1:])-facts['Level']-10)*100/facts['Level']/2
                        if (satisfy(int(content[0])-val,signal,10)):
                            infered['HP'].append(content[1])
                    case 'has_DEF':
                        signal=facts['DEF'][0]
                        val=(int(facts['DEF'][1:])-facts['Level']-5)*100/facts['Level']/2
                        if (satisfy(int(content[0])-val,signal,10)):
                            infered['DEF'].append(content[1])
                    case 'has_SPA':
                        signal=facts['SPA'][0]
                        val=(int(facts['SPA'][1:])-facts['Level']-5)*100/facts['Level']/2
                        if (satisfy(int(content[0])-val,signal,10)):
                            infered['SPA'].append(content[1])
                    case 'has_SPD':
                        signal=facts['SPD'][0]
                        val=(int(facts['SPD'][1:])-facts['Level']-5)*100/facts['Level']/2
                        if (satisfy(int(content[0])-val,signal,10)):
                            infered['SPD'].append(content[1])
                    case 'has_SPE':
                        signal=facts['SPE'][0]
                        val=(int(facts['SPE'][1:])-facts['Level']-5)*100/facts['Level']/2
                        if (satisfy(int(content[0])-val,signal,10)):
                            infered['SPE'].append(content[1])
                    case 'has_ATK':
                        signal=facts['ATK'][0]
                        val=(int(facts['ATK'][1:])-facts['Level']-5)*100/facts['Level']/2
                        if (satisfy(int(content[0])-val,signal,10)):
                            infered['ATK'].append(content[1])
            line = f.readline()
            #count+=1
    #print(count)
    f.close()
    for value in infered.values():
        if (value==[]):
            continue
        pokemon=list(set(pokemon).intersection(set(value)))
        #print(value)
        #print(len(value))
        c=input()
    if (level!=0):
        pokemon=CheckLevel(pokemon,level)
    return pokemon

def suggest_type(ATK,DEF):
    name=[]
    with open('./base/type.csv','r') as file:
        table=pd.read_csv(file)
        name=list(table.iloc[:,0])
    relation={'无效':[],'劣势':[],'拔群':[]}
    for i in range(len(ATK)):
        if (ATK[i]>1):
            relation['拔群'].append(name[i])
    for i in range(len(DEF)):
        if (DEF[i]==0):
            relation['无效'].append(name[i])
        if (DEF[i]<1):
            relation['劣势'].append(name[i])
            
    return relation

def CheckPrint(output):
    if type(output)==list:
        return ','.join(output)
    else:
        return output
def print_list(pokemons):
    dictory = np.load('./base/dictory.npy', allow_pickle=True)
    general_ATK=np.array([1.0]*18)
    general_DEF=np.array([1.0]*18)
    for item in dictory:
        for body in pokemons:
            if (item['中文名']==body):
                attribute=item['属性'].replace("'",'').replace(" ",'').strip('[').strip(']').split(',')
                ATK=matchup.CalcATK(attribute)
                DEF=matchup.CalcDEF(attribute)
                general_ATK=general_ATK*ATK
                general_DEF=general_DEF*DEF
                match_table=suggest_type(ATK,DEF)
                #print(ATK,DEF)
                #c=input()
                print(f"有可能是{body}({item['英文名']},{item['日文名']}),{CheckPrint(attribute)}属性,具有{CheckPrint(item['特性'])}特性和{item['隐藏特性']}隐藏特性,生蛋区为{CheckPrint(item['生蛋区'])},种族面板是{item['面板']},根据属性相克关系不能使用{CheckPrint(match_table['无效'])}系宝可梦,最好不要使用{CheckPrint(match_table['劣势'])}系宝可梦,建议使用{CheckPrint(match_table['拔群'])}系宝可梦\n")
    match_table=suggest_type(general_ATK,general_DEF)            
    #print(f"总体来说根据属性相克关系建议使用{CheckPrint(match_table['拔群'],1)}系宝可梦\n")
    return True

def InferOutput(facts):
    statement=''
    pokemon=Infer(facts,total)
    print_list(pokemon)
    while (len(pokemon)>1):
        sentence=input("你还能提供其他信息吗?(N)")
        if (sentence=='N'):
            break
        facts_add=recognizer.element(sentence)
        facts.update(facts_add)
        print(facts)
        pokemon=Infer(facts,pokemon)
        print_list(pokemon)
    return pokemon