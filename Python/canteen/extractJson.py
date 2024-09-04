import json
import csv


places = ["dayuecheng","zuoling","guanggu","lumo","jianghan"]
classes = ["xiaochi","zizhu","huoguo","hubeicai","shaokao","mianguan","tesecai","xican","hanguoliaoli","chuancai","ribencai","xiangcai","kaorou","yuecai","xiaolongxia","luoshifen","dongbeicai","dongnanyacai","xinjiangcai","beibingcai"]

# export to csv
outputfile = f"./jsons/summary.csv"
with open(outputfile, 'w', newline='') as csvfile: 
    fields = ['place', 'type', 'num', 'max', 'min', 'mean']
    writer = csv.DictWriter(csvfile, fieldnames=fields)
    writer.writeheader()
    for place in places:
        for theType in classes:
            filename = f"./jsons/{place}_{theType}.json"
            with open(filename) as f:
                data = json.load(f)
                writer.writerow({
                    'place': place,
                    'type': theType,
                    'num': data[-1]['num'],
                    'max': data[-1]['max'],
                    'min': data[-1]['min'],
                    'mean': data[-1]['mean']
                })