library(shiny)
library(glue)

ui <- fluidPage(
  actionButton("add", "Add"),
  numericInput("which", "Which to remove?", value = 1),
  actionButton("remove", "Remove"),
  div(id = "variables")
)

server <- function(input, output, session) {
  observeEvent(input$add, {
    insertUI(
      selector = "#variables",
      where = "beforeEnd", #all the objects added within the element, but at the end of it
      ui = wellPanel(id = input$add, input$add), #Type of UI element
      immediate = TRUE #this will make the change straight away, otheriwse it will wait untill the UI is implemented
    )
  })
  
  observeEvent(input$remove, {
    removeUI(
      selector = glue("#{input$which}"), #CSS selection 
    )
  })
}

shinyApp(ui, server)