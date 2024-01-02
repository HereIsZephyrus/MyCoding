import numpy as np
import pandas as pd
import jieba
from DashCore import stopwords 
table=pd.read_csv('./base/ability.csv')
context=table['描述'].tolist()
name=table['中文名'].tolist()
context=context[:len(context)-1]
name=name[:len(name)-1]

token={}
for ability in context:
    ab=name[context.index(ability)]
    ability=ability.replace('ＨＰ','HP')
    ability=ability.replace('ＰＰ','招式点数')
    ability=ability.replace('1','一')
    raw=list(jieba.cut(ability,cut_all=True))
    token[ab]=[word for word in raw if word not in stopwords]
with open('ability_token.txt','w') as file:
    file.write('ablity_token='+str(token))