import sys
sys.path.append(r'/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages')

import os
from notion_client import Client  # 导入notion_client库，终端输入"pip install notion_client"进行安装
from pprint import pprint
# 从notion中获取数据
notion = Client(auth="secret_FjRVSfO5PmvIoh9ugzPNbn1OBghZ8FMj9ecm7SmpuYt")  # 替换为自己的Token
db_name = "ReadingList"    # 替换为自己的DataBase名称
db_id = "444bf12774544b1d842eed17083960f7"    # 替换为自己的DataBase ID
page_id = "444bf127-7454-4b1d-842e-ed17083960f7"   # # 替换为自己的Page ID
startDate='2024-05-24'
endDate='2024-06-08' # 替换为自己的时间段
db_values = notion.databases.query(
        **{
            "database_id": db_id,
            "filter" : {
                "and" : [
                    {
                    "property": "Completed",
                    "date": {
                        "after": startDate
                    }},
                    {
                    "property": "Completed",
                    "date": {
                    "before": endDate
                    }
                    }
                ]
            }
        }
    ).get("results")
import time
import subprocess
current_time=time.strftime("%Y%m%d_%H%M", time.localtime())
file_name = "filelist"+current_time+".txt"
dict_name=f'{current_time}_PDFs'
os.system(f'/bin/mkdir {os.getcwd()}/{dict_name}') # 创建文件夹用于存储抓取到的pdf
command_header='''/usr/bin/find '/Users/channingtong/Library/Mobile Documents/iCloud~QReader~MarginStudy/Documents' -iname ''';
with open(file_name,"w") as file:
# 整理notion中获取的数据然后获得pdf路径
    title=[]
    author=[]
    date=[]
    filename=[]
    filedict=[]
    for item in db_values:
        title.append(item["properties"]["Name"]["title"][0]["plain_text"])
        author.append(item["properties"]["Author"]["rich_text"][0]["plain_text"])
        date.append(item["properties"]["Time"]["number"])
        # 抓取第一作者的姓
        first_author=author[-1].split(',')[0]
        first_author=first_author.split(' ')[-1]
        # 将当 author,ate和title截取前50个字符拼接成文件名
        filename.append('\"'+f'{first_author}*- {date[-1]} - {title[-1][:30]}'+'*\"')   
        cmd_fatch=command_header+filename[-1]
        os_fatch=subprocess.check_output(cmd_fatch,shell=True)
        if (os_fatch==b''):
            print(f'未找到{filename[-1]}')# 如果未找到pdf则输出提示手动添加一下
        else:
            filedict.append(os_fatch.decode("utf-8").strip('\n'))
        file.write(filedict[-1]+'\n'+author[-1]+'\n')
        os.system(f'/bin/cp \'{filedict[-1]}\'  {os.getcwd()}/{dict_name}')# 将pdf复制到指定文件夹
