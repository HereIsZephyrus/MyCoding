import pandas as pd
import numpy as np
def CalcATK(type_toATK):
    relation=np.array([1.0]*18)
    type_toATK=list(type_toATK)
    for attri in type_toATK:
        with open('./base/type.csv','r') as file:
            if (attri=='超能'):
                attri='超能力'
            table=pd.read_csv(file)
            name=list(table.iloc[:,0])
            index=name.index(attri)
            row=list(table.iloc[index,1:])
            for i in range(len(row)):
                match row[i]:
                    case '1×':
                        continue
                    case '0×':
                        relation[i]=0
                    case '2×':
                        relation[i]*=2
                    case '1⁄2×':
                        relation[i]*=0.5
    return relation

def CalcDEF(type_toDEF):
    relation=np.array([1.0]*18)
    type_toDEF=list(type_toDEF)
    for attri in type_toDEF:
        with open('./base/type.csv','r') as file:
            if (attri=='超能'):
                attri='超能力'
            table=pd.read_csv(file)
            name=list(table.iloc[:,0])
            index=name.index(attri)
            row=list(table.iloc[0:,index])
            for i in range(len(row)):
                match row[i]:
                    case '1×':
                        continue
                    case '0×':
                        relation[i]=0
                    case '2×':
                        relation[i]*=2
                    case '1⁄2×':
                        relation[i]*=0.5
    return relation