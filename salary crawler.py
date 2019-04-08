import requests
import re
import csv
import numpy as np
import importlib,sys
importlib.reload(sys)

def getpage(url):
    university_url = []
    html = getsource(url)
    everyclass = re.findall('<span class="clgname"><a href="(.*?)"', html, re.S)
    university_url = university_url + everyclass
    for i in range(1,100):
        page = url + "?page=" + str(i)
        html = getsource(page)
        everypage = re.findall('<span class="clgname"><a href="(.*?)"', html, re.S)
        university_url += everypage
    return (university_url)

def getsource(page):
    html = requests.get(page)
    return html.text

def geteveryclass(source):
    everyclass = re.findall('&quot;data&quot;:(.*?)\}', source, re.S)
    return everyclass

def process(everyclass):
    data = []
    for element in everyclass:
        tem = element[1:-1]
        tem1 = tem.split(",")
        tem2 = [int(i) for i in tem1]
        data.append(tem2)
    return data

url = "https://www.insidehighered.com/aaup-compensation-survey/school-detail/"
page_url = getpage(url)
page_absolute_url = [ "https://www.insidehighered.com" + i for i in page_url]

for page in page_absolute_url:
    print(page)
    html = getsource(page)
    everyclass = geteveryclass(html)
    after_process = process(everyclass)
    print(after_process)
    print("\n")








