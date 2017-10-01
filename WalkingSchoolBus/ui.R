#Author: Kristen Bystrom
#Purpose: To provide an interface for schools to implement a walking school bus program


#To-do
#1. Add padding  tags$style(type="text/css", "body {padding-top: 70px;}")

library(shiny)

shinyUI(

  navbarPage(title = "Dat Magic School Bus", id = "main",
             position = "static-top", 
             inverse = TRUE, collapsible = TRUE,
             fluid = TRUE, theme = NULL, windowTitle = "The Magic School Bus", 
             tabPanel("Home",
                      titlePanel(h1("News")),
                               
                     tabsetPanel(
                       tabPanel(h4("Dat School Bus Decreases Obesity Rates in Local Surrey School"), 
                                img(src='schoolBusWalk.jpg', align = "left"),
                                h3("Some news article about obesity")),
                       tabPanel(h4("BC Government Partners with Dat School Bus"), 
                                img(src='johnHorgan.jpg', align = "left"),
                                h3("Some news article about John Horgan")),
                       tabPanel(h4("Dat School Bus Now Implemented in 10 School Districts"), 
                                img(src='schoolBusSign.jpg', align = "left"),
                                h3("Some news article about growth"))
                     )
                               
             ),
             tabPanel("About",
                      titlePanel(h1("What is Dat Magic School Bus All About?"))),
             tabPanel("Register",
                      titlePanel(h1("Join Dat Magic School Bus")),
                      fluidRow(
                        column(6, 
                          textInput("pFirstName", label = h3("Parent Walker First Name"), value = "Enter text..."),
                          textInput("pLastName", label = h3("Parent Walker Last Name"), value = "Enter text..."),
                          textInput("address", label = h3("Street Address"), value = "eg. 123 Sesame Street")
                        ),
                        column(6, 
                          textInput("s1Name", label = h3("Name of First Child"), value = "Enter your child's name"),
                          textInput("s2Name", label = h3("Name of Second Child"), value = "(Optional)"),
                          textInput("s3Name", label = h3("Name of Third Child"), value = "(Optional)"))
                        )
                      ),



                navbarMenu("Route Info",
              tabPanel("View Your Route"),
              tabPanel("Walking Bus Driver Schedule"),
              tabPanel("Route Number Directory")
             ),
             tabPanel("Contact Us"))
)
