
library(dplyr)
library(shiny)

# Leaflet bindings are a bit slow; for now we'll just sample to compensate
public_private_data <- read.csv('/Users/heyunyu/Desktop/Final-shiny-66 2/2015-2018 rank.csv',header = TRUE)

function(input, output, session) {

 
## Data Explorer ###########################################

  observe({
    type <- if (is.null(input$year)) character(0) else {
      filter(public_private_data, Year %in% input$year) %>%
        `$`('Type') %>%
        unique() %>%
        sort()
    }
    stillSelected <- isolate(input$year[input$year %in% public_private_data$Year])
    updateSelectInput(session, "year", choices =public_private_data$Year,
                      selected = stillSelected)
    stillSelected <- isolate(input$type[input$type %in% public_private_data$Type])
    updateSelectInput(session, "type", choices =public_private_data$Type,
      selected = stillSelected)
    
  })



  output$public_private <- DT::renderDataTable({
    df <- public_private_data %>%
      filter(
        is.null(input$year) | Year %in% input$year,
        is.null(input$type) | Type %in% input$type
      ) 
    action <- DT::dataTableAjax(session, df)

    DT::datatable(df, options = list(ajax = list(url = action)), escape = FALSE)
  })
}