library(RDataPeek)

#Test that the csv loads correct
test_that("Function should correctly load a csv file", {
  file_path <- "./test_data/test_movie.csv"
  expect_equal(load_file(file_path), readr::read_csv(file_path))
})

#Test that the xlsx loads correct
test_that("Function should correctly load a excel file", {
  file_path <- "./test_data/test_movie.xlsx"
  expect_equal(load_file(file_path), readxl::read_xlsx(file_path))
})

#Test that the wrong extention will cause it fail
test_that("Function should raise error for tsv file", {
  file_path <- "./test_data/test_df.tsv"
  expect_error(load_file(file_path))
})

#Test in the test data movie is used 219 times
test_that("The corpus is transforming the data correctly", {
  file_path <- "./test_data/test_movie.csv"
  df <- load_file(file_path)
  corpus <- process_corpus(df)
  expect_equal(corpus[[1]], 219)
})

#Test that it is producing the correct image using the .csv
test_that("If dir= argument is used, then it should be contained in filename.", {
  file_path <- "test_data/test_movie.csv"
  expected_path <- "test_image/wordcloud.png"
  word_bubble(file_path, dir="test_image/wordcloud.png", column='review')
  expect_true(file.exists(expected_path))
  file.remove("test_image/wordcloud.png")
})

#Test that it is producing the correct image using the .xlsx
test_that("If dir= argument is used, then it should be contained in filename.", {
  file_path <- "test_data/test_movie.xlsx"
  expected_path <- "test_image/wordcloud.png"
  word_bubble(file_path, dir="test_image/wordcloud.png", sheet_name = "0", column='review')
  expect_true(file.exists(expected_path))
  file.remove("test_image/wordcloud.png")
})
