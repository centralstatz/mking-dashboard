# Created: 2025-01-22
# Description: Creates global objects for access within app

## Load packages
library(shiny)
library(shinythemes)
library(shinycssloaders)
library(ggplot2)
library(dplyr)
library(stringr)
library(forcats)
library(lubridate)
library(plotly)
library(tidyr)
library(readr)
library(DT)

## Load data files

# Set base path (sourcing straight from GitHub)
base_path <- "https://raw.githubusercontent.com/mking579/Dashboard/refs/heads/main/csv%20files/"

# Import datasets
inequality_data <- read.csv(paste0(base_path, "Inequality.csv"))
gini_data <- read.csv(paste0(base_path, "Gini.csv"))
income_shares_data <- read.csv(paste0(base_path, "Income_Shares.csv"))

healthcare_data <- 
  read.csv(paste0(base_path, "Healthcare_Expenditures.csv")) |>
  
  # Remove characters; parse as numeric quantity
  mutate(
    across(
      c(Out_of_Pocket, Percent_Change_YoY),
      \(x) str_remove(x, pattern = "^[$]|[%]$|[,]") |> as.numeric()
    )
  )

voter_turnout_data <- 
  read.csv(paste0(base_path, "Voter_Turnout_by_State.csv")) |>
  
  # Remove characters; parse as numeric quantity
  mutate(
    across(
      -c(Year, State),
      \(x) str_remove_all(x, pattern = "[,]|[%]") |> as.numeric()
    )
  )

incarceration_data <- 
  read.csv(paste0(base_path, "Incarceration_Counts_Rates.csv")) |>
  
  # Remove characters; parse as numeric quantity
  mutate(
    across(
      c(State.prisons, Federal.prisons, Local.jails),
      \(x) str_remove_all(x, pattern = "[,]") |> as.numeric()
    )
  )

sug_migration_data <- read.csv(paste0(base_path, "SUG_Migration.csv"))

mardi_gras_data <- 
  read.csv(paste0(base_path, "Mardi_Gras_Easter_Dates.csv")) |>
  
  # Change column name
  rename(Easter_Day = Easter_Date) |>
  
  # Parse dates
  mutate(
    
    #Mardi Gras
    Mardi_Gras_Date = 
      
      # Combine the year to extract calendar date
      parse_date_time(
        x = paste0(Year,"-", Mardi_Gras),
        orders = "%Y-%d-%b"
      ),
    
    # Easter
    Easter_Date = 
      
      # Combine the year, month and day to extract calendar date
      parse_date_time(
        x = paste0(Year, "-", Month, "-", Easter_Day),
        orders = "%Y-%m-%d"
      )
  )

iped_data <-
  read_csv(paste0(base_path, "IPED%20Data.csv"))  |>
  
  # Remove extra columns
  select(-starts_with("..."))

school_achievement_data <-
  read_csv(paste0(base_path, "MS_School_Achievement_Data.csv")) |>
  
  # Remove weird characters
  rename_with(\(x) str_remove(x, "\\n"))
