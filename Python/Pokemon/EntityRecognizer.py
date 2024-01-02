import DashCore as db
import csv
import re
import jieba
from DashCore import stopwords 
def FutherRequire(require_type):
    res={}
    match require_type:
        case 'area':
            line=input("请问是在哪里遇到的呢?(N)")
            if (line=='N'):
                return res
            for item in db.areas_name:
                area_name=db.areas_name[item]
                if (line.find(area_name)!=-1):
                    res={'地区':area_name}
        case 'attribute':
            line=input("看得出他的属性吗?(N)")
            if (line=='N'):
                return res
            for item in db.attribute:
                if (line.find(item)!=-1):
                    res={'属性':item}
        case 'recreation':
            line=input("你有看到他的蛋吗?(N)")
            if (line=='N'):
                return res
            for item in db.egg:
                if (line.find(item)!=-1):
                    res={'蛋':item}
        case 'ability':
            line=input("看得出他的特性吗?(N)")
            if (line=='N'):
                line=input("那么能描述一下他的行为特点和行为吗?(N)")
                if (line=='N'):
                    return res
                else:
                    raw=list(jieba.cut(line,cut_all=True))
                    content=[word for word in raw if word not in stopwords]
                    res={'描述':content}
            for item in db.abilities:
                if (line.find(item)!=-1):
                    res={'特性':item}
    return res
def InferState(statement):
    statement=statement.partition(',')[0]
    value=ToDigit(re.findall(r'\d',statement))
    surplus=['超过','大于','不低于','不小于','>','>=']
    equal=['是','等于','=']
    less=['低于','小于','不超过','不大于','<','<=']
    relates=''
    for each in surplus:
        if (statement.find(each)!=-1):
            relates='>'
            break
    for each in equal:
        if (statement.find(each)!=-1):
            relates='='
            break
    for each in less:
        if (statement.find(each)!=-1):
            relates='<'
            break
    if relates=='':
        restatement=input('请再描述一下宝可梦的等级(如:他看起来不是很壮的,攻击力不超过70吧)')
        return InferState(restatement)
    else:
        return relates+str(value)
def ToDigit(numList):
    res=0
    for digit in numList:
        res=res*10+int(digit)
    return res
def element(string):
    elementlist={}
    #name
    for name in db.en_name:
       if (name!='' and string.find(name)!=-1):
            elementlist.update({'英文名':name}) 
    for name in db.jp_name:
       if (name!='' and string.find(name)!=-1):
            elementlist.update({'日文名':name})  
    if (len(elementlist)>0):
        return elementlist#Can be definitely classified
    #area
    area_name=''
    for item in db.areas_name:
        if (string.find(db.areas_name[item])!=-1):
            elementlist.update({'地区':db.areas_name[item]})
            area_name=db.areas_name[item]
    if (len(area_name)==0):
        area_name=FutherRequire('area')
        if (len(area_name)):
            elementlist.update({'地区':area_name})
    # attribute
    attribute=''
    for item in db.attribute:
       if (string.find(item)!=-1):
            elementlist.update({'属性':item})
            attribute=item
    if (len(attribute)==0):
        attribute=FutherRequire('attribute')
        if (len(attribute)):
            elementlist.update({'属性':attribute})
    # recreation
    recreation=''
    for item in db.egg:
       if (string.find(item)!=-1):
            elementlist.update({'蛋':item})
            recreation=item
    if (len(recreation)==0):
        recreation=FutherRequire('recreation')
        if (len(recreation)):
            elementlist.update({'蛋':recreation})
    # ability
    ability=''
    for item in db.ability_token:
       if (string.find(item)!=-1):
            elementlist.update({'特性':item})
            ability=item
    if (len(ability)==0):
        ability=FutherRequire('ability')
        if (len(ability)):
            elementlist.update({'特性':ability})
    #level
    level=''
    for each in ['level','级']:
        point=string.find(each)
        if (point>=1 and string[point-1]>='0' and string[point-1]<='9'):
            elementlist.update({'Level':ToDigit(re.findall(r'\d',string[point-5:point]))})
    #power
    for each in ['HP','生命','血']:
        point=string.find(each)    
        if (point!=-1):
            elementlist.update({'HP':InferState(string[point:point+25])})
    for each in ['ATK','攻击']:
        point=string.find(each)
        if (point!=-1):
            elementlist.update({'ATK':InferState(string[point:point+25])})
    for each in ['DEF','防御']:
        point=string.find(each)
        if (point!=-1):
            elementlist.update({'DEF':InferState(string[point:point+25])})
    for each in ['SPA','特功']:
        point=string.find(each)
        if (point!=-1):
            elementlist.update({'SPA':InferState(string[point:point+25])})
    for each in ['SPD','特防']:
        point=string.find(each)
        if (point!=-1):
            elementlist.update({'SPD':InferState(string[point:point+25])})
    for each in ['SPE','速度']:
        point=string.find(each)
        if (point!=-1):
            elementlist.update({'SPE':InferState(string[point:point+25])})
    return elementlist

#if __name__ == '__main__':
#    print(element("我在关都地区在遇到了一只宝可梦,是草系的,大概是21级,攻击力大于60"))