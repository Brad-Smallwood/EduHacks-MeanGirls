# Functions for the mapping

# Data will be sent to these functions containing longitude, latitude, identifier(street, house, etc.)


# libraries
library(RCurl)
library(jsonlite)

# First function: School identifier
  # df = dataframe of all current students in the system
  # long, lat = calculated coordinates from entered address
# Probably unnecessary
school = function(df, long, lat){
  # Present list of nearby schools
  schools = df[df$identifier == "School",]
  closeLat = schools[abs(df$lat - lat) < 0.015,]
  closeLong = closeLat[abs(df$long - long) < 0.015]
  if(length(closeLong) == 0){
    # Get school input
  }
  dist = sqrt(sum((long - schools$long)^2, (lat - schools$lat)^2)) # Now have a distance vector to each school
  closeLong$dist = dist
  closeSchools = sort(closeLong$dist)[1:4] # Should yield the 4 closest schools
  return(closeSchools)
}
# This function returns a list of reasonably close schools, allowing the user to select from the provided list
# Should be passed to the shiny app just after address entered


# Second function: Route tracker
route = function(currPath, nextNode){
  # First node is furthest from school
  path = callAPI(currPath, nextNode)[[2]]
  return(path)
}
# Initializes a path from the school to the first node

# Third function: Call API
  # Each node should just be an address. A path is made by stringing them together in order, separated by "|". Includes last location
  # Fix the last item in origin and destination by removing "|" from it
    # SLTN: Dont append "|" to the newNode
callAPI = function(path, newNode){
  basePath = "https://maps.googleapis.com/maps/api/distancematrix/json?origins="
  origins = paste0(path, newNode)
  destinations = paste0(path, newNode)
  raw.data = getURL(paste0(basePath, origins, "&destinations=", destinations, "&mode=walking&language=fr-FR&key=AIzaSyAIrUWA-hGvrl5ar0kvRxWcsGkFP37_USo"))
  # URL is correct
  data = fromJSON(raw.data) # This gives us the two origins with a large quantity of columns
  final_data = do.call(rbind, data)
  newpath = paste0(path, "|", newNode)
  return(list(data, newpath))
}
# Returns a data list that has locations and distances 

holder = callAPI("8619+150+street+Surrey,BC", "8742+144+street+Surrey,BC")
holder1 = holder[[1]]
holder2 = holder[[2]]
temp = route(holder2, "Maple+Green+Elementary+Surrey,BC")
temp
getDist(holder)[1]
holder$destination_addresses[1]

# Fourth function: Turns API output into a usable distanceMatrix
getDist = function(jsonData){
  distanceMatrix = matrix()
  matrixNames = c()
  for(i in 1:length(jsonData$destination_addresses)){
    distanceMatrix = cbind(distanceMatrix, jsonData$rows$elements[[i]]$distance)
    index = regexpr(",", jsonData$destination_addresses)[1]
    name = substr(jsonData$destination_addresses[i], 1, index-1)
    matrixNames = cbind(matrixNames, name)
  }
  distanceMatrix = distanceMatrix[, -c(1)]
  distanceMatrix = distanceMatrix[, -seq(1, dim(distanceMatrix)[2], by = 2)]
  rownames(distanceMatrix) = matrixNames
  colnames(distanceMatrix) = matrixNames
  return(distanceMatrix)
}

myMatrix = getDist(holder)
myMatrix

# Fifth function: Use distance matrix to get optimal path
