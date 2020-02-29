#' Return a data table showing column names in rows, an example record, column data types and
#'  summary statistics for numerical, categorical and long-form text data
#'
#' @param file the name of the file, including the filetype extension
#' @param sheet_name if passing an excel file, the name of the sheet to analyze, by default 0
#' @param dir the directory where the file should be saved, by default ''
#'
#' @return data summary includes column names in rows, an example record, column data types and
#'   summary statistics for numerical (range), categorical (unique values) 
#'    and long-form text data (average length of string)
#'
#' @examples
#' sample_data(customers.xlsx, sheet_name='2019', dir='report')

sample_data <- function(file, sheet_name=0, dir='') {

 }
