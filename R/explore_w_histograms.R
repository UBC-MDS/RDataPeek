#' Helper function used to read the file and return a pandas dataframe.
#' Checks if file type is a .csv or excel. If not, returns a ValueError.
#'
#'
#' @param file : str,the name of the file, including the filetype extension
#' @param sheet_name: int, default NULL
#'        if passing an excel file, the name of the sheet to analyze
#' @return data.frame
#'
#' @examples
#' read_file(file = 'toy_dataset.csv')
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


is_numeric <- function(df, column){
  c_class <- class({{df}} %>% pull({{column}}))

  if (c_class == 'character') {
    return(FALSE)
  } else if (c_class == 'complex'){
    return(FALSE)
  } else if (c_class == 'logical'){
    return(FALSE)
  } else {
    return(TRUE)
  }
}

make_histogram <- function(df, column){
  plot <- ggplot({{df}},
                 aes(get({{column}})))+geom_bar(stat = 'count')
  ggsave(paste({{column}}, '_chart.png'))
}

explore_w_histograms <- function(file, columns_list, sheet_name = NULL){
  df <- read_file({{file}}, {{sheet_name}})
  for (col in {{columns_list}}){
    if (is_numeric(df, col) == TRUE){
      make_histogram(df, col)
    } else{
      print(paste(col, 'is not a numerical column. Please enter a numerical column name.'))
    }
  }

}


