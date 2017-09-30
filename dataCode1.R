# EduHacks

setwd("C:/Users/Brad_/Desktop/SFU/Statistics/Statistics 440/EduHacks-MeanGirls")

# Install Packages
install.packages("OpenStreetMap")
install.packages("osmar")
install.packages("igraph")


#Library
library(OpenStreetMap)
library(stringr)
library(ggplot2)
library(dplyr)
library(osmar)
library(igraph)

?OpenStreetMap()
?get_osm()
?osmsource_api()

api <- osmsource_api(url = "http://api.openstreetmap.org/api/0.6/")

box <- corner_bbox(-122.7629, 49.1860, -122.7392, 49.1979)

gschw <- get_osm(box, source = api)
gschw$nodes
gschw$relations

str(gschw$nodes)
View(gschw$nodes)
View(gschw$nodes[2])
View(gschw$nodes[1])


as_igraph(gschw)
