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

api <- osmsource_api(url = "http://api.openstreetmap.org/api/0.6/")

box <- corner_bbox(-122.7629, 49.1860, -122.7392, 49.1979)

area_data1 <- get_osm(box, source = api)
area_data1$nodes
area_data1$relations

node1 <- as.data.frame(area_data1$nodes[1])
node2 <- as.data.frame(area_data1$nodes[2])

head(node2)
nrow(node2)
nrow(node1)


relation1 <- as.data.frame(area_data1$relations[1])
relation2 <- as.data.frame(area_data1$relations[2])
relation3 <- as.data.frame(area_data1$relations[3])

head(relation3)

ways1 <- as.data.frame(area_data1$ways[1])
ways2 <- as.data.frame(area_data1$ways[2])
ways3 <- as.data.frame(area_data1$ways[3])

summary(area_data1$nodes)

hw_ids <- find(area_data1, way(tags(k == "highway")))
hw_ids <- find_down(area_data1, way(hw_ids))

plot(area_data1, xlim = c(-122.8, -122.7))
?plot
plot_ways(hw, add = TRUE, col = "green")
hw <- subset(area_data1, ids = hw_ids)
