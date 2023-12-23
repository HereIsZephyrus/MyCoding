import sys
sys.path.append(r'/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages')
import os
from notion_client import Client  # 导入notion_client库，终端输入"pip install notion_client"进行安装
from pprint import pprint    # 导入pprint库，方便查看数据结构，终端输入"pip install pprint"进行安装
# 获取 Notion API 的访问凭据、定义相关查询对象
notion = Client(auth="secret_rsEEx3ne1DapGydZdHit7289lrPXrEYYR53TmzfgcI7")  # 替换为自己的Token
db_name = "ReadingList"    # 替换为自己的DataBase名称
db_id = "444bf12774544b1d842eed17083960f7"    # 替换为自己的DataBase ID
page_id = "444bf127-7454-4b1d-842e-ed17083960f7"   # # 替换为自己的Page ID
# notion.search 搜索指定对象是否存在
    # query 指定搜索对象：database的 db_id、db_name
    # filter 是筛选条件，其中属性为"object"对象，值可以是"database"，也可以是"page"
results = notion.search(query=db_name, filter={"property": "object", "value": "database"}).get("results")
#print(type(results))    # 返回类型为list列表
#pprint(results)
if (results is None) or (len(results) == 0):
    print(f"Notion中找不到DataBase【{db_name}】")
#else:
#    print(f"【{db_name}】连接成功")

# notion.databases.retrieve() 获取指定数据库db_id信息，返回数据库信息的对象为'列名'及'列属性'，但不包括'列值'。
#db_info = notion.databases.retrieve(database_id=db_id)  
#print(type(db_info))    # 返回类型为dict字典
#properties_list = db_info.get("properties");
#with open("db_info.txt","w") as proper_file:
#    for key,value in properties_list.items():
#        proper_file.write('{key}:{value}'.format(key=key,value=value))
#        proper_file.write("\n")
#proper_file.close()

# notion.databases.query() 查询指定数据库db_id的所有记录，返回包含所有符合筛选条件的记录列表，包括'列名'、'列属性'、'列值'。可批量获取数据，进行筛选和排序操作，适用于处理大批量数据。
import time
current_time=time.strftime("%Y%m%d_%H%M%S", time.localtime()) 
file_name = "readinglist"+current_time+".txt"
#db_values = notion.databases.query(database_id=db_id ).get("results")

db_values = notion.databases.query( 
    **{
        "database_id": db_id, 
        "filter" : {
            "and" : [
                {
                "property": "Completed", 
                "date": {
                    "after": '2023-11-15'
                }},
                {
                "property": "Completed", 
                "date": {
                    "before": '2023-12-22'
                }
            }
        ]
        }
    }
).get("results")
with open(file_name,"w") as file:
    for item in db_values:
        file.write(str(item))
        file.write("\n")
file.close()