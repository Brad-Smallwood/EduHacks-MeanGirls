#Author: Kristen Bystrom
#Purpose: To provide an interface for schools to implement a walking school bus program


#To-do
#1. Add padding  tags$style(type="text/css", "body {padding-top: 70px;}")

library(shiny)

shinyUI(

  navbarPage(title = "Walking School Bus", id = "main",
             position = "fixed-top", header = "This is the header text",
             footer = "This is the footer text", inverse = TRUE, collapsible = TRUE,
             fluid = TRUE, theme = NULL, windowTitle = "The Magic School Bus", 
             tabPanel("Home"),
             tabPanel("About"),
             tabPanel("Register"),
             navbarMenu("Route Info",
                        tabPanel("View Your Route"),
                        tabPanel("Walking Bus Driver Schedule"),
                        tabPanel("Route Number Directory")
             ),
             tabPanel("Contact Us"))
)
