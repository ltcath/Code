#Fire Plots
install.packages("raster")
install.packages("sp")
install.packages("ggplots")
install.packages("RgoogleMaps")
install.packages("dismo")
install.packages("rgdal")
install.packages("XML")
install.packages("scales")
install.packages("rgeos")
install.packages("maps")
install.packages("readxl")
library("raster")
library("sp")
library("RgoogleMaps")
library("dismo")
library("rgdal")
library("XML")
library("scales")
library("rgeos")
library("maps")
library("readxl")

install.packages("inlabru")
library("inlabru")

install.packages("ggmap")
library(ggmap)
rainier<-get_map(location=c(-121.760374,46.852886),maptype="satellite",zoom=11)
ggmap(rainier)

#Record map from Oregon, zoom from 1 to 19, zoom = 6 shows complete state.
emory <- gmap("Oregon")
emory <- gmap("Idaho", scale = 2)
install.packages("ggmap")
library(ggmap)
rainier<-get_map(location="Oregon state",maptype="satellite",zoom=11)
ggmap(rainier)
#Step 1
#Choose data frame containing lat and long
a <- read_excel("C:/Users/Veteran/Documents/Luke's School/Terms/Fall 2018/STAT 501/Data/Current Data Files/Fire 308 Overlap.xlsx")


#Step 2
#Read lat and long as coordinate in a map
coordinates(a) <- ~ DLONGITUDE + DLATITUDE

#Step 3
#Project coordinates
projection(a) <- "+init=epsg:4326"

#Step 4
#Combined coordinates into Oregon map
a_mrc <- spTransform(a, CRS = CRS(projection(emory)))

#Step 5
#Create lighter circle around lat and long coordinates using the radius information
a_mrc_bff <- gBuffer(a_mrc,byid=TRUE, width = c(a$RADIUS ))

#All codes combined shows the map, coordinates with lighter circle in color blue
plot(emory)
plot(a_mrc_bff, col = alpha("red", .35), add = TRUE)
points(a_mrc, cex = 2, pch = 20)
text(a_mrc_bff,labels=a$FIREID, cex= 0.3, pos=3)
#The last code add fire's name, cex=font size and pos=3 at top of fire

#The same five steps are repeated but using the weather stations information
#All codes combined will look like:
#plot(emory)
#plot(a_mrc_bff, col = alpha("blue", .35), add = TRUE)
#points(a_mrc, cex = 2, pch = 20)
#plot(b_mrc_bff, col = alpha("red", .35), add = TRUE)
#points(b_mrc, cex = 2, pch = 20)
#text(a_mrc_bff,labels=a$FIREID, cex= 0.3, pos=3)
#text(b_mrc_bff,labels=weather_all_years$NAME, cex= 0.3, pos=3)