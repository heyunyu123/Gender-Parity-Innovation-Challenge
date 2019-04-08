library(shiny)
navbarPage("Gender Parity Exploration", id="nav",

  tabPanel("Public and Private",
           fluidRow(
             column(3,
                    conditionalPanel("year",
                                     selectInput("year", "Year", c("Year"=""))
                    )
             ),
             column(3,
                    conditionalPanel("type",
                                     selectInput("type", "Public or Private", c("Type of University"=""))
                    )
                    

           ),
           hr(),
           DT::dataTableOutput("public_private")
  ),
  
  conditionalPanel("false", icon("crosshair"))
))

