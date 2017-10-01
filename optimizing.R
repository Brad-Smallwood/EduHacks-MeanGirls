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
eg_data <- read_csv("~/EduHacks-MeanGirls/fakeData.csv")

# Getting lattitude and longitudinal data
geo_updated <- function(data){
  
  lattitude <- NULL
  longitude <- NULL
  
  for (i in 1:nrow(data)){
    
    lattitude[i] <- geoCode(paste((data[i,3]), data[i, 4], sep = ","))[1]
    longitude[i] <- geoCode(paste((data[i,3]), data[i, 4], sep = ","))[2]
  }
  
  data$lattitude <- lattitude
  data$longitude <- longitude
  
  data$lattitude <- parse_double(data$lattitude)
  data$longitude <- parse_double(data$longitude)

  return(data)
  
}

# Running lattitude/longitude function
updated_eg_data <- geo_updated(eg_data)

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

bothwell_elementary <- na.omit(bothwell_elementary)
fraserwood_elementary <- na.omit(fraserwood_elementary)
maplegreen_elementary <- na.omit(maplegreen_elementary)

write.csv(bothwell_elementary, "bothwell_elementary.csv")
write.csv(fraserwood_elementary, "fraserwood_elementary.csv")
write.csv(maplegreen_elementary, "maplegreen_elementary.csv")

colnames(bothwell_elementary)
fraserwood_elementary

######## New Registrant Function #########
registration<- NULL
registration$X1 <- 61 #length(family_list$X1) + 1
registration$family <- "Buckle" #input$pLastName
registration$address <- "7008 Fielding Court" #input$address
registration$city <- "Burnaby" #input$city
registration$school <- "Bothwell Elementary School" #input$school
registration$lattitude <- NA
registration$longitude <- NA
registration$Cluster <- NA
registration$fakeDist <- NA
registration

new_reg_appender <- function(newData){
  newData <- geo_updated(newData)
  updated_eg_data <- rbind(updated_eg_data, newData)
}

new_reg_appender(registration)

updated_eg_data
