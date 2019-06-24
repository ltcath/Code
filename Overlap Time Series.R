#Time Series Analysis

#Import Dataset
library("readxl")
fire <- read_excel("C:/Users/Veteran/Documents/Luke's School/Terms/Fall 2018/STAT 501/Data/Current Data Files/Yearly Overlap.xlsx")
fire = log(fire)
#Set Time Series
#install.packages("astsa")
#install.packages("sarima")
library("astsa")
library("sarima")
library("forecast")
fire <- ts(fire, start = c(1980), end = c(2016), frequency = 1)
fire <- as.vector(t(fire))

#Plot Time Series
ts.plot(fire,col=c(rep("blue",3),rep("black",3)))

#Check for stationarity
#install.packages("tseries")
library("tseries")
adf.test(fire)
kpss.test(fire)

#Need to difference data
fire <- diff(fire, differences = 1)
plot.ts(fire)

#Recheck stationarity
adf.test(fire)
kpss.test(fire)

#Plot ACF/PACF
Acf(fire)
Pacf(fire)
auto.arima(fire)

#In-Sample Fit of Models
arima(fire, c(1,0,0))
arima(fire, c(1,0,1))

a000 = arima(fire, c(1,0,0))
a001 = arima(fire, c(1,0,1))

#This is the model taht we will use for the forecasts

#Out-of-Sample Fit of Models

library("Mcomp")
#install.packages("AnalyzeTS")
library("AnalyzeTS")
library(stats)

# declare a forecasting version of the best model
a000_cast = data.frame(predict(a000, n.ahead = 3))
a001_cast = data.frame(predict(a001, n.ahead = 3))

a_act = data.frame(fire[c(34:36)])
av.res(Y=data.frame(a_act), F=data.frame(a000_cast$pred), r = 3)
av.res(Y=data.frame(a_act), F=data.frame(a001_cast$pred), r = 3)




