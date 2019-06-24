#Homework 3
#Question 1
#Part 3

rm(list = ls())

#install.packages("compositions")
library("compositions")
#Generate Data
x = matrix(rnorm(n = 400, mean = 0, sd = 0.001))
y = matrix(rnorm(n = 400, mean = 0, sd = 0.1))
n = 400


kernel_matrix = function(x, kernel){
  kernel = outer(1:nrow(x), 1:nrow(x), Vectorize(function(i,j)kernel(x[i,],x[j,])))
  kernel = sum(kernel)
  kernel = kernel/(nrow(x)^2)
  return(kernel)
}

k = function(x,y){ 
  return(min(x,y))
}

j = matrix(0, nrow = 2, ncol = length(x))
m = rbind(x,y)

  







