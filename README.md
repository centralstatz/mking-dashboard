# mking-dashboard

A Shiny application...

# Change Log

## 1/22/2025

* Original R code sourced from https://github.com/mking579/Dashboard/blob/main/app.R
* Separated `app.R` into three components: `global.R`, `server.R`, `ui.R`
* Datasets are sourced straight from the [GitHub repository](https://github.com/mking579/Dashboard/tree/main/csv%20files)
* Replaced usage of `%>%` with the newer base R pipe `|>` to reduce package dependency
* Used `rsconnect::writeManifest` to write app metadata for Posit Connect Cloud (see [this site](https://docs.posit.co/connect-cloud/how-to/r/shiny-r.html#add-dependency-file))