
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(plotGoogleMaps)
library(readr)

meuse = read_csv("~/GitHub/EduHacks-MeanGirls/Master.csv")
coordinates(meuse)<-~lattitude+longitude
meuse # Now a coordinate structure
proj4string(meuse) <- CRS('+init=epsg:28992')

function(input, output, session) {
  observeEvent(input$submit, {
    showModal(modalDialog(
      title = "Thank you for registering for Dat Magic School Bus",
      "Please navigate to the Route Info Section for more details"
    ))
    registration<- NULL
    registration$X1 <- length(family_list$X1) + 1
    registration$family <- input$pLastName
    registration$address <- input$address
    registration$city <- input$city
    registration$school <- input$school
    registration$lattitude <- NA
    registration$longitude <- NA
    registration$Cluster <- NA
    registration$fakeDist <- NA
    family_list <- new_reg_appender(family_list, registration)
  })
  ######################### CONSTRUCTION ########################
  formulaText <- reactive({
    #paste the input name in so it follows argument format for plotGoogleMaps?
    #tried without, don't think it is probelm, works with test code...
    paste(input$variable)
  })
  
  
  # Generate a plot of the requested variable against mpg and only 
  # include outliers if requested
  output$mapPlot <- renderPlot({
    plotGoogleMaps(meuse, zcol=formulaText)
    #also tried to specify alternative arguments like add=TRUE, 
    #filename='mapPlot.htm', openMap=FALSE
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


}




