# Functions for the mapping

# Data will be sent to these functions containing longitude, latitude, identifier(street, house, etc.)


# libraries
library(RCurl)
library(jsonlite)
library(Rfast)
library(TSP)
library(gtools)

x <- matrix(NA, 10, 10)
x[sample(1:100, 10)] <- rpois(10, 3)
x
floyd(x)

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
# Not Necessary
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
  newpath = paste0(path, "|", newNode)
  origins = newpath
  destinations = newpath
  print(newpath)
  raw.data = getURL(paste0(basePath, origins, "&destinations=", destinations, "&mode=walking&language=fr-FR&key=AIzaSyAIrUWA-hGvrl5ar0kvRxWcsGkFP37_USo"))
  # URL is correct
  data = fromJSON(raw.data) # This gives us the two origins with a large quantity of columns
  final_data = do.call(rbind, data)
  return(list(data, newpath))
}
# Returns a data list that has [[1]] as the data used for getDist and [[2]] as the actual path nodes (not ordered)

holder = callAPI("8619+150+street+Surrey,BC", "8742+144+street+Surrey,BC")
holder1 = holder[[1]]
holder2 = holder[[2]]
temp = callAPI(holder2, "8854+152+street+Surrey,BC")
temp[[1]]


# Fourth function: Turns API output into a usable distanceMatrix
getDist = function(jsonData){
  distanceMatrix = matrix()
  matrixNames = c()
  for(i in 1:length(jsonData$destination_addresses)){
    distanceMatrix = cbind(distanceMatrix, jsonData$rows$elements[[i]]$distance)
    index = regexpr(",", jsonData$destination_addresses[i])[1]
    print(index)
    name = substr(jsonData$destination_addresses[i], 1, index-1)
    matrixNames = cbind(matrixNames, name)
  }
  distanceMatrix = distanceMatrix[, -c(1)]
  distanceMatrix = distanceMatrix[, -seq(1, dim(distanceMatrix)[2], by = 2)]
  rownames(distanceMatrix) = matrixNames
  colnames(distanceMatrix) = matrixNames
  return(distanceMatrix)
}

myMatrix = as.matrix(getDist(temp[[1]]))
names(myMatrix)
floyd(myMatrix)
myMatrix
# Path below does not contain the school Node
# Fifth function: Use distance matrix to get optimal path
bestPath = function(inputPath, schoolName, schoolAddress){
  # Steps:
    # Create the dist matrix
    apiReturn = callAPI(schoolName, inputPath) 
    dist = as.matrix(getDist(apiReturn[[1]]))
    #print(dist)
    
    # Identify optimal path to schoolName
    currPath = c()
    visitedNodes = c()
    unvisitedNodes = rownames(dist)
    
    #print(str(unvisitedNodes))
    #print("Q")
    schoolRow = dist[schoolAddress, ]
    #print("F")
    
    # Build from school outwards
    furthestDist = max(schoolRow) # Goal is to get the node name that is furthest from school
    furthestNode = ""
    for(i in 1:length(unvisitedNodes)){
      if(schoolRow[i] == furthestDist){
        furthestNode = unvisitedNodes[i]
        nodeFar = i
      }
      if(schoolRow[i] == 0){
        nodeClose = i
      }
    }
    #print(furthestNode)
    distToFar = floyd(dist)
    #print("E")
    # Create a dummy arc from school to far node, must be weight zero
    
    #print("L")
    # Now apply greedy TSP. Must include start (far) and end (school) node
    #print(schoolAddress)
    #print(furthestNode)

    permList = permutations(n = dim(dist)[1] -2, r= dim(dist)[1] -2, v = unvisitedNodes[-c(nodeFar, nodeClose)])
    #print(permList)
    min = 10000000
    optPath = c()
    
    for(k in 1:dim(permList)[1]){
      distCalc = dist[furthestNode, permList[k, 1]]
      for(i in 2:dim(dist)[1] - 2){

        #print(dist[permList[k, i-1], permList[k, i]])
        newNum = sum(distCalc, dist[permList[k, i-1], permList[k, i]])
        #print(newNum)
        distCalc = newNum
        recent = i
      }
      #print("A")
      #print(distCalc)
      distCalc = distCalc + dist[permList[k, recent], nodeClose]
      if(distCalc < min){
        min = distCalc
        optPath = permList[k,]
      }
    }
    return(list(min, optPath))
    
}
# Output list with 2vector
  # Vector 1 is collection of nodes in order, ele 1 is first house and last ele is school
  # Vector 2 is the distance from previous node to next node, with ele 1 being 0

myPath = bestPath(temp[[2]], "Maple+Green+Elementary+Surrey,BC", "14898 Spenser Dr")
myPath
