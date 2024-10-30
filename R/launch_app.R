#' Launch the Shiny Application
#'
#' This function launches the Shiny application for exploring summer-themed movies.
#' The app provides interactive filtering options for genre, year range, and minimum rating,
#' along with visualizations to analyze trends and distributions in movie data.
#'
#' @return Launches the Shiny application for interactive data exploration.
#' @export
launch_app <- function() {
  app_dir <- system.file("inst/shiny/app.r", package = "movie")
  shiny::runApp(app_dir, display.mode = "normal")
}

