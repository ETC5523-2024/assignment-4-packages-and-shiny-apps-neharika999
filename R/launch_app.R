# Function to launch the shiny app
launch_app <- function() {
  app_dir <- system.file("shiny", package = "movie")
  shiny::runApp(app_dir, display.mode = "normal")
}

