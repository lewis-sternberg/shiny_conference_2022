library(shiny)

ui <- fluidPage(
  sliderInput( #need to be able to take inputs and use them in the application
    inputId = "my_slider_one", label = "Select number here", value = 1, min = 1, max = 10, step = 1
  ),
  actionButton(
    inputId = "my_button", label = "Click Me!"
  )
)

server <- function(input, output, session) {
  observeEvent(input$my_slider_one, { #observeEvent function takes two variable, first is input, section expression is output. When first expression changes, section is trigured
    print("Slider changed") #this print is only within the console
    print(input[["my_slider_one"]])
  })
  
  observeEvent(input$my_button, {
    updateSliderInput(session, "my_slider_one", value = sample(1:10, 1)) #each input has an associated update function #here we can update the slider values
  }) #this builds chain of dependency
}

shinyApp(ui, server)
