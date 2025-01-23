# Created: 2025-01-22
# Description: Defines the app functionality

# Define the server function
server <- 
  function(input, output, session) {
    
    # Display the inequality plot
    output$inequality_plot <- 
      renderPlot({
        ggplot(inequality_data, aes_string(x = input$x_variable, y = input$y_variable)) +
          geom_point(color = "#007bff", size = 3) +
          labs(title = paste(input$y_variable, "vs", input$x_variable),
               x = input$x_variable,
               y = input$y_variable) +
          theme_minimal(base_size = 14)
      })
    
    filtered_gini <- 
      reactive({
        req(input$gini_states, input$gini_variable)
        gini_data |>
          filter(State %in% input$gini_states) |>
          select(Year, State, all_of(input$gini_variable))
      })
    
    output$gini_plot <- 
      renderPlot({
        dataset <- filtered_gini()
        req(dataset)
        ggplot(dataset, aes(x = Year, y = .data[[input$gini_variable]], color = State, group = State)) +
          geom_line(size = 1.2) +
          scale_color_viridis_d() +
          labs(title = "Gini Over Time", x = "Year", y = input$gini_variable, color = "State") +
          theme_minimal(base_size = 14)
      })
    
    # Add similar plot enhancements for other tabs...
  }