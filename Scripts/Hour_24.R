library(shiny)

ui <- fluidPage(
  
  numericInput(inputId = "num", label = "Select number of Simulations:", value = 100),
  
  textInput(inputId = "title", label = "Enter title text:"),
  
  plotOutput(outputId = "histogram")
  
  )

server <- function(input, output){
  
  data <- reactive(rnorm(input$num))
  
  output$histogram <- renderPlot({
    
    hist(data(), main = input$title, xlab = "Simulated Data")
    
    })
  
  }

shinyApp(ui = ui, server = server)
