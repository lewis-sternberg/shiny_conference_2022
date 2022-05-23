# https://shiny.rstudio.com/articles/layout-guide.html
library(shiny)

ui <- fluidPage(
  sidebarLayout( #layout options, shiny has some prebuilt layouts
    sidebarPanel(
      h3("Sidebar Title"),
      "Sidebar",
      width = 2 #full width in this layout is 12
    ),
    mainPanel(
      div("I'm in the main panel"),
      "I'm here as well"
    )
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)