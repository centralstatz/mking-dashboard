# Created: 2025-01-22
# Description: Builds the user interface

# Define the user interface
ui <- 
  navbarPage(
    theme = shinytheme("sandstone"),
    title = "Dashboard",
    
    # About Tab
    tabPanel(
      title = "About",
      icon = icon("info-circle"),
      fluidPage(
        h3("About"),
        p("Welcome to Dr. King's Dashboard. This is a work in progress. It features an introduction to different data on inequality, voting, healthcare, and more for various topics, including inequality, income shares, healthcare expenditures, voter turnout and more. Use the tabs above to navigate through the different sections.")
      )
    ),
    
    # Tab 1: Inequality
    navbarMenu(
      title = "Inequality",
      
      # Gini
      tabPanel(
        title = "Gini",
        icon = icon("balance-scale"),
        sidebarLayout(
          sidebarPanel(
            selectInput(
              inputId = "gini_states", 
              label = "Select States:",
              choices = unique(gini_data$State),
              selected = unique(gini_data$State)[1:3],
              multiple = TRUE
            ),
            selectInput(
              inputId = "gini_variable", 
              label = "Select Variable:",
              choices = c("Atkin05", "Gini", "RMeanDev", "Theil"),
              selected = "Gini"
            )
          ),
          mainPanel(
            plotOutput("gini_plot") |> withSpinner(color = "#007bff")
          )
        )
      ),
      
      # Healthcare expenditures
      tabPanel(
        title = "Healthcare Expenditures",
        icon = icon("heartbeat"),
        sidebarLayout(
          sidebarPanel(
            h4("Healthcare Expenditures Overview"),
            p("This chart displays trends in out-of-pocket expenditures and year-over-year percentage changes.")
          ),
          mainPanel(
            plotOutput("healthcare_plot") |> withSpinner(color = "#007bff")
          )
        )
      ),
      
      # Incarceration counts/rates
      tabPanel(
        title = "Incarceration Counts & Rates",
        icon = icon("gavel"),
        sidebarLayout(
          sidebarPanel(
            selectInput(
              inputId = "incarceration_variable", 
              label = "Select Variable:",
              choices = c("State.prisons", "Federal.prisons", "Local.jails",
                          "State_Prison_Rate_100k", "Federal_Prison_Rate_100k",
                          "Local_Jail_Rate_100k"),
              selected = "State prisons"
            )
          ),
          mainPanel(
            plotOutput("incarceration_plot") |> withSpinner(color = "#007bff")
          )
        )
      ),
      
      # Income Shares
      tabPanel(
        title = "Income Shares",
        icon = icon("dollar-sign"),
        sidebarLayout(
          sidebarPanel(
            selectInput(
              inputId = "income_states", 
              label = "Select States:",
              choices = unique(income_shares_data$State),
              selected = unique(income_shares_data$State)[1:3],
              multiple = TRUE
            ),
            selectInput(
              inputId = "income_variable", 
              label = "Select Income Variable:",
              choices = c("Top10_adj", "Top5_adj", "Top1_adj", "Top05_adj", "Top01_adj", "Top001_adj"),
              selected = "Top10_adj"
            )
          ),
          mainPanel(
            plotOutput("income_shares_plot") |> withSpinner(color = "#007bff")
          )
        )
      ),
      
      # Inequality
      tabPanel(
        title = "Inequality",
        icon = icon("chart-bar"),
        sidebarLayout(
          sidebarPanel(
            h4("Customize Plot"),
            selectInput(
              inputId = "x_variable", 
              label = "Select X-axis Variable:",
              choices = c("Disenfranchisement_Rank", "Environmental_Rank", "Arts_Dollars_Rank",
                          "Total_Incarceration_Rate", "Black_Homeownership_Rate", 
                          "Legislative_Professionalism", "Union_Membership_Rate_2018", 
                          "White_Homeownership_Rate", "Black_Pop_Percent_2018", 
                          "Gini_2018", "PerCap_Educ_Spending_2018", "GDP_2023_Growth_Rank", 
                          "Black_BA%_Rank", "Cost_of_Voting_Index_Rank", "GDP_Capita_Rank", 
                          "Labor_Force_Participation_Rate_Rank", 
                          "Denial_Rates_Black_Homeowner_Applicants"),
              selected = "GDP_Capita_Rank"
            ),
            selectInput(
              inputId = "y_variable", 
              label = "Select Y-axis Variable:",
              choices = c("Disenfranchisement_Rank", "Environmental_Rank", "Arts_Dollars_Rank",
                          "Total_Incarceration_Rate", "Black_Homeownership_Rate", 
                          "Legislative_Professionalism", "Union_Membership_Rate_2018", 
                          "White_Homeownership_Rate", "Black_Pop_Percent_2018", 
                          "Gini_2018", "PerCap_Educ_Spending_2018", "GDP_2023_Growth_Rank", 
                          "Black_BA%_Rank", "Cost_of_Voting_Index_Rank", "GDP_Capita_Rank", 
                          "Labor_Force_Participation_Rate_Rank", 
                          "Denial_Rates_Black_Homeowner_Applicants"),
              selected = "GDP_2023_Growth_Rank"
            )
          ),
          mainPanel(
            plotOutput("inequality_plot") |> withSpinner(color = "#007bff")
          )
        )
      )
      
    ),
    
    # Tab 2: Education
    navbarMenu(
      title = "Education",
      
      # SUG Migration
      tabPanel(
        title = "SUG Migration",
        icon = icon("university"),
        sidebarLayout(
          sidebarPanel(
            selectInput(
              inputId = "university_select", 
              label = "Select University:",
              choices = colnames(sug_migration_data)[-1],
              selected = "University_of_Mississippi"
            )
          ),
          mainPanel(
            plotOutput("sug_migration_plot") |> withSpinner(color = "#007bff")
          )
        )
      ),
      
      # IPED
      tabPanel(
        title = "IPED",
        icon = icon("school"),
        sidebarLayout(
          sidebarPanel(
            selectInput(
              inputId = "iped_university", 
              label = "Institution(s)",
              choices = sort(unique(iped_data$`Institution Name`)),
              multiple = TRUE
            )
          ),
          mainPanel(
            dataTableOutput("iped_table") |> withSpinner(color = "#007bff")
          )
        )
      ),
      
      # MS school achievement
      tabPanel(
        title = "MS School Achievement",
        icon = icon("school"),
        sidebarLayout(
          sidebarPanel(
            selectInput(
              inputId = "ms_district", 
              label = "District",
              choices = sort(unique(school_achievement_data$`District Name`)),
              multiple = TRUE
            )
          ),
          mainPanel(
            dataTableOutput("ms_table") |> withSpinner(color = "#007bff")
          )
        )
      )
    ),
    
    # Tab 3: Voting
    navbarMenu(
      title = "Voting",
      
      # Voter Turnout By State
      tabPanel(
        title = "Voter Turnout by State",
        icon = icon("users"),
        sidebarLayout(
          sidebarPanel(
            selectInput(
              inputId = "voter_states", 
              label = "Select States:",
              choices = sort(unique(voter_turnout_data$State)),
              selected = sort(unique(voter_turnout_data$State))[1:3],
              multiple = TRUE
            ),
            selectInput(
              inputId = "voter_variable", 
              label = "Select Variable:",
              choices = colnames(voter_turnout_data)[!(colnames(voter_turnout_data) %in% c("Year", "State"))],
              selected = colnames(voter_turnout_data)[3]
            )
          ),
          mainPanel(
            plotOutput("voter_turnout_plot") |> withSpinner(color = "#007bff")
          )
        )
      )
    ),
    
    # Tab 3: Miscellaneous
    navbarMenu(
      title = "Miscellaneous",
      
      # Mardi Gras/Easter Dates
      tabPanel(
        title = "Mardi Gras/Easter Dates",
        icon = icon("egg"),
        sidebarLayout(
          sidebarPanel(
            h4("Mardi Gras vs. Easter Dates Over Time"),
            p("This chart displays a comparison of Mardi Gras and Easter dates over time.")
          ),
          mainPanel(
            plotlyOutput("mardi_gras_plot") |> withSpinner(color = "#007bff")
          )
        )
      ),
    ),
 
    # Footer
    tags$footer(
      style = "background-color: #343a40; color: #ffffff; text-align: center; padding: 10px; position: fixed; bottom: 0; width: 100%;",
      HTML("© 2025 Dr. King's Dashboard | Built with Shiny")
    )
  )