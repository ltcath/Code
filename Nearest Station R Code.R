install.packages("geosphere")
library(geosphere)
install.packages("readxl")
setwd("C:/Users/Veteran/Documents/Luke's School/Terms/Fall 2018/STAT 501/Data")
library("readxl")
oregon <- read_excel("C:/Users/Veteran/Documents/Luke's School/Terms/Fall 2018/STAT 501/Data/oregon.xlsx")

stations <- read_excel("C:/Users/Veteran/Documents/Luke's School/Terms/Fall 2018/STAT 501/Data/Weather Stations.xlsx")

# set up a blank vector to hold the distances
dist <- rep(0, (dim(stations)[1]))

n <- length(dist)
m <- length(oregon$FIREID)


out <- rep(0,m)

i <- 1


for (i in 1:m){
  
  for (j in 1:n){
    # pull the fire coordinates
    ilong <- oregon$DLONGITUDE[i]
    ilat <- oregon$DLATITUDE[i]
    # pull the station coordinates
    slong <- stations$LONGITUDE[j]
    slat <- stations$LATITUDE[j]
    
    # pull the distance between the fire and the station
    d <- geosphere::distm(c(ilong, ilat), c(slong, slat), fun = distHaversine)
    dist[j] <- d
    
    
    
    
  }
  
  dist
  out[i] <- stations$Name[which.min(dist)]
  
}
out

write.csv(out, file = "nearest_station.csv")