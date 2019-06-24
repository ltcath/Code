#Luke Cathcart
#Final Exam
#Cluster Analysis

rm(list = ls())

#Install Packages
library("readxl")
#install.packages("fastcluster")
library("fastcluster")
#install.packages("robustHD")
library("robustHD")
library("stats")
#install.packages("MASS")
library("MASS")

#Bring in Data
data = read_excel("C:/Users/Veteran/Documents/Luke's School/Terms/Winter 2019/STAT 571/Fisher_iris.xlsx")
pw = data$PW
pl = data$PL
sw = data$SW
sl = data$SL
type = data$Type

#Standardize Data
pw = (standardize(pw, mean, sd))
pl = standardize(pl, mean, sd)
sw = standardize(sw, mean, sd)
sl = standardize(sl, mean, sd)

iris = as.matrix(cbind(pw, pl, sw, sl))

cluster_pw = hclust(dist(pw))
cluster_pl = hclust(dist(pl))
cluster_sw = hclust(dist(sw))
cluster_sl = hclust(dist(sl))
iris_cluster = hclust(dist(iris))
plot(cluster_pw)
plot(cluster_pl)
plot(cluster_sw)
plot(cluster_sl)
plot(iris_cluster)

k_pw = kmeans(pw, 3)
y_pw = k_pw$cluster
plot(pw, y_pw, col = "red", pch = 16)
points(pw, type, col = "blue", pch = 10)
k_pl = kmeans(pl, 3)
y_pl = k_pl$cluster
plot(pl, y_pl, col = "red", pch = 16)
points(pl, type, col = "blue", pch = 10)
k_sw = kmeans(sw, 3)
y_sw = k_sw$cluster
plot(sw, y_sw, col = "red", pch = 16)
points(sw, type, col = "blue", pch = 10)
k_sl = kmeans(sl, 3)
y_sl = k_sl$cluster
plot(sl, y_sl, col = "red", pch = 16)
points(sl, type, col = "blue", pch = 10)

#Discriminant Analysis
iris = as.matrix(cbind(pw, pl, sl, sw))

dis = lda(iris, grouping = type)
lda(iris, grouping = type)
plot(dis)

#Factor Analysis
my_data = cbind(pw, pl, sw, sl)
nfact = 1
jericho = factanal(my_data, nfact, rotation = "none")
install.packages(ltm)
factor.scores(jericho)
plot(jericho$loadings)

z = as.matrix(cbind(type, pw, pl, sw, sl), ncol = 5, nrow = 150, colnames = c("Type", "PW", "PL", "SW", "SL"))



write.csv(z, file = "z.csv")



