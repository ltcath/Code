#Find overlaps between fires

library("geosphere")
library("readxl")

#Upload Dataset
fire <- read_excel("C:/Users/Veteran/Documents/Luke's School/Terms/Fall 2018/STAT 501/Data/Weather Station/Overlap Fires/WS7.xlsx")

dim(fire)
names(fire)

#Create variable the length of the fire data
n <- length(fire$FIREID)

#Create a matrix to store the distances
m <- matrix(c(rep(0,n*n)), nrow = n)

#Create a loop to calculate the distances between each fire

for(i in (1:n)){
  firei <- c(fire$DLONGITUDE[i], fire$DLATITUDE[i], fire$RADIUS[i], fire$FIREID[i])
  for(j in (1:n)){
    firej <- c(fire$DLONGITUDE[j], fire$DLATITUDE[j], fire$RADIUS[j], fire$FIREID[j])
    d <- geosphere::distm(c(firei[1], firei[2]), c(firej[1], firej[2]), fun = distHaversine)
    r <- firei[3] + firej[3]
    rad = firei[3] - firej[3]
    print(d)
    print(r)
    print(j)

#r assumes the closest possible distance between two circles without overlapping
#If d < r, then they overlap
#If d = 0, then the area of the smallest circle will be the overlap
#If d > 0, then we calculate the are of overlap using triangles 
    if(d < r){
     if(d == 0){
       A = pi*(min(firei[3],firej[3]))^2
     }
     if (d > 0){
       ri = firei[3]
       rj = firej[3]
       a = ri^2*acos((d^2+ri^2-rj^2)/(2*d*ri))
       b = rj^2*acos((d^2+rj^2-ri^2)/(2*d*rj))
       c = 0.5*((ri+rj-d)(d+ri-rj)(d-ri+rj)(d+ri+rj))^0.5
       A = a + b - c
     }  
      print(A)
      print("overlap")
    }
    ifelse(d < r, (m[i,j] <- A), (m[i,j] <- 0))
  }
}

#We don't need the fires compared to themselves, so we remove them.
diag(m) <- 0

k <- NULL
k <- matrix(c(rowSums(m)), ncol = 1)
colnames(k) <- c("total_fire")
dim(k)
for(i in 1:n){
  k <- c(rowSums(m))
}

write.csv(m, file = "matrix_overlaps.csv")
write.csv(k, file = "total_overlaps.csv")