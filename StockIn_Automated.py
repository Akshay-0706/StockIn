from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By

import requests
import wget
import zipfile
import os

# get the latest chrome driver version number
# url = 'https://chromedriver.storage.googleapis.com/LATEST_RELEASE'
# response = requests.get(url)
# version_number = response.text

# # build the donwload url
# download_url = "https://chromedriver.storage.googleapis.com/" + \
#     version_number + "/chromedriver_win32.zip"

# print("Downloading latest chromedriver...")
# # download the zip file using the url built above
# latest_driver_zip = wget.download(download_url, 'chromedriver.zip')

# # extract the zip file
# with zipfile.ZipFile(latest_driver_zip, 'r') as zip_ref:
#     zip_ref.extractall()  # you can specify the destination folder path here

# # delete the zip file downloaded above
# os.remove(latest_driver_zip)

# print("\n")


def Glogin(mail_address, password):
    # Login Page
    driver.get(
        'https://accounts.google.com/ServiceLogin?hl=en&passive=true&continue=https://www.google.com/&ec=GAZAAQ')

    # input Gmail
    driver.find_element(By.ID, "identifierId").send_keys(mail_address)
    driver.find_element(By.ID, "identifierNext").click()
    driver.implicitly_wait(10)

    # input Password
    driver.find_element(By.XPATH,
                        '//*[@id="password"]/div[1]/div/div[1]/input').send_keys(password)
    driver.implicitly_wait(10)
    driver.find_element(By.ID, "passwordNext").click()
    driver.implicitly_wait(10)

    # go to google home page
    driver.get('https://google.com/')
    driver.implicitly_wait(200)


# get chrome options
def getChromeOptions():
    opt = Options()
    opt.add_experimental_option("detach", True)
    opt.add_argument('--disable-blink-features=AutomationControlled')
    opt.add_argument('--start-maximized')
    return opt


# add the website url
def startWebsite(url):
    driver.get(url)


def clickButton():
    driver.find_element()


print("Redirecting to chrome...")
# create chrome instance
driver = webdriver.Chrome('chromedriver.exe', options=getChromeOptions())


# mail_address = input('Enter your email address: ')
mail_address = 'akshay.vhatkar@spit.ac.in'
# password = input('Enter password: ')
password = 'ASpit@2003'

Glogin(mail_address, password)


print("Auto starting StockIn website...")
# start the StockIn website
startWebsite("https://akshay-0706.github.io/StockIn-Web/#/")
