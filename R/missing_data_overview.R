#' Helper function to read the file and return a dataframe.
#'
#' Checks if file is type .csv or excel. If not, return an error.
#'
#' @param file the name of the file, including the path and filetype extension
#' @param sheet_name if passing an excel file, the name of the sheet to analyze (default = NULL)
#'
#' @return dataframe
#' @NoRd
load_file <- function(file, sheet_name = NULL) {
  out <- tryCatch({
    if (tools::file_ext(file) == "csv") {
      readr::read_csv(file)
    }
    else {
      readxl::read_xlsx(file, sheet = sheet_name)
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
#' @NoRd
make_plot_1 <- function(df) {
  df %>%
    is.na %>%
    reshape2::melt() %>%
    ggplot2::ggplot(ggplot2::aes(x = Var2,
                                 y = Var1)) +
    ggplot2::geom_raster(ggplot2::aes(fill = value)) +
    ggplot2::scale_fill_viridis_d(name = "",
                                  labels = c("Not missing", "Missing")) +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)) +
    ggplot2::labs(x = "Column name",
                  y = "Row number",
                  title = "Heatmap of missing values")
}

#' Return a heatmap showing the missing values in the file.
#'
#' @param file the name of the file, including the filetype extension
#' @param sheet_name if passing an excel file, the name of the sheet to analyze, by default NULL
#' @param dir the directory where the file should be saved, by default ''
#'
#' @return .png file heatmap of missing values, as a .png file
#' @NoRd
#'
#' @examples
missing_data_overview <- function(file,
                                  sheet_name = NULL,
                                  dir = '') {
  df <- load_file(file, sheet_name = sheet_name)
  fig <- make_plot_1(df)
  p = ggplot2::ggsave(paste0(dir, sheet_name, "_heatmap.png"),
                      device = "png")
}
