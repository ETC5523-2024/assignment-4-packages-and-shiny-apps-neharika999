library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(scales)

# Loading data
data("summer_movies", package = "movie")
data("summer_movie_genres", package = "movie")

# Defining UI for application
ui <- fluidPage(
  titlePanel("Explore Summer-Themed Movies"),

  # Sidebar layout for inputs
  sidebarLayout(
    sidebarPanel(
      # Genre filter: Select a specific genre or view all
      selectInput("genre", "Select Genre:",
                  choices = c("All", unique(summer_movie_genres$genres)),
                  selected = "All"),

      # Year range filter: Select a range of years for movies
      sliderInput("year_range", "Select Year Range:",
                  min = min(summer_movies$year, na.rm = TRUE),
                  max = max(summer_movies$year, na.rm = TRUE),
                  value = c(min(summer_movies$year, na.rm = TRUE),
                            max(summer_movies$year, na.rm = TRUE)),
                  sep = ""),  # Remove comma from years

      # Rating filter: Select minimum rating for filtering movies
      sliderInput("rating", "Minimum Rating:",
                  min = 0, max = 10, value = 5, step = 0.1),


      downloadButton("downloadData", "Download Filtered Data")
    ),

    # Main panel for displaying outputs
    mainPanel(
      h4("Filtered Movie Plots"),
      plotlyOutput("filtered_rating_plot"),  # Interactive histogram with Plotly
      br(),
      h4("Average Rating Over Time"),
      plotlyOutput("rating_plot"),  # Interactive line plot with Plotly
      br(),
      h4("Field Descriptions"),
      p("The following fields are available in the movie dataset:"),
      tags$ul(
        tags$li(tags$b("tconst:"), " Unique identifier for each movie."),
        tags$li(tags$b("title_type:"), " Type of title (e.g., movie, short)."),
        tags$li(tags$b("primary_title:"), " The main title of the movie."),
        tags$li(tags$b("original_title:"), " Original title of the movie."),
        tags$li(tags$b("year:"), " The release year of the movie."),
        tags$li(tags$b("runtime_minutes:"), " Duration of the movie in minutes."),
        tags$li(tags$b("genres:"), " Genres associated with the movie (e.g., Comedy, Drama)."),
        tags$li(tags$b("average_rating:"), " IMDb average rating of the movie."),
        tags$li(tags$b("num_votes:"), " Number of votes the movie received on IMDb.")
      ),
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

    # Filter by genre if not "All"
    if (input$genre != "All") {
      data <- data %>% filter(genres == input$genre)
    }

    # Apply year range and rating filters
    data %>%
      filter(year >= input$year_range[1],
             year <= input$year_range[2],
             average_rating >= input$rating)
  })

  # Plot: Distribution of Ratings
  output$filtered_rating_plot <- renderPlotly({
    data <- merged_data()

    p <- ggplot(data, aes(x = average_rating)) +
      geom_histogram(binwidth = 0.5, fill = "skyblue", color = "black") +
      labs(title = "Distribution of Average Ratings",
           x = "Average Rating", y = "Count") +
      theme_minimal()

    ggplotly(p)
  })

  output$rating_plot <- renderPlotly({
    data <- merged_data() %>%
      group_by(year) %>%
      summarise(avg_rating = mean(average_rating, na.rm = TRUE))

    p <- ggplot(data, aes(x = year, y = avg_rating)) +
      geom_line(color = "blue") +
      geom_point() +
      scale_x_continuous(labels = label_number(accuracy = 1)) +
      labs(title = paste("Average Rating for", input$genre, "Movies Over Time"),
           x = "Year", y = "Average Rating") +
      theme_minimal()

    ggplotly(p)
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

