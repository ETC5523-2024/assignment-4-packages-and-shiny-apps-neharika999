
<!-- README.md is generated from README.Rmd. Please edit that file -->

# MOVIE

The **movie** package provides tools for exploring and analyzing
summer-themed movies using IMDb data. The package includes a Shiny app
for interactive data exploration, functions for filtering and analyzing
movie data, and visualizations for insights such as rating trends and
genre distributions. The package is designed to help users discover
trends, patterns, and statistics related to summer-themed movies.

You can view a comprehensive guide to this package on its website.

## Installation

You can install the **movie** package directly from GitHub. First,
ensure you have the `devtools` package installed, then use
`install_github()`:

``` r
# Install devtools if you haven't already
install.packages("devtools")

# Install the movie package from GitHub
devtools::install_github("ETC5523-2024/assignment-4-packages-and-shiny-apps-neharika999/movie")
```

You can install the development version of movie from
[GitHub](https://github.com/) with:

## Example

#### Example 1: Filtering Movies by Genre

The `filter_movies_by_genre()` function filters movies by genre. To see
only comedy movies:

``` r
# Filtering for comedy movies
filtered_data <- summer_movies %>% filter(genres=="Drama")
head(filtered_data)
```

#### Example: Plotting Average Ratings Over Time

Use `ggplot2` to visualize trends in the filtered data. Here’s an
example of plotting average ratings over time for a specific genre:

``` r
library(ggplot2)

# Average rating plot for comedy movies over time
ggplot(filtered_data, aes(x = year, y = average_rating)) +
  geom_line(color = "blue") +
  geom_point() +
  labs(title = "Average Ratings of Comedy Movies Over Time",
       x = "Year", y = "Average Rating")
```

## Launching the Shiny App

The package includes an interactive Shiny app that allows users to
explore the data through a web interface. You can launch the app using
the following command:

``` r
launch_app()
```

The Shiny app provides an easy way to:

- Select specific genres and filter by rating and year range.

- View interactive plots and gain insights into summer-themed movies.

## Accessing the Vignette

The package includes a vignette that demonstrates how to use its
features. Load the vignette as follows:

``` r
vignette("movie_analysis")
```

## Contributing

If you encounter any issues or would like to contribute to the
development of the **movie** package, feel free to create a pull request
or submit an issue on GitHub.
