library(readr)
summer_movie_genres <- read_csv("data-raw/summer_movie_genres.csv")
summer_movies <- read_csv("data-raw/summer_movies.csv")

usethis::use_data(summer_movie_genres, overwrite = T)
usethis::use_data(summer_movies, overwrite = T)
