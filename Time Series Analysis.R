#Time Series Analysis

#Import Dataset
library("readxl")
fire <- read_excel("C:/Users/Veteran/Documents/Luke's School/Terms/Fall 2018/STAT 501/Data/Fires.xlsx")

#Set Time Series
install.packages("astsa")
install.packages("sarima")
library("astsa")
library("sarima")
fire <- ts(fire, start = c(1980,10), end = c(2016,12), frequency = 12)
fire <- as.vector(t(fire))

#Plot Time Series
ts.plot(fire,col=c(rep("blue",3),rep("black",3)))
plot(fire, type="l")

par(mfrow = c(2,1))
plot(fire)

# return to original spacing
par(mfrow = c(1,1))

#Check for stationarity
#install.packages("tseries")
library("tseries")
adf.test(fire, k=12)
kpss.test(fire)

#Plot ACF/PACF
Acf(fire)
Pacf(fire)

#In-Sample Fit of Models
sarima(fire, 1,0,1,0,0,0,12)
sarima(fire, 2,0,1,0,0,0,12)
sarima(fire, 0,0,0,1,0,1,12)
sarima(fire, 0,0,0,2,0,1,12)
sarima(fire, 1,0,1,1,0,1,12)
sarima(fire, 5,0,1,1,0,1,12)
auto.arima(fire, seasonal = F)

a000 = sarima(fire, 1,0,1,0,0,0,12)
a001 = sarima(fire, 2,0,1,0,0,0,12)
a002 = sarima(fire, 0,0,0,1,0,1,12)
a003 = sarima(fire, 0,0,0,2,0,1,12)
a004 = sarima(fire, 1,0,1,1,0,1,12)
a005 = sarima(fire, 5,0,1,1,0,1,12)
a006 = sarima(fire, 0,0,0,5,0,1,12)

print(which.min(c(a000$AIC, a001$AIC, a002$AIC, a003$AIC, a004$AIC, a005$AIC, a006$AIC)))
print(which.min(c(a000$BIC, a001$BIC, a002$BIC, a003$BIC, a004$BIC, a005$BIC, a006$BIC)))
print(c(a000$AIC, a001$AIC, a002$AIC, a003$AIC, a004$AIC, a005$AIC, a006$AIC))
print(c(a000$BIC, a001$BIC,a002$BIC,a003$BIC,a004$BIC,a005$BIC, a006$BIC))

#AIC and BIC agree that the best model is a006: sarima(0,0,0,5,0,1,12)
#This is the model taht we will use for the forecasts

#Out-of-Sample Fit of Models

library("forecast")
library("Mcomp")
install.packages("AnalyzeTS")
library("AnalyzeTS")

# declare a forecasting version of the best model
a000_cast = data.frame(sarima.for(fire, n.ahead = 3, 1,0,1,0,0,0,12))
a001_cast = data.frame(sarima.for(fire, n.ahead = 3, 2,0,1,0,0,0,12))
a002_cast = data.frame(sarima.for(fire, n.ahead = 3, 0,0,0,1,0,1,12))
a003_cast = data.frame(sarima.for(fire, n.ahead = 3, 0,0,0,2,0,1,12))
a004_cast = data.frame(sarima.for(fire, n.ahead = 3, 1,0,1,1,0,1,12))
a005_cast = data.frame(sarima.for(fire, n.ahead = 3, 5,0,1,1,0,1,12))
a006_cast = data.frame(sarima.for(fire, n.ahead = 3, 0,0,0,5,0,1,12))
a_act = data.frame(fire[c(433:435)])
av.res(Y=data.frame(a_act), F=data.frame(a000_cast$pred), r = 3)
av.res(Y=data.frame(a_act), F=data.frame(a001_cast$pred), r = 3)
av.res(Y=data.frame(a_act), F=data.frame(a002_cast$pred), r = 3)
av.res(Y=data.frame(a_act), F=data.frame(a003_cast$pred), r = 3)
av.res(Y=data.frame(a_act), F=data.frame(a004_cast$pred), r = 3)
av.res(Y=data.frame(a_act), F=data.frame(a005_cast$pred), r = 3)
av.res(Y=data.frame(a_act), F=data.frame(a006_cast$pred), r = 3)

#Plot overlay of forecasted values with actual values

a006_cast = ts(a006_cast$pred)
plot.ts(a006_cast, type = "l", col = "green")
lines(a_act, col = "red")






