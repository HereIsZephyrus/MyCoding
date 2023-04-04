'''
Author: ChanningTong Channing_TongCN@outlook.com
Date: 2023-03-31 14:13:34
LastEditors: ChanningTong Channing_TongCN@outlook.com
LastEditTime: 2023-03-31 14:14:58
FilePath: \undefinedc:\Users\Administrator\GitHub\MyCoding\Contents\2023MCMICM\2023MCM\scratch.py
Description:

Copyright (c) 2023 by ChanningTong, All Rights Reserved.
'''
import requests

url = """ https:///https:///sailboatdata.com//sailboat//11-meter """
res = requests.get(url)
print(res.status_code)