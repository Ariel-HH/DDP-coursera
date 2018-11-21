library(shiny)

# Define UI for dataset viewer application
shinyUI(pageWithSidebar(
      
      # Application title
      headerPanel("Exploring Datasets"),
      
      # Sidebar with controls to select a dataset and specify the number
      # of observations to view
      sidebarPanel(
            selectInput("dataset", "Choose a dataset:", 
                        choices = c("rock", "pressure", "cars", "mtcars", "iris")),
            
            numericInput("obs", "Number of observations to view:", 6),
            
            uiOutput("varChoices"),
            
            sliderInput("bins", "Number of bins in histogram", 2, 50, 20)
      ),
      
      # Show a summary of the dataset and an HTML table with the requested
      # number of observations
      mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("Documentation", verbatimTextOutput("doc")),
                        tabPanel("app",
                                 tableOutput("view"),
                                 
                                 plotOutput("plot1")
                                 )
            )
      )
))
