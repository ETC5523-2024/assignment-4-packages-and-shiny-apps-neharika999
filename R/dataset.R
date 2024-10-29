#' Summer Movies Dataset
#'
#' This dataset contains information about summer-themed movies, including movie titles, release year,
#' runtime, genres, IMDb rating, and the number of votes. It is used to analyze trends and patterns
#' in movies that are commonly released during the summer season.
#'
#' @format A data frame with the following columns:
#' \describe{
#'   \item{tconst}{Character. Unique identifier for each movie.}
#'   \item{title_type}{Character. Type of the title (e.g., "movie", "short").}
#'   \item{primary_title}{Character. Main title of the movie.}
#'   \item{original_title}{Character. Original title of the movie.}
#'   \item{year}{Integer. Year the movie was released.}
#'   \item{runtime_minutes}{Numeric. Runtime of the movie in minutes.}
#'   \item{genres}{Character. Genres associated with the movie (e.g., "Comedy", "Drama").}
#'   \item{average_rating}{Numeric. IMDb average rating of the movie.}
#'   \item{num_votes}{Integer. Number of votes received on IMDb.}
#' }
#' @source IMDb dataset, curated for TidyTuesday.
#' @examples
#' data(summer_movies)
#' head(summer_movies)
"summer_movies"
#' Summer Movie Genres Dataset
#'
#' This dataset provides genre information associated with each movie, using the same unique identifiers as in `summer_movies`.
#' It is intended to complement the main `summer_movies` dataset, enabling users to filter or analyze data based on genre.
#'
#' @format A data frame with the following columns:
#' \describe{
#'   \item{tconst}{Character. Unique identifier for each movie, matching the `tconst` field in the `summer_movies` dataset.}
#'   \item{genres}{Character. Genre(s) associated with each movie (e.g., "Action", "Romance").}
#' }
#' @examples
#' data(summer_movie_genres)
#' head(summer_movie_genres)
"summer_movie_genres"
