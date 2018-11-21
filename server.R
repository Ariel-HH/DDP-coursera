library(shiny)
library(datasets)
library(leaflet)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
      
      # Return the requested dataset
      datasetInput <- reactive({
            switch(input$dataset,
                   "rock" = rock,
                   "pressure" = pressure,
                   "cars" = cars,
                   "mtcars" = mtcars,
                   "iris" = iris)
      })
      # select variable name from dataset
      output$varChoices <- renderUI({
            variables <- names(datasetInput())
            selectInput("variable", "Select variable for histogram",
                        choices = variables)
      })
      # generate plot (histogram of variable)
      output$plot1 <- renderPlot({
            var <- datasetInput()[[input$variable]]
            hist(var, breaks = seq(min(var), max(var), length.out = input$bins), 
                 main = paste("Histogram of", input$variable), col = "blue")
      })
      
      # Show the first "n" observations
      output$view <- renderTable({
            head(datasetInput(), n = input$obs)
      })
      
      # Documentation
      output$doc <- renderText({"This is a very simple app, designed to explore a few basic R datasets.
In the sidebar panel you can select the dataset, the number of observations you want to see (like using 'head' function in R).
Also, you cant select a variable in the dataset to show a histogram and the number of bins in the histogram."})
})