library(shiny)
library(shinyGizmo)
library(glue)

setwd("C:/Users/LewisSternberg/OneDrive - CEN-ESG/Desktop/git/shiny_conference_2022/")
source("tools.R")

column_ui <- function(id, name) {
  ns <- NS(id)
  wellPanel(
    id = id,
    modalDialogUI(
      ns("modal"), 
      textInput(ns("name"), "Name", value = name),
      footer = actionButton(ns("confirm"), "Confirm", `data-dismiss` = "modal")
    ),
    actionButton(ns("delete"), NULL, icon("trash-alt")),
    textOutput(ns("outname"), inline = TRUE)
  )
}

column_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    showModalUI("modal") #this opens modal right after it is open
    
    observeEvent(input[["delete"]], {
      removeUI(glue("#{id}"))
    })
    
    observeEvent(input[["confirm"]], {
      print(reactiveValuesToList(input)) #input object of modal  is different to server - this takes all the values within the modal and converts them to a list and then we can use them later on
      print("modal closed")
    })
    
    output[["outname"]] <- renderText({
      input[["name"]]
    })
  })
}

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      numericInput("nrow", "Number of rows", value = 50, min = 1, max = 1000, step = 1),
      textOutput("number_facts"),
      div(id = "variables"),
      textInput("name", "Column name"),
      conditionalPanel(
        "input.name != ''",
        actionButton("new", NULL, icon = icon("plus"), width = "100%")  
      ),
      conditionalPanel(
        "input.nrow > 0 & $('#variables > div').length > 0",
        actionButton("run", NULL, icon = icon("play"), width = "100%")  
      )
    ),
    mainPanel(
      DT::dataTableOutput("table")
    )
  )
)

server <- function(input, output, session) {
  
  my_table <- reactiveVal(NULL)
  
  observeEvent(input$new, {
    id <- genid()
    insertUI(
      "#variables",
      where = "beforeEnd",
      ui = column_ui(id, input$name),
      immediate = TRUE
    )
    column_server(id)
  })
  
  observeEvent(input$run, {
    my_table(iris[1:input$nrow, ])
  })
  
  output$table <- DT::renderDataTable({
    validate(need(
      !is.null(my_table()),
      "No table created."
    ))
    my_table()
  }, options = list(
    paging = TRUE,
    pageLength = 10
  ))
}

shinyApp(ui, server)
