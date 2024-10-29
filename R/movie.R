#' movie: A Package for Analyzing and Exploring Summer-Themed Movies
#'
#' The **movie** package provides tools for exploring and analyzing summer-themed movies using IMDb data. The package includes a Shiny app for interactive data exploration, functions for filtering and analyzing movie data, and visualizations for insights such as rating trends and genre distributions. The package is designed to help users discover trends, patterns, and statistics related to summer-themed movies.
#'
#' ## Key Features
#'
#' - **Data Filtering**: Use functions like `filter_movies_by_genre()` to filter the movie dataset by genre, year range, and IMDb rating.
#' - **Trend Analysis**: Visualize trends in IMDb ratings and the popularity of movies over time.
#' - **Interactive Shiny App**: Explore the data interactively with filtering options for genre, year range, and rating.
#' - **Documentation and Examples**: Access detailed documentation, usage examples, and a vignette to guide you through using the package.
#'
#' ## Installation
#'
#' You can install the **movie** package directly from GitHub:
#' ```r
#' # Install devtools if not installed
#' install.packages("devtools")
#'
#' # Install the movie package from GitHub
#' devtools::install_github("ETC5523-2024/assignment-4-packages-and-shiny-apps-neharika999/movie")
#' ```
#'
#' ## Usage
#'
#' ### Filtering Movies by Genre
#' The `filter_movies_by_genre()` function filters the movie dataset by genre. Here’s an example:
#' ```r
#' # Filter for drama movies
#' filtered_data <- summer_movies %>% filter(genres == "Drama")
#' head(filtered_data)
#' ```
#'
#' ### Plotting Average Ratings Over Time
#' Use `ggplot2` to visualize IMDb rating trends in the filtered data:
#' ```r
#' library(ggplot2)
#'
#' # Plot average ratings for Comedy movies over time
#' ggplot(filtered_data, aes(x = year, y = average_rating)) +
#'   geom_line(color = "blue") +
#'   geom_point() +
#'   labs(title = "Average Ratings of Comedy Movies Over Time",
#'        x = "Year", y = "Average Rating")
#' ```
#'
#' ### Launching the Shiny App
#' The package includes an interactive Shiny app. You can launch it with:
#' ```r
#' launch_app()
#' ```
#' The Shiny app provides an intuitive interface to filter and visualize movie data based on genre, year, and rating.
#'
#' ## Datasets
#'
#' ### `summer_movies`
#' This dataset contains details about summer-themed movies, including:
#' - `tconst`: Unique identifier for each movie.
#' - `title_type`: Type of the title (e.g., movie, short).
#' - `primary_title`: Main title of the movie.
#' - `original_title`: Original title of the movie.
#' - `year`: Year of release.
#' - `runtime_minutes`: Duration of the movie in minutes.
#' - `genres`: Genres associated with the movie.
#' - `average_rating`: IMDb average rating.
#' - `num_votes`: Number of votes the movie received.
#'
#' ### `summer_movie_genres`
#' This dataset contains genre information for each movie identified by `tconst`, allowing for filtering and analysis by genre.
#'
#' ## Accessing the Vignette
#'
#' For a detailed guide, load the vignette:
#' ```r
#' vignette("movie_analysis")
#' ```
#'
#' ## License
#' This package is licensed under the MIT License.
#'
#' @docType package
#' @name movie
"_PACKAGE"
