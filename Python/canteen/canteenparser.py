import os
from bs4 import BeautifulSoup
import json

places = ["dayuecheng","zuoling","guanggu","lumo","jianghan"]
#places = ["dayuecheng"]

classes = ["xiaochi","zizhu","huoguo","hubeicai","shaokao","mianguan","tesecai","xican","hanguoliaoli","chuancai","ribencai","xiangcai","kaorou","yuecai","xiaolongxia","luoshifen","dongbeicai","dongnanyacai","xinjiangcai","beibingcai"]
#classes = ["xiaochi"]

#os.system("mkdir rawhtmls")
#os.system("mkdir jsons")
for place in places:
    for theType in classes:
        filename = f"{place}_{theType}"
        print(filename)
        inputfile = f"./rawhtmls/{filename}.html"
        outputfile = f"./jsons/{filename}.json"
        #os.system(f"touch {inputfile}")
        #os.system(f"touch {outputfile}")
        with open(inputfile, 'r', encoding='utf-8') as file:
            html_content = file.read()

        datas = []
        soup = BeautifulSoup(html_content, 'html.parser')

        content = soup.find(class_="content")
        canteens = soup.find_all(class_="txt")
        Min = 1000
        Max = 0
        Average = 0
        for canteen in canteens:
            canteenTitle = canteen.find(class_="tit")
            canteenTitle = canteenTitle.find("a")
            canteenTitle = canteenTitle.get("title")
            price = canteen.find(class_="comment")
            price = price.find_all("a")
            price = price[1]
            price = price.text
            price = price.split('￥')
            if (len(price)>1):
                price = price[1].strip()
                Min = min(Min,int(price))
                Max = max(Max,int(price))
                Average += int(price)
                data = {
                    "title": canteenTitle,
                    "price": int(price)
                }
                datas.append(data)
        if (len(canteens)>0):
            Average /= len(canteens)
        stats = {
            "num" : len(canteens),
            "max" : Max,
            "min" : Min,
            "mean" : Average
        }
        datas.append(stats)
        #print(datas)
        with open(outputfile, 'w', encoding='utf-8') as file:
            json.dump(datas, file,ensure_ascii=False)