
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(plotGoogleMaps)
library(plotGoogleMaps)
library(readr)
master = read_csv("~/EduHacks-MeanGirls/Master.csv")
shortMaster = master[,c("family", "Cluster", "parent", "child1", "child2", "child3")]
colnames(shortMaster) <- c("Last Name", "Route Number", "Parent Chaperone", "First Child", "Second Child", "Third Child")
schoolMaster <- master
parentList1 <- master[master$Cluster ==1,c("family", "parent")]
parentList2 <- master[master$Cluster ==2,c("family", "parent")]
parentList3 <- master[master$Cluster ==3,c("family", "parent")]
table2 <- data.frame(day = integer(31), chaperone = character(31), stringsAsFactors = FALSE)


function(input, output, session){

  observeEvent(input$cluster2, {

      # if(input$cluster2 == 1){
      #   for(i in 1:31){
      #     table2$day[i] <- i
      #     if(i == 30){
      #       table2$chaperone[i] <- parentList1[30,'family']
      #     }
      #     else{
      #     table2$chaperone[i] <- parentList1[(i%%30),'family']
      #     }
      #   }
      # }
      # if(input$cluster2 == 2){
      #   for(i in 1:31){
      #     table2$day[i] <- i
      #     if(i%%9 ==0){
      #       table2$chaperone[i] <- parentList2[9,'family']
      #     }
      #     else{
      #       table2$chaperone[i] <- parentList2[(i%%9),'family']
      #     }
      #   }
      # }
      # if(input$cluster2 == 3){
      #   for(i in 1:31){
      #     table2$day[i] <- i
      #     table2$chaperone[i] <- parentList3[1,'family']
      #   }
      # }
    table2 <- matrix(ncol=2, nrow=31)
    for(i in 1:31){
      table2[i,1] <- i
      if(i == 30){
        table2[i,2] <- as.character(parentList1[30,'family'])
      }
      else{
        table2[i,2] <- as.character(parentList1[(i%%30),'family'])
      }
    }
  })

  observeEvent(input$submit, {
    showModal(modalDialog(
      title = "Thank you for registering for Dat Magic School Bus",
      "Please navigate to the Route Info Section for more details"
    ))
    registration<- NULL
    registration$X1 <- length(master$X1) + 1
    registration$family <- input$pLastName
    registration$address <- input$address
    registration$city <- input$city
    registration$school <- input$school
    registration$lattitude <- NA
    registration$longitude <- NA
    registration$Cluster <- NA
    registration$fakeDist <- NA
    registration$parent <- input$pFirstName
    registration$child1 <- input$s1Name
    registration$child2 <- input$s2Name
    registration$child3 <- input$s3Name
    registration <- as.data.frame(registration)
  })
  
  
  # Generate a plot of the requested variable against mpg and only 
  output$mymap <- renderUI({

    masterUpdated <- geo_updated(master)
    coordinates(masterUpdated)<-~lattitude + longitude
    proj4string(masterUpdated) <- CRS('+init=epsg:28992')
    m <- plotGoogleMaps(masterUpdated, filename = 'myMap1.html', openMap = F)
    tags$iframe(
      srcdoc = paste(readLines('myMap1.html'), collapse = '\n'),
      width = "100%",
      height = "600px"
    )
  })
  ##############################################################
  urlKristen <- a("Kristen's LinkedIn", href="https://www.linkedin.com/in/kristen-bystrom-45583aa9/")
  output$kristen <- renderUI({
    tagList("Check out ", urlKristen)
  })
  urlmatt <- a("Matthew's LinkedIn", href="https://www.linkedin.com/in/matthew-reyers-73713aa7/")
  output$matt <- renderUI({
    tagList("Check out ", urlmatt)
  })
  urlbrad <- a("Brad's LinkedIn", href="https://www.linkedin.com/in/brad-smallwood/")
  output$brad <- renderUI({
    tagList("Check out ", urlbrad)
  })
  urlhelen <- a("Helen's LinkedIn", href="https://www.linkedin.com/in/helen-huynh-86199a111/")
  output$helen <- renderUI({
    tagList("Check out ", urlhelen)
  })
  # Compute the forumla text in a reactive expression since it is 
  # shared by the output$mapPlot ?I think I still need to do this...

  output$table1 <- renderTable(master)
  
  output$table2 <- renderDataTable(table2) 


}




