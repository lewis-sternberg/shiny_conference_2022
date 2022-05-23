library(shiny) #loads shinny lib

#FluidPage is one of the many basic page layout
ui <- fluidPage( #UI is the inital structure of shiny
  "Hello" #this adds the text
)

server <- function(input, output, session) { #input stores all the user values, output is what displays on the shinny application, session used as communication between shinny server
  
}

shinyApp(ui, server)

#note code is stored within the app - will be visible
