#' Return a heatmap showing the missing values in the file.
#'
#' @param file the name of the file, including the filetype extension
#' @param sheet_name if passing an excel file, the name of the sheet to analyze, by default 0
#' @param dir the directory where the file should be saved, by default ''
#'
#' @return .png file heatmap of missing values, as a .png file
#'
#' @examples
#' missing_data_overview(customers.xlsx, sheet_name='2019', dir='report')
missing_data_overview <- function(file, sheet_name=0, dir='') {
  
}

