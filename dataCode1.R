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

area_data1 <- get_osm(box, source = api)
area_data1$nodes
gschw$relations

str(area_data1$ways)
str(area_data1$nodes)
str(area_data1$relations)
View(gschw$nodes)
View(gschw$nodes[2])
View(gschw$nodes[1])



ts_ids <- find(area_data1, node(tags(v == "traffic_signals")))
ts <- subset(area_data1, node_ids = ts_ids)

bs_ids <- find(area_data1, node(tags(v %agrep% "busstop")))
bs <- subset(area_data1, node_ids = bs_ids)


hw_ids <- find(area_data1, way(tags(k == "highway")))
hw <- subset(area_data1, node_ids = hw_ids)


plot(area_data1)
plot_ways(hw, add = TRUE, col = "green")
plot_nodes(ts, add = TRUE, col = "red")
plot_nodes(bs, add = TRUE, col = "blue")



as_igraph(gschw)
