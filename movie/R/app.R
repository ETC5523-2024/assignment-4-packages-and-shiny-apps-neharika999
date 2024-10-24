# Function to launch the shiny app
launch_app <- function() {
  shinyApp(ui = ui, server = server)
}
