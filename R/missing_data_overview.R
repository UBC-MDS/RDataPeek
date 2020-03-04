library(reshape2)
library(ggplot2)
library(tidyverse)
library("tools")
library(readxl)

#' Helper function to read the file and return a dataframe.
#'
#' Checks if file is type .csv or excel. If not, return an error.
#'
#' @param the name of the file, including the path and filetype extension
#' @param if passing an excel file, the name of the sheet to analyze (defailt = 0)
#'
#' @return dataframe
#' @export
load_file <- function(file, sheet_name = 0) {
  out <- tryCatch({
    if (file_ext(file) == ".csv") {
      read_csv(file)
    }
    else {
      read_excel(file, sheet = sheet_name)
    }
  },
  error = function(cond) {
    message("Please use a valid csv or excel file.")
    message(cond)
    return(NA)
  })
  return(out)
}

#' Helper function used to create heatmap showing missing values in a dataframe.
#'
#' @param df the dataframe object to analyze
#'
#' @return ggplot heatmap
#' @export
make_plot <- function(df) {
  df %>%
    is.na %>%
    melt %>%
    ggplot(aes(x = Var2,
               y = Var1)) +
    geom_raster(aes(fill = value)) +
    scale_fill_viridis_d(name = "",
                         labels = c("Not missing", "Missing")) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(x = "Column name",
         y = "Row number",
         title = "Heatmap of missing values")
}

#' Return a heatmap showing the missing values in the file.
#'
#' @param file the name of the file, including the filetype extension
#' @param sheet_name if passing an excel file, the name of the sheet to analyze, by default 0
#' @param dir the directory where the file should be saved, by default ''
#'
#' @return .png file heatmap of missing values, as a .png file
#'
#' @examples
#' missing_data_overview("customers.xlsx", sheet_name='2019', dir='report')
missing_data_overview <- function(file,
                                  sheet_name = 0,
                                  dir = '') {
  df <- load_file(file, sheet_name = sheet_name)
  fig <- make_plot(df)
  p = ggsave(paste0(dir, sheet_name, "_heatmap.png"),
             device = "png")
}
