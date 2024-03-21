#import os
from notion_client import Client  # 导入notion_client库，终端输入"pip install notion_client"进行安装
#from pprint import pprint
# 从notion中获取数据
notion = Client(auth="secret_FjRVSfO5PmvIoh9ugzPNbn1OBghZ8FMj9ecm7SmpuYt")  # 替换为自己的Token
db_name = "ReadingList"    # 替换为自己的DataBase名称
db_id = "444bf12774544b1d842eed17083960f7"    # 替换为自己的DataBase ID
page_id = "444bf127-7454-4b1d-842e-ed17083960f7"   # # 替换为自己的Page ID
startDate='2024-01-29'
endDate='2024-02-04' # 替换为自己的时间段
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

# 整理notion中获取的数据
title=[]
author=[]
completeDate=[]
keywords=[]
content=[]
notes=[]
publication=[]
level=[]
for item in db_values:
    title.append(item["properties"]["Name"]["title"][0]["plain_text"])
    author.append(item["properties"]["Author"]["rich_text"][0]["plain_text"])
    completeDate.append(item["properties"]["Completed"]["date"]["start"])
    keywords.append(item["properties"]["Keywords"]["rich_text"][0]["plain_text"])
    content.append(item["properties"]["Content"]["rich_text"][0]["plain_text"])
    notes.append(item["properties"]["Notes&Thinking"]["rich_text"][0]["plain_text"])
    publication.append(item["properties"]["Publication"]["rich_text"][0]["plain_text"])
    level.append(item["properties"]["Level"]["select"]["name"])

# 生成输出文件
printFormat=input("请输入打印格式:(doc/slide)")
while printFormat not in ["doc","slide"]:
    printFormat=input("请输入打印格式:(doc/slide)")
import time
current_time=time.strftime("%Y%m%d_%H%M", time.localtime())
# 使用markdown语法生成doc输出
if printFormat=="doc":
    file_name = "readinglist"+current_time+".md"
    with open(file_name,"w",encoding= 'utf-8') as file:
        file.write(f'**Time**: {startDate}~{endDate}\n')
        file.write('## 文献阅读\n')
        for i in range(len(title)):
            str_author = author[i].replace("\n",", ")
            file.write(f"### {title[i]}\n")
            file.write(f"**作者**: {str_author}\n")
            file.write(f"**期刊**: {publication[i]}\n")
            file.write(f"**关键词**: {keywords[i]}\n")
            file.write(f"**完成时间**: {completeDate[i]}")
            if level[i]=="Peruse":
                file.write("(精读)\n")
            elif level[i]=="Skim":
                file.write("(略读)\n")
            elif level[i]=="Skip":
                file.write("(选读)\n")
            file.write("#### 内容简介\n")
            file.write(f"{content[i]}\n")
            file.write("#### 笔记与思考\n")
            file.write(f"{notes[i]}\n")
            file.write("\n")
# 使用latex语法生成slide输出
if printFormat=="slide":
    header=r'''
\newcommand{\folder}{/Users/channingtong/Document/Latex/Beamer}
\input{\folder/include.tex}
\usepackage{\foloder/CUG}
\usepackage{soul}

\begin{document}

\input{\folder/titlepage.tex}

'''
    file_name = "readinglist"+current_time+".tex"
    with open(file_name,"w", encoding= 'utf-8') as file:
        file.write(header)
        for i in range(len(title)):
        # 简介页
            file.write(r"\section{文献"+str(i+1)+r"}"+"\n")
            file.write(r"\begin{frame}{文献"+str(i+1)+r"}"+"\n")
            file.write(f"{title[i]}"+"\n\n");
            file.write(r"\small\textbf{作者}: "+f"{author[i]}\n\n")
            file.write(r"\small\textbf{期刊}: "+f"{publication[i]}\n\n")
            file.write(r"\textbf{关键词}: "+f"{keywords[i]}\n\n")
            file.write(r"\textbf{完成时间}:"+f"{completeDate[i]}")
            if level[i]=="Peruse":
                file.write("(精读)\n\n")
            elif level[i]=="Skim":
                file.write("(略读)\n\n")
            elif level[i]=="Skip":
                file.write("(选读)\n\n")
            file.write(r"\scriptsize\textbf{内容简介}:")
            content_str=str(content[i])\
                .replace(r"&",r"$\&$")\
                .replace(r"_",r"\_")
            file.write(f"{content_str}\n\n")
            file.write(r"\end{frame}"+"\n")
            # 笔记页
            file.write(r"\begin{frame}{文献"+str(i+1)+r"}"+"\n")
            file.write(r'''
\begin{minipage}[c]{0.5\linewidth}
        %\medskip
       %\hspace{2cm}
       这里插入文字
   \end{minipage}
   \hspace{1em}
   \begin{minipage}{0.4\linewidth}
       \medskip
       %\hspace{2cm}
       \begin{figure}[h]
           \flushright
           \includegraphics[width=\textwidth]{pic/CUG_Logo.png}
           \caption{这里插入图片}
       \end{figure}
   \end{minipage}
                   ''')
            file.write(r"\end{frame}"+"\n")
            # 思考页
            file.write(r"\begin{frame}{文献"+str(i+1)+r"}"+"\n")
            file.write(r"\textbf{笔记与思考}:\scriptsize"+"\n\n")
            file.write(r"\begin{itemize}"+"\n")
            # 将笔记按照\n切分
            notes[i]=notes[i].split("\n")
            for j in range(len(notes[i])):
                note_str=str(notes[i][j]).replace(r"&",r"$\&$")
                file.write(r"\item "+f"{note_str}"+"\n")
            file.write(r"\end{itemize}"+"\n\n")
            file.write(r"\end{frame}"+"\n\n")
        file.write(r"\end{document}")