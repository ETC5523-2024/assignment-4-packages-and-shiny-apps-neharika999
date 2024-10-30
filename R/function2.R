#' Summarize Genre Statistics
#'
#' This function provides summary statistics for each genre in the dataset, including
#' the count of movies, mean rating, and median rating.
#'
#' @param data A data frame containing movie data, such as `summer_movies`.
#' @return A data frame with summary statistics for each genre.
#' @importFrom dplyr n
#' @examples
#' data("summer_movies")
#' # Get genre statistics
#' summarize_genre_statistics(summer_movies)
#' @export
summarize_genre_statistics <- function(data) {
  data %>%
    tidyr::separate_rows(genres, sep = ", ") %>%
    dplyr::group_by(genres) %>%
    dplyr::summarise(
      movie_count = n(),
      mean_rating = mean(average_rating, na.rm = TRUE),
      median_rating = median(average_rating, na.rm = TRUE)
    ) %>%
    dplyr::arrange(desc(movie_count))
}
