#' Helper function to read the file and return a dataframe.
#'
#' Checks if file is type .csv or excel. If not, return an error.
#'
#' @param file the name of the file, including the path and filetype extension
#' @param sheet_name if passing an excel file, the name of the sheet to analyze (default = NULL)
#'
#' @return dataframe
#' @export
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

#' Helper function used to create summary data table showing column names in rows,
#' an example record, column data types and summary statistics for different data types
#'
#' @param df the dataframe object to analyze
#'
#' @return dataframe
#' @export
summarize_data <- function(df) {
  # create data frame with column names and first record
  result <- as.data.frame(t(dplyr::slice(df, 1)))
  result['columns'] <- colnames(df)
  result <- dplyr::select(dplyr::mutate(result, sample_record = V1), columns, sample_record)

  # add data types of columns
  result['data_type'] <- sapply(df, class)

  # add summary statistics
  summary <- vector()
  for (row in 1:nrow(result)) {
    column <- result[row, "columns"]
    data_type <- result[row, "data_type"]

    if (data_type == "numeric") {
      stat <- round(mean(dplyr::pull(df[column]), na.rm = TRUE), 2)
      message <- paste("Mean value is: ", stat)
    } else if (data_type == "character") {
      stat <- nrow(unique(df[column]))
      message <- paste("Number of unique values is:", stat)
    } else {
      message <- "No summary available"
    }
    summary[row] <- message
  }
  result['summary'] = summary

  return(result)
}


#' Return a data table showing column names in rows, an example record, column data types and
#'  summary statistics for numerical, categorical and long-form text data
#'
#' @param file the name of the file, including the filetype extension
#' @param sheet_name if passing an excel file, the name of the sheet to analyze, by default 0
#' @param dir the directory where the file should be saved, by default ''
#'
#' @return data summary includes column names in rows, an example record, column data types and
#'   summary statistics
#'
#' @examples
#' sample_data(customers.xlsx, sheet_name='2019', dir='report')

sample_data <- function(file, sheet_name=0, dir='') {
  df <- load_file(file, sheet_name = sheet_name)
  result <- summarize_data(df)
  write.csv(result, paste0(dir, sheet_name, "_summary.csv"))
 }
