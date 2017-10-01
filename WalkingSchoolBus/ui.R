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
                      titlePanel(h1("Real Fake News")),
                               
                     tabsetPanel(
                       tabPanel(h5("Obesity: Not an Issue Anymore!"), 
                                fluidRow(
                                  column(4,img(src='pvalue.jpg')),
                                  column(8,
                                         h1("Obesity: Not an Issue Anymore!"),
                                         h3("Over the past decade, the obesity rates amongst children in Canada have shot up at an alarming rate. In fact, in 2007 the average weight of a 4th grade student was 95 pounds whereas now, that number is 174! Many top-tier statisticians have followed this trend and attributed this to a lack of walking. In fact, Dr. Alternative (a top researcher at Stanford) has said that his hypothesis tests have proven, without a doubt, that the entirety of this epidemic is a result of parents sending their children to school by busses. "),
                                         h3('Now, you might ask, “But, there were busses in 2007 as well, what’s different now?"'),
                                         h3('A completely valid question for which there is a very logical answer. The famous economist, Milton Freidman has shown that this is due to the terrible economy.'),
                                          h3('He states,'),
                                         h3('“Due to the economic downturn over the past decade, families have had to resort to using McDonalds as a primary source of nutrition due to their low, low prices. This has caused an exponential increase in weight amongst children. Now, obviously you cannot expect families to stop feeding their children and, because all they can afford is McDonalds, they must make some other compromises to stay in shape. We all know that skipping the morning walk means missing out on 1500 burned calories therefore, if kids started walking to school more, they can offset the surplus of calories from switching to a McDonalds-only diet”. '),
                                         h3('Since Friedman is an economist, he obviously isn’t wrong.'),
                                         h3('Luckily, a group of astute students from Simon Fraser University have thought of a brilliant way to remedy this issue and save our futures. They have developed a “human bus” that clusters students living together in groups and then creates optimized walking routes for them. Since the initial release of this platform, there has been a 10000% decrease in obesity! It is a very complicated system and what I have said here does not do it justice.')
                                         )
                                  
                                  )
                                ),
                       tabPanel(h5("The BC Government: In Bed with the Human Bus!"), 
                                fluidRow(
                                  column(4,img(src='johnHorgan.jpg')),
                                  column(8,
                                         h1("The BC Government: In Bed with the Human Bus!"),
                                         h3("It is a well-known fact that the government is corrupt but, is corruption always a bad thing? This moral conundrum is something that we need to deal with now more than ever. News has just leaked (from an anonymous source although, many suspect the Russians) that the BC government has colluded with the start-up “Dat Magic School Bus”. We mentioned this start-up in an earlier article and commended them for their outstanding and innovative contributions to the world of medicine and public health. However, it seems that they have taken on a kind of vigilante role… and are working alongside the government!")
                                        )
                                ),
                                fluidRow(column(11, offset = 1,
                                                h3("The government was so impressed with “Dat Magic School Bus” that they decided to allocate 95% of their budget to the company and have – apparently – pledged to run a deficit for three decades to make sure that the students making up “Dat Magic School Bus” are treated like royalty."),
                                                h3("“These kids are our future, they are revolutionaries and they must be given all the tools they need so that they can perform optimally and continue to maximize the potential of ALL of our futures. It is unfortunate that this information was leaked but I stand by these decisions. As an elected official, it is my sworn duty to do what is best for everyone and I believe this is the path to lead us there”"),
                                                h3("These comments by Winston Churchill following the leak left a crowd of observers in shock. In interviews following this news, they seemed to agree with this course of action and one person even said, “I think that those kids are definitely the future and their ‘human bus’ is a stroke of brilliance that seldom occurs even across generations”. Another observer predicted that the impact of the “human bus” will be comparable to what Einstein did for general relativity."),
                                                h3('Whatever the case may be, I think it is safe to say that in times like these, a little bit of rebellion has always been helpful – whether it be from the people OR the government.')
                                ))
                       ),
                       tabPanel(h5("Dat School Bus Now Implemented in 10 School Districts"), 
                                fluidRow(
                                  column(5,img(src='schoolBusSign.jpg')),
                                  column(7,
                                         h1("Dat School Bus Decreases Obesity Rates in Local Surrey School"),
                                         h3("Some news article about John Horgan"),
                                         h3("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent consequat dapibus bibendum. Praesent fermentum sem sed odio aliquam, in blandit erat imperdiet. Morbi pellentesque sed ligula in eleifend. Cras eu congue eros. Duis sodales fermentum enim non tincidunt. Donec porta metus augue, vehicula commodo nunc vulputate at. Vivamus pellentesque urna ipsum, eu eleifend eros finibus ac.")
                                  )
                                ),
                                fluidRow(column(11, offset = 1,
                                                h3("Sed varius, nunc et condimentum varius, augue tellus ullamcorper dolor, et maximus dui dolor at lorem. Quisque pulvinar vitae nunc nec interdum. Aliquam in neque ac leo ullamcorper hendrerit. Mauris at enim viverra, volutpat metus ut, efficitur tellus. Nulla viverra justo tempus leo aliquam blandit. Nulla sed dictum risus, vitae eleifend nibh. Nullam imperdiet commodo orci, non placerat lectus dignissim sed. Mauris gravida orci quis dolor pellentesque fringilla ac sit amet eros. Nullam ac accumsan mi. Sed laoreet lectus et sem porttitor, non viverra erat porta. Mauris a lectus eget metus semper mattis vitae in diam."),
                                                h3("Proin vehicula metus purus, id eleifend tortor varius at. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed tempor, quam a vestibulum luctus, massa nisi varius lectus, eget placerat metus lectus sed felis. Aliquam quis ornare diam, non iaculis massa. Duis vitae metus at magna fringilla lacinia. Fusce ut varius orci. Donec sem sem, egestas sed gravida et, eleifend eu dui. Nam at fringilla ipsum, ut consequat diam. Donec interdum in quam sit amet maximus. Integer urna turpis, sagittis at tristique at, pellentesque varius neque. Nam eros ex, ornare et viverra id, auctor ac nulla. Fusce at laoreet velit, eu porta metus. Nunc suscipit auctor diam, sed ultricies metus. Maecenas suscipit facilisis felis, ac tincidunt turpis congue eget. Quisque porttitor est id luctus mattis. In ante lorem, facilisis maximus tortor sit amet, aliquam feugiat orci."),
                                                h3("Suspendisse nibh dolor, aliquam vitae mauris nec, facilisis egestas urna. Nunc lorem tellus, laoreet sit amet vehicula in, porttitor faucibus tellus. Donec varius et lorem feugiat dignissim. Fusce vulputate neque id tellus lobortis, scelerisque ultrices mi facilisis. Fusce tempor tincidunt massa ut dignissim.")
                                ))
                       )
                       
                              )
                       ),
             tabPanel("About",
                      titlePanel(h1("What is Dat Magic School Bus All About?")),
                      h4("Dat Magic School Bus is a web application to facilitate students walking together to school in an safe, organized, and optimally short route facilitated by parents who take turns chaperoning the walking shool bus. To learn more about the program, head the the About page in the navigation bar.")
                      ),
             tabPanel("Register",
                      titlePanel(h1("Join Dat Magic School Bus")),
                      fluidRow(
                        column(6, 
                          textInput("pFirstName", label = h3("Parent Walker First Name"), value = "Enter text..."),
                          textInput("pLastName", label = h3("Parent Walker Last Name"), value = "Enter text..."),
                          textInput("address", label = h3("Street Address"), value = "eg. 123 Sesame Street"),
                          selectInput("school", label = h3("School"), choices = c("Bothwell Elementary School", "Fraser Wood Elementary School", "Maple Green Elementary School"),
                                      selected = NULL)
                        ),
                        column(6, 
                          textInput("s1Name", label = h3("Name of First Child"), value = "Enter your child's name"),
                          textInput("s2Name", label = h3("Name of Second Child"), value = "(Optional)"),
                          textInput("s3Name", label = h3("Name of Third Child"), value = "(Optional)"),
                          actionButton("submit", label = "Submit"))
                        )
                      ),



                navbarMenu("Route Info",
              tabPanel("View Your Route"),
              tabPanel("Walking Bus Driver Schedule"),
              tabPanel("Route Number Directory")
             ),
             tabPanel("How Does It Work?"),
             tabPanel("Contact Us",
                      h1("Developers"),
                      h3("Kristen Bystrom"),
                      h5("ksbystrom@gmail.com"),
                      h5(uiOutput("kristen")),
                      h3("Matthew Reyers"),
                      h5("matthewreyers3333@gmail.com"),
                      h5(uiOutput("matt")),
                      h3("Brad Smallwood"),
                      h5("brad_smallwood@hotmail.com"),
                      h5(uiOutput("brad")),
                      h3("Barinder Thind"),
                      h5("bthind@sfu.ca"),
                      h3("Helen Huynh"),
                      h5("helen@placeholder.com"),
                      h5(uiOutput("helen")))
))
