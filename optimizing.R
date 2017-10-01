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
geoCode <- function(address, city,verbose=FALSE) {
  if(verbose) cat(address,"\n")
  u <- paste("https://maps.googleapis.com/maps/api/geocode/json?address=", gsub(" ", address, replacement = "+"), ",+",city,"&key=AIzaSyCN4Z3Y0aArSROT47NXzgdilyOPc2pXiKI")
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
geo_updated <- function(data){
  lattitude <- NULL
  longitude <- NULL
  
  for (i in 1:nrow(data)){
    
    lattitude[i] <- geoCode((data[i,3]), data[i, 4])[1]
    longitude[i] <- geoCode((data[i,3]), data[i, 4])[2]
  }

  data$lattitude <- lattitude
  data$longitude <- longitude
  
  data$lattitude <- parse_double(data$lattitude)
  data$longitude <- parse_double(data$longitude)
  return(data)

  
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
<<<<<<< HEAD
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
registration$parent <- "Janet"
registration$child1 <- "Jimbob"
registration$child2 <- "Stacey"
registration$child3 <- NA
registration <- as.data.frame(registration)
=======
new_obs <- NULL
new_obs$X <- 61
new_obs$family <- "who_cares"
new_obs$address <- "10340 171A Street"
new_obs$city <- "Surrey"
new_obs$school <- "Maple Green Elementary School"
new_obs <- as.data.frame(new_obs)
new_obs

maplegreen_elementary
>>>>>>> d3f47f5f656565c1494ab1ebdc8bf0c532bec5e6

new_reg_appender <- function(newData){
  
  newData <- geo_updated(newData)
  newData$X <- 9999
  
  newData <- newData[,c(7, 1, 2, 3, 4, 5, 6)]

  if (newData$school == "Bothwell Elementary School"){
    
    bothwell_elementary <- rbind(bothwell_elementary, newData)
    return(bothwell_elementary)
  } else if (newData$school == "Fraser Wood Elementary School") {
    fraserwood_elementary <- rbind(fraserwood_elementary, newData)
    return(fraserwood_elementary)
  } else if (newData$school == "Maple Green Elementary School") {
    maplegreen_elementary <-  rbind(maplegreen_elementary, newData)
    return(maplegreen_elementary)
  }
  
}



new_reg_appender(new_obs)

bothwell_elementary
