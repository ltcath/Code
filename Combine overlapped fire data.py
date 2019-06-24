#Bring in the worksheets

import pandas as pd

ws = pd.read_excel("C:/Users/Veteran/Documents/Luke's School/Terms/Fall 2018/STAT 501/Data/Weather Station/Overlap Fires/WS7.xlsx")
fire = pd.read_csv("C:/Users/Veteran/Documents/Luke's School/Terms/Fall 2018/STAT 501/Data/Weather Station/Overlap Fires/Overlaps and Fireno/fires7.csv")

ws.head()
fire.head()

import os
os.chdir("C:/Users/Veteran/Documents/Luke's School/Terms/Fall 2018/STAT 501/Data/Weather Station/Overlap Fires/Overlaps and Fireno/Fires")

firei = fire["Fire 1"]
firej = fire["Fire 2"]
lat = ws["DLATITUDE"]
lon = ws["DLONGITUDE"]
msq = ws["AREA MSQ"]
rad = ws["RADIUS"]
month = ws["MONTH"]
year = ws["YEAR"]

i = 0
fire1 = []
fire2 = []
radius1 = []
radius2 = []
month1 = []
month2 = []
year1 = []
year2 = []
area1 = []
area2 = []

n = len(firei)
while (i <= n-1):
    j = firei[i] - 1
    k = firej[i] - 1
    fire1.append(firei[i])
    fire2.append(firej[i])
    radius1.append(rad[j])
    radius2.append(rad[k])
    month1.append(month[j])
    month2.append(month[k])
    year1.append(year[j])
    year2.append(year[k])
    area1.append(msq[j])
    area2.append(msq[k])
    i += 1

import numpy as np
spread = np.stack((fire1, fire2, radius1, radius2, month1, year1, month2, year2, area1, area2), axis = 1)
spread = pd.DataFrame(spread, columns = ['Fire 1', 'Fire 2', 'Radius 1', 'Radius 2', 'Month 1', 'Year 1', 'Month 2', 'Year 2', 'Area 1', 'Area 2'])
spread.to_csv("overlap fires7.csv", index=True, header=True, sep=',')
