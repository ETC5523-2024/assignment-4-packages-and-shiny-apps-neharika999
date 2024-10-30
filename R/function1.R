#' Filter Movies by Genre
#'
#' This function filters the `summer_movies` dataset by the specified genre.
#' If "All" is selected, it returns the entire dataset without filtering.
#'
#' @param data A data frame containing movie data, such as `summer_movies`.
#' @param genre A character string specifying the genre to filter by.
#'   Use "All" to include all genres.
#' @return A data frame filtered by the specified genre.
#' @importFrom magrittr %>%
#' @examples
#' data("summer_movies")
#' # Filter for Comedy movies
#' filter_movies_by_genre(summer_movies, "Comedy")
#' @export
filter_movies_by_genre <- function(data, genre) {
  if (genre != "All") {
    data <- data %>% dplyr::filter(grepl(genre, genres, ignore.case = TRUE))
  }
  return(data)
}
