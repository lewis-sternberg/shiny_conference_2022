library(shiny)
library(shinyGizmo) #ShinyGizo uses modals which are kept in a different server. As if you use shiny Modals, when you use it, Shiny app goes make to native state
#Modal is the hidden content of shinny application which can be displayed on top of the application e.g. a pop-up box
#These should be used for user inputs or warnings messages

ui <- fluidPage(
  modalDialogUI(
    modalId = "my_modal",
    "Modal content"
  ),
  actionButton("open_second", "Open 2nd modal", icon = icon("pen")),
  modalDialogUI(
    modalId = "my_modal_2",
    textInput("my_text_2", "Place text here"),
    textOutput("my_text_2_out"),
    button = NULL
  ),
  modalDialogUI( #function used at the Modal
    modalId = "my_modal_3",
    textInput("my_text_3", "Place text here"),
    footer = actionButton("close", "Close", icon = icon("times"), `data-dismiss` = "modal") #This is close button in modal #custom attribute of data-dismiss can be used to close the Modal
  ),
  textOutput("my_text_3_out")
)

server <- function(input, output, session) {
  
  observeEvent(input$open_second, {
    showModalUI("my_modal_2") #this actually opens the Modal using unique ID
  })
  
  output$my_text_2_out <- renderText({
    input$my_text_2 
  })
  
  output$my_text_3_out <- renderText({
    input$my_text_3
  })
  
  observeEvent(input$close, {
    print("modal closed")
  })
}

shinyApp(ui, server)