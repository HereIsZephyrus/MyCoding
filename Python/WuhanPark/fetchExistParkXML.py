from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.common.exceptions import NoSuchElementException
import json
#from selenium.webdriver.common.action_chains import ActionChains

driver = webdriver.Chrome()
driver.set_window_size(1080, 1920)

with open('park_info.json', 'r') as file:
    json_data = file.read()

data = json.loads(json_data)

for park in data:
    url=f"https://www.openstreetmap.org/search?query=武汉%20{park['name']}"
    driver.get(url)
    driver.implicitly_wait(3) #wait for loading
    try:
        element = driver.find_element(by=By.XPATH, value='//*[@id="sidebar_content"]/div[2]/ul/li/a')
        element.click()
        driver.implicitly_wait(3) #wait for loading
        driver.find_element(by=By.XPATH, value='//*[@id="sidebar_content"]/div[3]/a').click() # click xml downlad button
        driver.implicitly_wait(4) #wait for loading
        f=open(f"./ParkGXML/{park['district']}-{park['name']}.xml",'w')
        f.write(driver.find_element(by=By.CLASS_NAME,value="pretty-print").text)
        f.close()
    except NoSuchElementException:
        continue