#STAT 571
#Homework 6
#Question 8.1

rm(list=ls())

#Set up Sigma Matrix
sigma = c(5,2,2,2)
sigma = matrix(sigma, ncol = 2, nrow = 2)

#Get Eigenvalues and their corresponding eigenvectors
eig = eigen(sigma)
eigvalue = eig$values
eigvector = eig$vectors

#Question 8.2

#Convert Covariance Matrix to Correlation Matrix
install.packages("stats")
library("stats")
rho = cov2cor(sigma)

#Get the Eigenvalues and their eigenvectors again
rho_eig = eigen(rho)
rho_eigvalue = rho_eig$values
rho_eigvector = rho_eig$vectors
sum(rho_eigvalue)

#Find rhoyz
sqrt(rho_eigvalue)
rho_eigvector[1:1]*1.278
rho_eigvector[1:2]*1.278
rho_eigvector[2:1]*0.606

#Question 8.10

rm(list = ls())

#Pull in data
library("readxl")

data = read_excel("C:/Users/Veteran/Documents/Luke's School/Terms/Winter 2019/STAT 571/Table 8.4.xlsx")

#Covariance and mean
sigma = cov(data, y = NULL, use = "everything")
mean1 = sum(data[,1])/length(data)
mean2 = sum(data[,2])/length(data)
mean3 = sum(data[,3])/length(data)
mean4 = sum(data[,4])/length(data)
x_bar = cbind(mean1, mean2, mean3, mean4)

#Eigenvalues and eigenvectors of sigma
eig = eigen(sigma)
eigvalue = eig$values
eigvector = eig$vectors
print(eigvalue)

sum(eigvalue[1:3])/sum(eigvalue[1:5])



