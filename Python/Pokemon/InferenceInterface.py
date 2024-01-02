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