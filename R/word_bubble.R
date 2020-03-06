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

#' Helper function to read the file and return a dataframe.
#'
#' @param df dataframe of the text column
#'
#' @return formated corpus with frequencys of each word
#'
#' @examples
process_corpus <- function(df){
  corpus <- tm::Corpus(tm::VectorSource({{df}}))
  corpus <- corpus %>%
    tm::tm_map(removePunctuation) %>%
    tm::tm_map(removeNumbers) %>%
    tm::tm_map(stripWhitespace) %>%
    tm::tm_map(tolower) %>%
    tm::tm_map(removeWords, stopwords("english"))
  
  counts<-as.matrix(tm::TermDocumentMatrix(corpus))
  freq<-sort(rowSums(counts), decreasing=TRUE)
}

#' Helper function to process the corpus into a form that word cloud can use.
#'
#' @param freq frequency of the words from the output of the process corpus function
#' @param dir the directory where the file should be saved, default = ''
#' @param max number of words in the word bubble, default = Inf words
#' @param height the height of the outputted image
#' @param width the width of the outputted image
#'
#' @return
#' @export
#'
#' @examples
make_plot <- function(freq, dir, max, height, width){
  png({{dir}}, width={{height}},height={{width}})
  wordcloud::wordcloud(words=names(freq), freq=freq, max.words = {{max}}, random.order = FALSE, scale = c(8,.2))
  dev.off()
}

#'Return an image of a word bubble of qualitative responses (text)
#'from a column(s) from a spreadsheet.
#'
#' @param file the name of the file, including the filetype extension
#' @param sheet_name if passing an excel file, the name of the sheet to analyze, default =  0
#' @param dir the directory where the file should be saved, default = ''
#' @param column A string or vector of the columns header that are to be included in the word bubble, default = ''
#' @param max number of words in the word bubble, default = Inf words
#' @param height the height of the outputted image, default = 600 pixals
#' @param width the width of the outputted image, default = 800 pixals
#'
#'
#' @return returns an image of a word bubble by specified width and height and includes max number of words.
#'
#' @examples
#' sample_data(customers.xlsx, sheet_name='2019', dir='report', column='review', max=50, height=7, width=7)
word_bubble <- function(file="imdb_sample.csv", sheet_name=0, dir="wordcloud.png", column='review', max=50, height=1000, width=1000) {
  #adapted from: https://rpubs.com/collnell/wordcloud
  
  usethis::use_pipe
  
  #read and wrangle
  df <- load_file(file={{file}}, sheet_name = {{sheet_name}})
  df <- df %>% dplyr::select({{column}})
  
  #initialize corpus
  
  freq <- process_corpus(df)
  
  #make png
  make_plot(freq, {{dir}}, {{max}}, {{height}}, {{width}})
  
}



