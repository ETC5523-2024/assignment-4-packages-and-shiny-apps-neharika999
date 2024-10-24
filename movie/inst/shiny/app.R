library(shiny)
library(ggplot2)
library(dplyr)

# Define UI for application
ui <- fluidPage(
  titlePanel("Explore Summer-Themed Movies"),

  # Sidebar layout for inputs
  sidebarLayout(
    sidebarPanel(
      selectInput("genre", "Select Genre:",
                  choices = unique(cleaned_summer_movies$genres_y),
                  selected = "Comedy"),
      sliderInput("year_range", "Select Year Range:",
                  min = min(cleaned_summer_movies$year, na.rm = TRUE),
                  max = max(cleaned_summer_movies$year, na.rm = TRUE),
                  value = c(1990, 2020)),
      sliderInput("rating", "Minimum Rating:",
                  min = 0, max = 10, value = 5, step = 0.1)
    ),

    # Main panel for displaying outputs
    mainPanel(
      h4("Filtered Movies"),
      tableOutput("filtered_table"),
      br(),
      h4("Average Rating Over Time"),
      plotOutput("rating_plot")
    )
  )
)


# Define server logic
server <- function(input, output) {

  # Filtered dataset based on user input
  filtered_data <- reactive({
    cleaned_summer_movies %>%
      filter(genres_y == input$genre,
             year >= input$year_range[1],
             year <= input$year_range[2],
             average_rating >= input$rating)
  })

  # Render the table of filtered movies
  output$filtered_table <- renderTable({
    filtered_data()
  })

  # Plot showing average rating over time
  output$rating_plot <- renderPlot({
    filtered_data() %>%
      group_by(year) %>%
      summarise(avg_rating = mean(average_rating, na.rm = TRUE)) %>%
      ggplot(aes(x = year, y = avg_rating)) +
      geom_line(color = "blue") +
      geom_point() +
      labs(title = paste("Average Rating for", input$genre, "Movies Over Time"),
           x = "Year", y = "Average Rating")
  })
}


