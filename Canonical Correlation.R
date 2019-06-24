#STAT 571 
#Homework 5
#Canonical Correlation

rm(list = ls())

#Bring in Libraries
#install.packages("readxl")
library("readxl")
#install.packages("candisc")
library("candisc")

#Bring in Data
#You're going to have to change the working directory. You can just put it in below.
data = read_excel("C:/Users/Veteran/Documents/Luke's School/Terms/Winter 2019/STAT 571/canonical correlation.xlsx")

y1 <- data$y1
y2 <- data$y2
y3 <- data$y3
y4 <- data$y4
z1 <- data$z1
z2 <- data$z2
z3 <- data$z3
z4 <- data$z4

n = length(bl)

x = data.frame(cbind(y1, y2, y3, y4))
y = data.frame(cbind(z1, z2, z3, z4))

vector = cancor(x, y, ndim = 4, coef = "both", standardize = TRUE)
t = coef(vector, type = "both", standardize = TRUE)

cancor(x, y, Y.names = colnames(y),X.names = colnames(x))
coef(vector, type = "both", standardize = TRUE)