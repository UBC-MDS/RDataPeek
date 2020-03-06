library(RDataPeek)

test_that("Function should correctly load a csv file", {
  file_path <- "./test_data/test_df.csv"
  expect_equal(load_file(file_path), readr::read_csv(file_path))
})

test_that("Function should correctly load a excel file", {
  file_path <- "./test_data/test_df.xlsx"
  expect_equal(load_file(file_path), readxl::read_xlsx(file_path))
})

test_that("Function should raise error for tsv file", {
  file_path <- "./test_data/test_df.tsv"
  expect_error(load_file(file_path))
})