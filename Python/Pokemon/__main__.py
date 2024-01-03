import EntityRecognizer as recognizer
import InferenceMachine as IM
def main():
    print(r'''
        -----------------------------
        -----大师宝可梦识别系统------
        -----------------------------''')
    sentence= input('请输入宝可梦特征(按q退出)')
    while(sentence)!='q':
        facts=recognizer.element(sentence)
        #print(facts)
        IM.InferOutput(facts)
        sentence= input('请输入宝可梦特征(按q退出)')
    return 1
if __name__ == '__main__':
    main()

#if __name__ == '__main__':
#    print(element("我在关都地区在遇到了一只宝可梦,是草系的,大概是21级,攻击力大于60"))