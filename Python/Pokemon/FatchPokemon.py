import os
from selenium import webdriver
from selenium.webdriver.common.by import By
import time
from selenium.webdriver.common.action_chains import ActionChains

areas=["armordex","galardex","aloladex","national","kanto","johto","hoenn","sinnoh","unova","kalos"]
url_header="https://www.pokedex.app/zh/pokemon-"
url=url_header+"armordex.html"

driver = webdriver.Safari()
driver.set_window_size(1080, 1920) #otherwise the kalos button wouldn't appear
os.system("/bin/mkdir dict")
for item in areas:
  url=url_header+item+".html"
  print(url)
  driver.get(url)
  driver.implicitly_wait(2)
  print(f"/html/body/main/article[2]/div[{areas.index(item)+1}]")
  above = driver.find_element(By.XPATH,f"/html/body/main/article[2]/div[{areas.index(item)+1}]")
  ActionChains(driver).click(above).perform()
  driver.implicitly_wait(2)
  time.sleep(10) #wait for loading
  f=open(f"./dict/{item}.html",'w')
  f.write(driver.page_source)
  f.close()