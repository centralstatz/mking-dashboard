# Created: 2025-01-22
# Description: Defines the app functionality

# Define the server function
server <- 
  function(input, output, session) {
    
    ## Inequality
    
    # Display the inequality plot
    output$inequality_plot <- 
      renderPlot({
        inequality_data |>
          ggplot(
            aes(
              x = .data[[input$x_variable]], 
              y = .data[[input$y_variable]]
            )
          ) +
          geom_point(
            color = "#007bff", 
            size = 3
          ) +
          labs(
            title = paste(input$y_variable, "vs", input$x_variable),
            x = input$x_variable,
            y = input$y_variable
          ) +
          theme_minimal(base_size = 14)
      })
    
    ## Gini
    
    # Build the Gini dataset
    filtered_gini <- 
      reactive({
        
        # Check for existence of inputs
        req(input$gini_states, input$gini_variable)
        
        gini_data |>
          
          # Filter to the selected states
          filter(State %in% input$gini_states) |>
          
          # Keep a subset of columns
          select(
            Year, 
            State, 
            input$gini_variable
          )
      })
    
    # Display the Gini plot
    output$gini_plot <- 
      renderPlot({
        
        # Ensure the dataset exists
        dataset <- filtered_gini()
        req(dataset)
        
        # Make the plot
        dataset |>
          ggplot(
            aes(
              x = Year, 
              y = .data[[input$gini_variable]], 
              color = State, 
              group = State
            )
          ) +
          geom_line(linewidth = 1.2) +
          scale_color_viridis_d() +
          labs(title = paste0(input$gini_variable, " Over Time"), x = "Year", y = input$gini_variable, color = "State") +
          theme_minimal(base_size = 14)
      })
    
    ## Income shares
    
    # Build the income shares dataset
    filtered_income_shares <- 
      reactive({
        
        # Check for existence of inputs
        req(input$income_states, input$income_variable)
        
        income_shares_data |>
          
          # Filter to the selected states
          filter(State %in% input$income_states) |>
          
          # Keep a subset of columns
          select(
            Year, 
            State, 
            input$income_variable
          )
      })
    
    # Display the income shares plot
    output$income_shares_plot <- 
      renderPlot({
        
        # Ensure the dataset exists
        dataset <- filtered_income_shares()
        req(dataset)
        
        # Make the plot
        dataset |>
          ggplot(
            aes(
              x = Year, 
              y = .data[[input$income_variable]], 
              color = State, 
              group = State
            )
          ) +
          geom_line(linewidth = 1.2) +
          scale_color_viridis_d() +
          labs(title = paste0(input$income_variable, " Over Time"), x = "Year", y = input$income_variable, color = "State") +
          theme_minimal(base_size = 14)
      })
    
    ## Healthcare expenditures
    
    # Display the plot (static; no inputs)
    output$healthcare_plot <-
      renderPlot({
        
        healthcare_data |>
          
          # Make the plot
          ggplot(
            aes(
              x = Year, 
              y = Out_of_Pocket
            )
          ) +
          geom_line(
            linewidth = 1.2,
            color = "darkred"
          ) +
          geom_line(
            aes(
              y = Percent_Change_YoY / 100 * 50000
            ),
            linetype = 2
          ) +
          scale_y_continuous(
            name = "Out of Pocket ($)",
            labels = scales::dollar_format(),
            sec.axis = sec_axis(~./50000, name = "Year-Over-Year Percentage Change (%)", labels = scales::percent)
          ) +
          labs(title = "Health Expenditures Over Time") +
          theme_minimal(base_size = 14)
        
      })
    
    ## Voter turnout
    
    # Build the income shares dataset
    filtered_voter_turnout <- 
      reactive({
        
        # Check for existence of inputs
        req(input$voter_states, input$voter_variable)
        
        voter_turnout_data |>
          
          # Filter to the selected states
          filter(State %in% input$voter_states) |>
          
          # Keep a subset of columns
          select(
            Year, 
            State, 
            input$voter_variable
          )
      })
    
    # Display the voter input graph
    output$voter_turnout_plot <- 
      renderPlot({
        
        # Ensure the dataset exists
        dataset <- filtered_voter_turnout()
        req(dataset)
        
        # Make the plot
        dataset |>
          ggplot(
            aes(
              x = Year, 
              y = .data[[input$voter_variable]], 
              color = State, 
              group = State
            )
          ) +
          geom_line(linewidth = 1.2) +
          scale_color_viridis_d() +
          labs(title = paste0(input$voter_variable, " Over Time"), x = "Year", y = input$voter_variable, color = "State") +
          theme_minimal(base_size = 14)
      })
    
    ## Incarceration rates
    
    # Build the incarceration dataset
    filtered_incarceration <- 
      reactive({
        
        # Check for existence of inputs
        req(input$incarceration_variable)
        
        incarceration_data |>
          
          # Keep a subset of columns
          select(
            Year, 
            input$incarceration_variable
          )
      })
    
    # Display the incarceration graph
    output$incarceration_plot <- 
      renderPlot({
        
        # Ensure the dataset exists
        dataset <- filtered_incarceration()
        req(dataset)
        
        # Make the plot
        dataset |>
          ggplot(
            aes(
              x = Year, 
              y = .data[[input$incarceration_variable]]
            )
          ) +
          geom_line(linewidth = 1.2) +
          labs(title = paste0(input$incarceration_variable, " Over Time"), x = "Year", y = input$incarceration_variable) +
          theme_minimal(base_size = 14)
      })
    
    ## SUG migration
    
    # Build the SUG dataset
    filtered_SUG <- 
      reactive({
        
        # Check for existence of inputs
        req(input$university_select)
        
        sug_migration_data |>
          
          # Keep a subset of columns
          select(
            State,
            University = input$university_select
          ) |>
          
          # Remove states with missing values for this variable
          filter(!is.na(University)) |>
          
          # Order the states by selected column
          mutate(
            State = 
              State |>
              fct_reorder(
                .x = University,
                .fun = min
              )
          )
      })
    
    # Display the SUG graph
    output$sug_migration_plot <-
      renderPlot({
        
        # Ensure the dataset exists
        dataset <- filtered_SUG()
        req(dataset)
        
        # Make the plot
        dataset |>
          ggplot(
            aes(
              x = State,
              y = University
            )
          ) +
          geom_col() +
          coord_flip() +
          labs(title = paste0(input$university_select, " SUG Migration by State"), x = "Year", y = input$university_select) +
          theme_minimal(base_size = 14)
        
      }, height = 500)
    
    ## Mardi Gras
    
    # Display the graph (no inputs)
    output$mardi_gras_plot <-
      renderPlotly({
        
        date_plot <-
          mardi_gras_data |>
          
          # Clean up
          rename(
            `Mardi Gras` = Mardi_Gras_Date,
            Easter = Easter_Date
          ) |>
          
          # Send dates down the rows
          pivot_longer(
            cols = c(`Mardi Gras`, Easter),
            names_to = "Event",
            values_to = "Date"
          ) |>
          
          # Make a plotting element
          mutate(
            MonthDay = as.numeric(paste0(month(Date), ".", day(Date)))
          ) |>
          
          # Make a plot
          ggplot(
            aes(
              x = Year,
              y = MonthDay,
              color = Event,
              text = 
                paste0(
                  "Event: ", Event,
                  "<br>Year: ", Year,
                  "<br>Date: ", format(Date, "%b %d %Y")
                ),
              group = Event
            )
          ) +
          geom_line() +
          geom_point() +
          theme_minimal() +
          theme(
            legend.position = "top"
          ) +
          xlab("Event Year") +
          scale_y_continuous(
            name = "Event Month",
            labels = function(x) month(x, label = T)
          ) +
          scale_color_manual(values = c("orange", "green"))
        
        ggplotly(date_plot, tooltip = "text")
        
      })
    
    ## IPED
    
    # Build the IPED dataset
    filtered_iped <- 
      reactive({
        
        # Set default
        temp_dat <- iped_data
        
        # Filter if necessary
        if(!is.null(input$iped_university))
          temp_dat <- temp_dat |> filter(`Institution Name` %in% input$iped_university)
        
        temp_dat
        
      })
    
    # Show table
    output$iped_table <-
      renderDataTable({
        filtered_iped()
      })
    
    ## MS School Achievement
    
    # Build the dataset
    filtered_school_achievement <- 
      reactive({
        
        # Set default
        temp_dat <- school_achievement_data
        
        # Filter if necessary
        if(!is.null(input$ms_district))
          temp_dat <- temp_dat |> filter(`District Name` %in% input$ms_district)
        
        temp_dat
        
      })
    
    # Show table
    output$ms_table <-
      renderDataTable({
        filtered_school_achievement()
      })
    
  }