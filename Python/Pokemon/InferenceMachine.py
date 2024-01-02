#coding:utf-8
#from pyke import knowledge_engine
#engine=knowledge_engine.engine('./IE')
#engine.activate('rules')
#engine.get_kb('pokemons').dump_specific_facts()

from bs4 import BeautifulSoup as bs
from DashCore import filterlist
from DashCore import zh_name as total
import EntityRecognizer as recognizer
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
def Infer(facts,universe):
    pokemon=universe
    filters=[]
    for item in facts:
        if (item=='Level'):
            continue
        filters.append(filterlist[item])
    infered={'地区':[],'属性0':[],'属性1':[],'特性0':[],'特性1':[],'蛋0':[],'蛋1':[],'HP':[],'ATK':[],'DEF':[],'SPA':[],'SPD':[],'SPE':[]}
    filename='./IE/pokemons.txt'
    f = open(filename)
    line = f.readline()
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
            kb_type=line.partition('(')[0]
            if kb_type in filters:
                content=line.partition('(')[2].partition(')')[0].split(',')
                #print(content)
                match kb_type:
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
    for value in infered.values():
        if (value==[]):
            continue
        pokemon=list(set(pokemon).intersection(set(value)))
        #print(value)
        #print(len(value))
        #c=input()
    return pokemon

def print_list(pokemons):
    for body in pokemons:
        print(f'有可能是{body}\n')
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