#' Helper function used to read the file and return a dataframe.
#' Checks if file type is a .csv or excel. If not, it prints a message and
#' returns NA
#'
#' @param file : str,the path of the file, including the filetype extension
#' @param sheet_name: int, default NULL
#'        if passing an excel file, the name of the sheet to analyze
#' @return data.frame
#'
#' @examples
#' read_file(file = '../test/testthat/test_df.csv')
read_file <- function(file, sheet_name = NULL) {
  df <- tryCatch({
    if (tools::file_ext(file) == "csv") {
      df = readr::read_csv(file)
    }
    else {
      df = readxl::read_xlsx(file, sheet = sheet_name)
    }
  },
  error = function(cond) {
    message("Please use a valid csv or excel file.")
    message(cond)
    return(NA)
  })
  return(df)
}


#'Helper function used to take a dataframe, a column name
#'Returns True if the column is numerical, False otherwise
#'
#' @param df: data.frame
#' @param column: str, the name of the column
#'
#' @return logical: TRUE or FALSE
#'
#' @examples
#' is_numeric(df,'Age')
is_numeric <- function(df, column){
  c_class <- class(dplyr::pull({{df}},{{column}}))

  if (c_class == 'character') {
    return(FALSE)
  } else if (c_class == 'complex'){
    return(FALSE)
  } else if (c_class == 'logical'){
    return(FALSE)
  } else if (c_class == 'factor'){
    return(FALSE)
  } else {
    return(TRUE)
  }
}

#' Helper function used to take a dataframe, a numerical column name,
# and returns a png file of a histogram
#'
#' @param df: data.frame
#' @param column: str, the name of the column
#'
#' @return a histogram of the column
#' @export
#'
#' @examples
#' make_save_histogram(df, 'Age')
make_histogram <- function(df, column){
  plot <- ggplot2::ggplot({{df}},
                          ggplot2::aes(get({{column}})))+
    ggplot2::geom_bar(stat = 'count')+
    ggplot2::labs(title = paste({{column}}, 'Count Overview'),
                  x =({{column}}),
                  y = 'Count')
  return(plot)
}


#' take a csv file path, a sheet name (default NULL),
#' a list of numerical column names
#' and returns a png file of histogram(s)
#'
#' @param file: str, the path of the file, including the filetype extension
#' @param columns_list: a list of numerical column names as string
#' @param sheet_name: int, default NULL
#'        if passing an excel file, the name of the sheet to analyze
#'
#' @return printed messages
#' @export
#'
#' @examples
#' explore_w_histograms('../test/testthat/test_df.csv', list('Sepal.Length'))
explore_w_histograms <- function(file, columns_list, sheet_name = NULL){
  df <- read_file({{file}}, {{sheet_name}})
  for (col in {{columns_list}}){
    if (is_numeric(df, col) == TRUE){
      make_histogram(df, col)
      ggplot2::ggsave(paste0(col,'_chart.png'))
      message(paste0(col,'_chart.png have saved in your current path.'))
    } else{
      message(paste(col,'is not a numerical column. Please enter a numerical column name.'))
    }
  }

}


