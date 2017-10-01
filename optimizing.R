##### Walking School Bus #####
#### EduHacks ####

# Installing packages in case you have not
# install.packages("RCurl")
# install.packages("RJSONIO")
# install.packages("tidyverse")

# Loading libraries
library(RCurl)
library(RJSONIO)
library(tidyverse)

# Writing function which gets lattitude and longitude information:

# Address Function
url <- function(address, return.call = "json", sensor = "false") {
  root <- "http://maps.google.com/maps/api/geocode/"
  u <- paste(root, return.call, "?address=", address, "&sensor=", sensor, sep = "")
  return(URLencode(u))
}

# Using google's API
geoCode <- function(address,verbose=FALSE) {
  if(verbose) cat(address,"\n")
  u <- url(address)
  doc <- getURL(u)
  x <- fromJSON(doc,simplify = FALSE)
  if(x$status=="OK") {
    lat <- x$results[[1]]$geometry$location$lat
    lng <- x$results[[1]]$geometry$location$lng
    location_type  <- x$results[[1]]$geometry$location_type
    formatted_address  <- x$results[[1]]$formatted_address
    return(c(lat, lng, location_type, formatted_address))
    Sys.sleep(0.5)
  } else {
    return(c(NA,NA,NA, NA))
  }
}

# Reading in data set
eg_data <- read.csv("Book2.csv", as.is = T, header = T)

# Getting lattitude and longitudinal data
geo_updated <- function(data, city){
  
  lattitude <- NULL
  longitude <- NULL
  
  for (i in 1:nrow(data)){
    
    lattitude[i] <- geoCode(paste((data[i,2]), data[i, 3], sep = ", "))[1]
    longitude[i] <- geoCode(paste((data[i,2]), data[i, 3], sep = ", "))[2]
  }
  
  family_geo_info <- cbind(data, lattitude, longitude)
  colnames(family_geo_info) <- c("family", "address", "city", "school", "lattitude",
                                 "longitude")
  
  family_geo_info$lattitude <- parse_double(family_geo_info$lattitude)
  family_geo_info$longitude <- parse_double(family_geo_info$longitude)
  
  return(family_geo_info)
  
}

# Running lattitude/longitude function
updated_eg_data <- geo_updated(eg_data)

updated_eg_data$province <- "B.C"

# Updating dataset based on new information
data_updater <- function(dataset, new_info){
  family_geo_info <- rbind(dataset, new_info)
  return(family_geo_info)
}

# Filtering by city function
filter_1 <- function(school_name, ds){
  
  family_geo_info <- ds %>% filter(school == school_name)
  
  return(family_geo_info)
}

# Mapping function for each city
all_schools <- map(unique(updated_eg_data$school), filter_1, updated_eg_data)

# Looping to create separate data sets
for (i in 1:length(unique(updated_eg_data$school))){
  r <- paste("family_geo", unique(updated_eg_data$school)[i], sep = "_")
  assign(r, as.data.frame(all_schools[i]))
  write.csv(as.data.frame(all_schools[i]), paste(r, ".csv"))
}

# Every schools partition of observations will be stored in the following format:
# family_geo_"school name here"

# Reading in data so it is nicer
bothwell_elementary <- read.csv("family_geo_Bothwell Elementary School .csv", as.is = T, header = T)
fraserwood_elementary <- read.csv("family_geo_Fraser Wood Elementary School .csv", as.is = T, header = T)
maplegreen_elementary <- read.csv("family_geo_Maple Green Elementary School .csv", as.is = T, header = T)
