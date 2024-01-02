rules = {}
filePath = r'rules.txt'

def storeRules(filePath):
    file_data = ""
    with open(filePath, 'r', encoding='utf-8') as f:
        for line in f:
            file_data += line
    with open(r"old rules.txt", "w", encoding='utf-8') as d:
       d.write(file_data)
    f.close()
    d.close()
def readRules(filePath):
    global rules
    fo = open(filePath, mode='r', encoding='utf-8')
    for line in fo:
        line = line.replace('IF', '').strip()
        temp = line.split(' THEN ')
        premise = temp[0]
        conclusion = temp[1]
        rules[premise] = conclusion
    fo.close()
def add_txt(filePath,new_premise,new_conclusion):
    file_data = ""
    with open(filePath, 'r', encoding='utf-8') as f:
        for line in f:
            file_data += line
        file_data += "IF"+" "+new_premise+" "+"THEN"+" "+new_conclusion+"\n"
    with open(filePath, "w", encoding='utf-8') as d:
        d.write(file_data)
    f.close()
    d.close()
def alter_txt(filePath,old_str,new_str):
    file_data = ""
    with open(filePath,'r', encoding='utf-8') as f:
        for line in f:
            if old_str in line:
                line = line.replace(old_str,new_str)
            file_data += line
    with open(r'rules.txt',"w",encoding='utf-8') as d:
        d.write(file_data)
    f.close()
    d.close()

def matchRules(facts):
    print()
    isEnd = False
    m = True
    def loop():

        global rules
        nonlocal facts, isEnd,m
        i = 0
        for premise in rules:
            flag = True
            pre = premise.split(' AND ')
            for p in pre:
                if p in facts:
                    m = False
                    pass
                else:
                    flag = False
            if (flag):
                print('该动物：' + premise + ' -> ' + rules[premise])
                for p in pre:
                    facts = facts.replace(p, ' ')
                facts = facts + rules[premise]
            else:
                i += 1
        if i == len(rules):
            isEnd = True
            if(m):
                print("十分抱歉！没有找到您所给条件对应的动物，请尝试输入信息与数据库对应")
                a = eval(input("0. 继续程序 1. 查看数据库内容") )
                if(a==1):
                    print(rules)
    while (not isEnd):
        loop()

def ui():
    print('--------------------------')
    print('--------动物识别系统--------')
    print('--------------------------')
    print('请按照规则库中的前提来阐述事实（实例：鸟 善飞）', end='\n\n')
    facts = input('请输入事实：')
    matchRules(facts)
def add():
    a = input("请输入判断条件：")
    b = input("请输入可以判断的结果：")
    rules[a] = b
    print(rules)
    add_txt(filePath,a,b)
def alter():
    x = True
    a = input("请输入判断条件：")
    b = input("请输入可以判断的结果：")
    for item in rules:
        if(a==item and b==rules[item]):
            print("该条件已存在，添加条件失败")
            x = False
        elif(a==item and b!=rules[item]):
            alter_txt(filePath,rules[item],b)
        elif(a!=item and b==rules[item]):
            alter_txt(filePath,item,a)
    if(x):
        rules[a] = b
        print(rules)
def main():
    global filePath
    storeRules(filePath)
    readRules(filePath)
    print(rules)

    while(1):
        print("\n1. 更改数据库信息"
              "2. 添加数据库信息"
              "3. 动物识别"
              "4. 退出系统\n")
        n = int(input("Please select ："))
        if(n==1):
            alter()
            continue
        elif(n==2):
            add()
            continue
        elif(n==3):
            ui()
        elif(n==4):
            print("\n成功退出程序！\n")
            break
        else:
            print("\n输入有误，请重新输入！\n")
    return 1
if __name__ == '__main__':
    main()

