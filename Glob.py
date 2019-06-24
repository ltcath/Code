#Combine Fire Overlap Data so that we can sum all 
#Overlapping Area into a Time Series Workbook

import pandas as pd
import glob

glob.glob("C:/Users/Veteran/Documents/Luke's School/Terms/Fall 2018/STAT 501/Data/Weather Station/Overlap Fires/WS*.xlsx")
all_data = pd.DataFrame()
for f in glob.glob("C:/Users/Veteran/Documents/Luke's School/Terms/Fall 2018/STAT 501/Data/Weather Station/Overlap Fires/WS*.xlsx"):
    df = pd.read_excel(f)
    all_data = all_data.append(df,ignore_index=True)
all_data.describe()

import os
os.chdir("C:/Users/Veteran/Documents/Luke's School/Terms/Fall 2018/STAT 501/Data/Weather Station/Overlap Fires/Overlaps and Fireno")

all_data.to_csv("Full Fire Overlap.csv", index=True, header=True, sep=',')
