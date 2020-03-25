#' Helper function to read the file and return a dataframe.
#'
#' Checks if file is type .csv or excel. If not, return an error.
#'
#' @param file the name of the file, including the path and filetype extension
#' @param sheet_name if passing an excel file, the name of the sheet to analyze (default = NULL)
#'
#' @return dataframe
#' @noRd
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
#' @noRd
process_corpus <- function(df){
  corpus <- tm::Corpus(tm::VectorSource({{df}}))
  corpus <- tm::tm_map(corpus, tm::removePunctuation)
  corpus <- tm::tm_map(corpus, tm::removeNumbers)
  corpus <- tm::tm_map(corpus, tm::stripWhitespace)
  corpus <- tm::tm_map(corpus, tolower)
  corpus <- tm::tm_map(corpus, tm::removeWords, tm::stopwords("english"))

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
#' @noRd
make_plot <- function(freq, dir, max, height, width){
  grDevices::png({{dir}}, width={{height}},height={{width}})
  wordcloud::wordcloud(words=names(freq), freq=freq, max.words = {{max}}, random.order = FALSE, scale = c(8,.2))
  grDevices::dev.off()
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
#' @export
#'
#' @examples
word_bubble <- function(file="", sheet_name=0, dir="", column='', max=50, height=1000, width=1000) {
  #adapted from: https://rpubs.com/collnell/wordcloud

  #read and wrangle
  df <- load_file(file={{file}}, sheet_name = {{sheet_name}})
  df <- df %>% dplyr::select({{column}})

  #initialize corpus

  freq <- process_corpus(df)

  #make png
  make_plot(freq, {{dir}}, {{max}}, {{height}}, {{width}})

}


