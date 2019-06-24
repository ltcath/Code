library("RgoogleMaps")
library("dismo")
library("rgdal")
library("XML")
library("scales")
library("rgeos")
library("maps")
library("readxl")
install.packages("mapproj")
library("mapproj")
library("maps")
install.packages("ggmap")
library("ggmaps")
#Record map from Oregon, zoom from 1 to 19, zoom = 6 shows complete state.
map.grid(c(-121,42,-120,45),col=2,nx=5,ny=5,label=TRUE,lty=2)
emory <- gmap("Oregon", zoom = 6, scale = 2)

#Step 1
#Choose data frame containing lat and long
a <- read_excel("C:/Users/Veteran/Documents/Luke's School/Terms/Fall 2018/STAT 501/Data/Weather Stations.xlsx")


#Step 2
#Read lat and long as coordinate in a map
coordinates(a) <- ~ LONGITUDE + LATITUDE

#Step 3
#Project coordinates
projection(a) <- "+init=epsg:4326"

#Step 4
#Combined coordinates into Oregon map
a_mrc <- spTransform(a, CRS = CRS(projection(emory)))

#Step 5
#Create lighter circle around lat and long coordinates using the radius information
a_mrc_bff <- gBuffer(a_mrc,byid=TRUE, width = c(1))

#All codes combined shows the map, coordinates with lighter circle in color blue
plot(emory)
plot(a_mrc_bff, col = alpha("red", .35), add = TRUE)
points(a_mrc, cex = 2, pch = 20)

