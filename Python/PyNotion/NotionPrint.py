import sys
sys.path.append(r'/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages')
import os
from notion_client import Client  # 导入notion_client库，终端输入"pip install notion_client"进行安装
from pprint import pprint
# 从notion中获取数据
notion = Client(auth="secret_rsEEx3ne1DapGydZdHit7289lrPXrEYYR53TmzfgcI7")  # 替换为自己的Token
db_name = "ReadingList"    # 替换为自己的DataBase名称
db_id = "444bf12774544b1d842eed17083960f7"    # 替换为自己的DataBase ID
page_id = "444bf127-7454-4b1d-842e-ed17083960f7"   # # 替换为自己的Page ID
startDate='2023-12-15'
endDate='2023-12-22' # 替换为自己的时间段
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
    with open(file_name,"w") as file:
        for i in range(len(title)):
            file.write(f"##@ {title[i]}\n")
            file.write(f"**作者**: {author[i]}\n")
            file.write(f"**关键词**: {keywords[i]}\n")
            file.write(f"**完成时间**: {completeDate[i]}")
            if level[i]=="Peruse":
                file.write(f"(精读)\n")
            elif level[i]=="Skim":
                file.write(f"(略读)\n")
            elif level[i]=="Skip":
                file.write(f"(选读)\n")
            file.write(f"##@# 内容简介\n")
            file.write(f"{content[i]}\n")
            file.write(f"#@## 笔记与思考\n")
            file.write(f"{notes[i]}\n")
            file.write("\n")
# 使用latex语法生成slide输出
if printFormat=="slide":
    header=r'''
\documentclass{beamer}
\usepackage{ctex, hyperref}
\usepackage[T1]{fontenc}

% other packages
\usepackage{latexsym,amsmath,xcolor,multicol,booktabs,calligra}
\usepackage{graphicx,pstricks,listings,stackengine}
\usepackage{ulem}

\author{童川博}
\title{文献选读与学习思考}
\subtitle{'''+startDate+'~'+endDate+r'''}
\institute{中国地质大学未来技术学院}
\date{\today}
\usepackage{CUG}

% defs
\def\cmd#1{\texttt{\color{red}\footnotesize $\backslash$#1}}
\def\env#1{\texttt{\color{blue}\footnotesize #1}}
\definecolor{deepblue}{rgb}{0,0,0.5}
\definecolor{deepred}{rgb}{0.6,0,0}
\definecolor{deepgreen}{rgb}{0,0.5,0}
\definecolor{halfgray}{gray}{0.55}

\lstset{
    basicstyle=\ttfamily\small,
    keywordstyle=\bfseries\color{deepblue},
    emphstyle=\ttfamily\color{deepred},    % Custom highlighting style
    stringstyle=\color{deepgreen},
    numbers=left,
    numberstyle=\small\color{halfgray},
    rulesepcolor=\color{red!20!green!20!blue!20},
    frame=shadowbox,
}


\begin{document}

\kaishu
\begin{frame}
    \titlepage
    \vspace{-2em}  % 减小间距
    \begin{figure}[htpb]
        \begin{center}
        		\includegraphics[width=0.3\linewidth]{pic/CUG_Logo.png}
        \end{center}
    \end{figure}
\end{frame}

\section{文献选读}
'''
    file_name = "readinglist"+current_time+".tex"
    with open(file_name,"w") as file:
        file.write(header)
        for i in range(len(title)):
        # 简介页
            file.write(r"\begin{frame}{文献"+str(i+1)+r"}"+"\n")
            file.write(f"{title[i]}"+"\n\n");
            file.write(r"\small\textbf{作者}: "+f"{author[i]}\n\n")
            file.write(r"\textbf{关键词}: "+f"{keywords[i]}\n\n")
            file.write(r"\textbf{完成时间}:"+f"{completeDate[i]}")
            if level[i]=="Peruse":
                file.write(f"(精读)\n\n")
            elif level[i]=="Skim":
                file.write(f"(略读)\n\n")
            elif level[i]=="Skip":
                file.write(f"(选读)\n\n")
            file.write(r"\scriptsize\textbf{内容简介}:")
            file.write(f"{content[i]}\n\n")
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
                file.write(r"\item "+f"{notes[i][j]}"+"\n")
            file.write(r"\end{itemize}"+"\n\n")
            file.write(r"\end{frame}"+"\n\n")
        file.write(r"\end{document}")