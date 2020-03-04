test_that("function correctly reads csv file", {
  file_path <- "./test_data/test_df.csv"
  expect_equal(load_file(file_path), read_csv(file_path))
})

test_that("function correctly reads excel file", {
  file_path <- "./test_data/test_df.xlsx"
  expect_equal(load_file(file_path), read_xlsx(file_path))
})

test_that("function raises error for tsv file", {
  file_path <- "./test_data/test_df.tsv"
  expect_error(load_file(file_path))
})
