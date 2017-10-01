


install.packages("RJSONIO")


library(ggplot2)
library(RCurl)
library(RJSONIO)
library(plyr)
library(class)
library(stringr)

url <- function(address, return.call = "json", sensor = "false") {
  root <- "http://maps.google.com/maps/api/geocode/"
  u <- paste(root, return.call, "?address=", address, "&sensor=", sensor, sep = "")
  return(URLencode(u))
}

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



address <- c("The White House, Washington, DC","The Capitol, Washington, DC")
locations  <- ldply(address, function(x) geoCode(x))
names(locations)  <- c("lat","lon","location_type", "formatted")
head(locations)

# Data

data <- read.csv("Book2.csv", header = TRUE)
View(data)

# Route Optimization Function

?kmeans()
# Need to convert Matt's matrix to a regular matrix?  Can we remove the extra useless data?

bothwell_elementary = read.csv("bothwell_elementary.csv")
bothwell_elementary = bothwell_elementary[, c(-1, -2)]

ggplot(bothwell_elementary[,5:6], aes(x = bothwell_elementary$lattitude, y = bothwell_elementary$longitude)) + geom_point()

# Cluster Function:  Take dataframe and return dataframe with cluster vector added.
pathSplit <- function(df, k){
  #  Run K-Means
  df.kmean = df[ , 5:6]
  km.out <- kmeans(df.kmean, k, nstart = 25)
  newdf <- cbind(df, km.out$cluster)
  if("km.out$cluster" %in% colnames(newdf)){
    colnames(newdf)[colnames(newdf) == 'km.out$cluster'] <- "Cluster"
  }
  newdf$Cluster = as.factor(newdf$Cluster) 
  return(newdf)
}

pathSplit.out = pathSplit(bothwell_elementary, 4)
View(pathSplit.out)

plot1 <- ggplot(pathSplit.out, aes(x = lattitude, y = longitude, color = Cluster)) + 
  geom_point() +
  labs(title = "Walk Clusters\n") +
  scale_color_manual(labels = c("Cluster 1", "Cluster 2"), values = c("blue", "red")) +
  ggtitle("Walking Clusters Example") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("cluster_example_k1.png")

plot1

plot(bothwell_elementary, col = (pathSplit.out$Cluster + 1), main = "K-Means Clustering Results with K = 2", pch = 20, cex = 2)
# Distance Calcualation Function


distanceCalc(df){
  
}

# Bothwell Location
# 17070 102 Ave, Surrey, BC V4N 4N6
#
# First need to set up format that callAPI likes.  Remove spaces, change to +.
# Next select first two rows. Then loop through and keep adding to the path more.
#
#

opt_func <- function(df, maxD, maxSize){
  # Initialize
  k = 1
  
  # Change data strings to be readable by Matt's functions
  df <- gsub(" ", df, replacement = "+")
  df <- 
  
  # Base call to callAPI()
  # Arg1 = first address, Arg2 = second address
  holder = callAPI(, )
  
  #Test to see how big df is.  K-mean again if too big
  if(nrow(df) >= maxSize){
    k = k + 1
    testSplit = pathSplit(df, k)
    opt_func(testSplit, maxD, maxSize)
  }else{ # Not too big.  Split based off of number of clusters
    for(i in 1:length(unique(pathSplit.out$Cluster))){
      temp <- df %>% filter(Cluster == i)
      l <- distanceCalc(temp)
      if (l <= maxD){ # If distance is less than max then finish.  Return df with clusters
        return(temp)
      }else{
        k = k + 1
        temp2 <- pathSplit(temp, k)
        opt_func(temp2, maxD)
      }
    }
  }
}

optim.df <- opt_func(bothwell_elementary, 1, 15)

fakeData = pathSplit.out
fakeDist = runif(60, 1, 3000)
fakeData = cbind(fakeData, fakeDist)
View(fakeData)
