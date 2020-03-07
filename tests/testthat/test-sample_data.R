library(RDataPeek)

# testing load_file helper function
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

# load in data dataframe and summarize data as setup for testing summarize_data helper function
file_path <- "./test_data/test_df.csv"
df <- load_file(file_path)
result <- summarize_data(df)

test_that("summarize_data outputs a dataframe", {
  expect_true(is.data.frame(result))
})

test_that("summarize_data has correct column names", {
  df_value <- colnames(df)
  result_value <- dplyr::pull(result['columns'])
  expect_equal(df_value, result_value)
})

test_that("summarize_data has correct sample record", {
  df_value <- as.data.frame(t(dplyr::slice(df, 1)))
  result_value <- result['sample_record']
  expect_equivalent(df_value, result_value)
})

test_that("summarize_data has correct data types", {
  df_value <- as.data.frame(sapply(df, class), stringsAsFactors = FALSE)
  result_value <- result['data_type']
  expect_equivalent(df_value, result_value)
})

test_that("summarize_data summarizes mean for numeric data", {
  # compute from data
  stat <- round(mean(dplyr::pull(df['Sepal.Length']), na.rm = TRUE), 2)
  df_value <- paste("Mean value is: ", stat)
  # compute from result
  result_value <- dplyr::pull(dplyr::slice(result['summary'], 1))
  # test
  expect_equal(df_value, result_value)
})

test_that("summarize_data summarizes unique values for character data", {
  # compute from data
  stat <- nrow(unique(df[column]))
  df_value <- paste("Number of unique values is:", stat)
  # compute from result
  result_value <- dplyr::pull(dplyr::slice(result['summary'], 5))
  # test
  expect_equal(df_value, result_value)
})

test_that("summarize_data doesn't produce summary for non-numerical and non-character data", {
  # create sample data with factor
  factor_data <- as.data.frame(factor(c("single", "married", "married", "single")))
  example <- summarize_data(factor_data)
  # compute from result
  result_value <- dplyr::pull(dplyr::slice(example['summary'], 1))
  # test
  expect_equal('No summary available', result_value)
})
