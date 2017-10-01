
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
<<<<<<< HEAD
library(plotGoogleMaps)
library(readr)

meuse = read_csv("~/GitHub/EduHacks-MeanGirls/Master.csv")
coordinates(meuse)<-~lattitude+longitude
meuse # Now a coordinate structure
proj4string(meuse) <- CRS('+init=epsg:28992')
=======
>>>>>>> d3f47f5f656565c1494ab1ebdc8bf0c532bec5e6

function(input, output, session) {
  observeEvent(input$submit, {
    showModal(modalDialog(
      title = "Thank you for registering for Dat Magic School Bus",
      "Please navigate to the Route Info Section for more details"
    ))
    registration <- as.data.frame(c(input$pLastName, input$address, input$city, input$school))
    family_list <- data_updater(family_list, registration)
  })
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

}
