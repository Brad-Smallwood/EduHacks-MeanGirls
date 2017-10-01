
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

function(input, output, session) {
  observeEvent(input$submit, {
    showModal(modalDialog(
      title = "Thank you for registering for Dat Magic School Bus",
      "Please navigate to the Route Info Section for more details"
    ))
  })

}
