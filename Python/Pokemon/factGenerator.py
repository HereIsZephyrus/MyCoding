import DashCore as db
import pandas as pd
import csv
LIVE_IN='' #live_in($pokemon,$area)
EN_TRANS='' 
JP_TRANS=''
AB_OWN='' #own_ability($pokemon,$ability)
TYPE_OWN='' #own_type($pokemon,$type)
RECREATION_IN='' #pit_egg($pokemon,$egg)
HP_OWN=''
ATK_OWN=''
DEF_OWN=''
SPA_OWN=''
SPD_OWN=''
SPE_OWN=''
for item in db.areas_name:
    table=pd.read_csv(f'./base/{item}.csv')
    for row in table.itertuples():
        LIVE_IN=LIVE_IN+f'live_in({row[1]},{db.areas_name[item]})\n'
        EN_TRANS=EN_TRANS+f'en_trans{row[2],row[1]}\n'
        JP_TRANS=JP_TRANS+f'jp_trans{row[3],row[1]}\n'
        for types in str(row[4]).split(','):
            val=types.replace("'",'')
            val=val.replace('[','').replace(']','')
            TYPE_OWN=TYPE_OWN+f'own_type({val},{row[1]})\n'.replace(' ','')
        for egg in str(row[5]).split(','):
            val=egg.replace("'",'')
            val=val.replace('[','').replace(']','')
            RECREATION_IN=RECREATION_IN+f'pit_egg({val},{row[1]})\n'.replace(' ','')
        for ability in str(row[6]).split(','):
            val=ability.replace("'",'')
            val=val.replace('[','').replace(']','')
            AB_OWN=AB_OWN+f'own_ablity({val},{row[1]})\n'.replace(' ','')
        power=row[8].strip('[').strip(']').replace(' ','')
        power=power.split(',')
        HP_OWN=HP_OWN+f'has_HP({power[0]},{row[1]})\n'
        ATK_OWN=ATK_OWN+f'has_ATK({power[1]},{row[1]})\n'
        DEF_OWN=DEF_OWN+f'has_DEF({power[2]},{row[1]})\n'
        SPA_OWN=SPA_OWN+f'has_SPA({power[3]},{row[1]})\n'
        SPD_OWN=SPD_OWN+f'has_SPD({power[4]},{row[1]})\n'
        SPE_OWN=SPE_OWN+f'has_SPE({power[5]},{row[1]})\n'
file=open('./IE/pokemons.kfb','w')
file.write(LIVE_IN)
file.write(EN_TRANS)
file.write(JP_TRANS)
file.write(TYPE_OWN)
file.write(RECREATION_IN)
file.write(AB_OWN)
file.write(HP_OWN)
file.write(ATK_OWN)
file.write(DEF_OWN)
file.write(SPA_OWN)
file.write(SPD_OWN)
file.write(SPE_OWN)

file.write(f'next_to({db.areas_name["kanto"]},{db.areas_name["johto"]})')
print(f'next_to({db.areas_name["kanto"]},{db.areas_name["johto"]})')
file.close()