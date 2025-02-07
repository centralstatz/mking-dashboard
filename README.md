# mking-dashboard

A Shiny application...

# Change Log

## 1/22/2025

* Original R code sourced from https://github.com/mking579/Dashboard/blob/main/app.R
* Separated `app.R` into three components: `global.R`, `server.R`, `ui.R`
* Datasets are sourced straight from the [GitHub repository](https://github.com/mking579/Dashboard/tree/main/csv%20files)
* Replaced usage of `%>%` with the newer base R pipe `|>` to reduce package dependency
* Used `rsconnect::writeManifest` to write app metadata for Posit Connect Cloud (see [this site](https://docs.posit.co/connect-cloud/how-to/r/shiny-r.html#add-dependency-file))
* App is live on Posit Connect Cloud: https://01949177-2ccc-ffe2-3233-5a7c0dade354.share.connect.posit.cloud/

## 1/23/2025

* Added working graphs for all tabs
  + All are basically a similar time series graph
  + For `sug_migration_data`, used an ordered bar plot by state (restricted to single `university_selected`)
* Updated to `ggplot2` best practices (e.g., use `aes` instead of deprecated `aes_string`)
* Used `linewidth` instead of `size` for `geom_line` width
* Display the selected variable name in the plot title
* Parse the columns in `healthcare_data`, `voter_turnout_data` and `incarceration_data` to be numeric (added app dependency to `stringr` package)
* Added multi-axis graph for healthcare expenditures
* Fixed selector items for `incarceration_variable` to match dataset column names

## 2/6/2025

* Removed the "Classes" tab, as that will be moved to Quarto website
* Added drop-down menus to like-pages
* Added dependency for `lubridate` for date parsing
* Added dependency on `tidyr` for data manipulation
* Added dependency on `plotly` for interactive plotting
* Recreated `manifest.json` using `rsconnect::writeManifest`