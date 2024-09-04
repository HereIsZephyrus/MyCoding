import os
import json
from selenium import webdriver
from selenium.webdriver.common.by import By
import time
from selenium.webdriver.common.action_chains import ActionChains

with open("cookie.json", "r") as f:
    cookie = json.load(f)

driver = webdriver.Chrome()
driver.set_window_size(1080, 1920) #otherwise the kalos button wouldn't appear
os.system("/bin/mkdir dict")
url="https://www.dianping.com/search/keyword/16/10_大悦城/g112r89797"
print(url)
driver.get(url)
driver.add_cookie(cookie)
driver.implicitly_wait(2)
time.sleep(10) #wait for loading
f=open(f"test.html",'w')
f.write(driver.page_source)
f.close()