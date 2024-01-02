import os
from selenium import webdriver
from selenium.webdriver.common.by import By
import time
from selenium.webdriver.common.action_chains import ActionChains

driver = webdriver.Safari()
driver.set_window_size(1080, 1920) #otherwise the kalos button wouldn't appear
os.system("/bin/mkdir dict")
url="https://www.pokedex.app/zh/ability"
print(url)
driver.get(url)
driver.implicitly_wait(2)
time.sleep(10) #wait for loading
f=open(f"./dict/ability.html",'w')
f.write(driver.page_source)
f.close()