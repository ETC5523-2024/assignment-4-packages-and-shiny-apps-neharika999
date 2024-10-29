library(shiny)
library(ggplot2)
library(dplyr)

data("summer_movies", package = "movie")
data("summer_movie_genres", package = "movie")

# Define UI for application
ui <- fluidPage(
  titlePanel("Explore Summer-Themed Movies"),

  # Sidebar layout for inputs
  sidebarLayout(
    sidebarPanel(
      selectInput("genre", "Select Genre:",
                  choices = c("All", unique(summer_movie_genres$genres)),
                  selected = "All"),
      sliderInput("year_range", "Select Year Range:",
                  min = min(summer_movies$year, na.rm = TRUE),
                  max = max(summer_movies$year, na.rm = TRUE),
                  value = c(min(summer_movies$year, na.rm = TRUE),
                            max(summer_movies$year, na.rm = TRUE))),
      sliderInput("rating", "Minimum Rating:",
                  min = 0, max = 10, value = 5, step = 0.1),
      downloadButton("downloadData", "Download Filtered Data")
    ),

    # Main panel for displaying outputs
    mainPanel(
      h4("Filtered Movie Plots"),
      plotOutput("filtered_rating_plot"),
      br(),
      h4("Average Rating Over Time"),
      plotOutput("rating_plot"),
      br(),
      h4("How to Interpret the Output?"),
      p("Use the filters on the sidebar to customize your view by genre, year range, and minimum rating.
        The first plot shows the distribution of movie ratings based on your filters, helping you assess
        how ratings vary within your chosen criteria. The second plot displays how the average rating has
        evolved over time, giving insights into trends in movie popularity or quality.")
    )
  )
)

# Define server logic
server <- function(input, output) {

  # Merge the datasets, renaming or removing conflicting columns
  merged_data <- reactive({
    data <- inner_join(summer_movies %>% rename(movie_genres = genres),
                       summer_movie_genres, by = "tconst")

    # Use the `genres` from `summer_movie_genres` for filtering and drop `movie_genres`
    if (input$genre != "All") {
      data <- data %>%
        filter(genres == input$genre)
    }

    # Apply year range and rating filters
    data %>%
      filter(year >= input$year_range[1],
             year <= input$year_range[2],
             average_rating >= input$rating)
  })

  # Replace the table with a plot of filtered movies (e.g., distribution of ratings)
  output$filtered_rating_plot <- renderPlot({
    data <- merged_data()

    ggplot(data, aes(x = average_rating)) +
      geom_histogram(binwidth = 0.5, fill = "skyblue", color = "black") +
      labs(title = "Distribution of Average Ratings",
           x = "Average Rating", y = "Count")
  })

  # Plot showing average rating over time
  output$rating_plot <- renderPlot({
    merged_data() %>%
      group_by(year) %>%
      summarise(avg_rating = mean(average_rating, na.rm = TRUE)) %>%
      ggplot(aes(x = year, y = avg_rating)) +
      geom_line(color = "blue") +
      geom_point() +
      labs(title = paste("Average Rating for", input$genre, "Movies Over Time"),
           x = "Year", y = "Average Rating")
  })

  # Download filtered data
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("filtered_movies_data.csv")
    },
    content = function(file) {
      write.csv(merged_data(), file, row.names = FALSE)
    }
  )
}

# Run the application
shinyApp(ui = ui, server = server)

