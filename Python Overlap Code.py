#Import excel spreadsheet of data

import pandas as pd

#Define variables
fire = pd.read_excel("C:/Users/Veteran/Documents/Luke's School/Terms/Fall 2018/STAT 501/Data/Weather Station/Overlap Fires/WS19.xlsx")
fire.head()
lat = fire["DLATITUDE"]
lon = fire["DLONGITUDE"]
radius = fire["RADIUS"]

#Set wd
import os
os.chdir("C:/Users/Veteran/Documents/Luke's School/Terms/Fall 2018/STAT 501/Data/Weather Station/Overlap Fires/Overlaps and Fireno")

#Define haversine function
from math import radians, cos, sin, asin, sqrt, pi, acos
def haversine(lon1, lat1, lon2, lat2):
    """
    Calculate the great circle distance between two points 
    on the earth (specified in decimal degrees)
    """
    # convert decimal degrees to radians 
    lon1, lat1, lon2, lat2 = map(radians, [lon1, lat1, lon2, lat2])

    # haversine formula 
    dlon = lon2 - lon1 
    dlat = lat2 - lat1 
    a = sin(dlat/2)**2 + cos(lat1) * cos(lat2) * sin(dlon/2)**2
    c = 2 * asin(sqrt(a)) 
    e = 6371000 # Radius of earth in meters.
    return c * e

#Create loop to compare fires to each other
i = 0
j = 0
n = len(lat)
import numpy as np
m = np.zeros(shape = (n,n))
ivector = []
jvector = []
k = 0

while(i <= n-1):
    lati = lat[i]
    loni = lon[i]
    while(j <= n-1):
        latj = lat[j]
        lonj = lon[j]
        if(j <= i): #We don't need to keep comparing the same fires
            m[i][j] = 0
        if(j > i):
            d = haversine(loni, lati, lonj, latj)
            r = radius[i] + radius[j]
            R = max(radius[j], radius[i]) - min(radius[j], radius[i])
            #Print statements are just so you know the program is running
            print(d)
            print(r)
            print(i)
            print(j)
            if(d < r):
                ivector.append(i+1)
                jvector.append(j+1)
                if (ivector[k] == 0 and jvector[k] == 0): #We only want the list of overlapping fires
                    k = k
                else: 
                    k += 1
                if(d <= R): #This means one of the circles is fully nested in the other, so the overlap is the area of the smallest circle
                    A = pi*(min(radius[i],radius[j]))**2
                if(d > R):
                    ri = radius[i]
                    rj = radius[j]
                    a = ri**2*acos((d**2+ri**2-rj**2)/(2*d*ri))
                    b = rj**2*acos((d**2+rj**2-ri**2)/(2*d*rj))
                    c = 0.5*((-d+ri+rj)*(d+ri-rj)*(d-ri+rj)*(d+ri+rj))**0.5
                    A = a + b - c
                m[i][j] = A
                print(A)
            else:
                m[i][j] = 0
        def sumrow(matrix):
            return np.sum(matrix, axis=1)  
        overlaparea = sumrow(m)
        j += 1
    i += 1 
    j = 0
ivector = np.array(ivector)
jvector = np.array(jvector)
ijvector = np.column_stack((ivector, jvector))

a = np.asarray(overlaparea)
np.savetxt("overlaparea19.csv", a, delimiter=",")
np.savetxt("fires19.csv", ijvector, delimiter = ",")
          
import winsound
duration = 1000  # millisecond
freq = 440  # Hz
winsound.Beep(freq, duration)       

