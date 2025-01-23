# Created: 2025-01-22
# Description: Creates global objects for access within app

## Load packages
library(shiny)
library(shinythemes)
library(shinycssloaders)
library(ggplot2)
library(dplyr)

## Load data files

# Set base path (sourcing straight from GitHub)
base_path <- "https://raw.githubusercontent.com/mking579/Dashboard/refs/heads/main/csv%20files/"

# Import datasets
inequality_data <- read.csv(paste0(base_path, "Inequality.csv"))
gini_data <- read.csv(paste0(base_path, "Gini.csv"))
income_shares_data <- read.csv(paste0(base_path, "Income_Shares.csv"))
healthcare_data <- read.csv(paste0(base_path, "Healthcare_Expenditures.csv"))
voter_turnout_data <- read.csv(paste0(base_path, "Voter_Turnout_by_State.csv"))
incarceration_data <- read.csv(paste0(base_path, "Incarceration_Counts_Rates.csv"))
sug_migration_data <- read.csv(paste0(base_path, "SUG_Migration.csv"))