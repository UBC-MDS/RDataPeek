#'Return an image of a word bubble of qualitative responses (text)
#'from a column(s) from a spreadsheet.
#'
#' @param file the name of the file, including the filetype extension
#' @param sheet_name if passing an excel file, the name of the sheet to analyze, by default 0
#' @param dir the directory where the file should be saved, by default ''
#' @param column A string or vector of the columns header that are to be included in the word bubble '
#' @param height the height of the outputted image, default = 8 inches
#' @param width the width of the outputted image, default = 8 inches
#' @param max number of words in the word bubble, default = 50 words
#'
#' @return returns an image of a word bubble by specified width and height and includes max number of words.
#'
#' @examples
#' sample_data(customers.xlsx, sheet_name='2019', dir='report', column='review', max=50, height=7, width=7)

word_bubble <- function(file, sheet_name=0, dir='', max=50, height=8, width=8) {

}
