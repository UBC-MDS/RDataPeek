library(RDataPeek)

# test if the read_file() loads a csv file
test_that("Function should correctly load a csv file", {
  file_path <- "./test_data/test_df.csv"
  expect_equal(read_file(file_path), readr::read_csv(file_path))
})

# test if the read_file() loads an excel file
test_that("Function should correctly load an excel file", {
  file_path <- "./test_data/test_df.xlsx"
  expect_equal(read_file(file_path), readxl::read_xlsx(file_path))
})

# test if the read_file() raises an error correctly
test_that("Function should raise error for tsv file", {
  file_path <- "./test_data/test_df.tsv"
  expect_error(read_file(file_path))
})

#tests is_numeric function
test_that("Function should return False for non-numerical columns.", {
  expect_true(is_numeric(iris, 'Sepal.Length') == TRUE)
  expect_true(is_numeric(iris, 'Species') == FALSE)
})

# tests the type, x- and y-axis for the plot
test_that("Plot should use geom_bar and correctly label the x- and y-axis", {
  p <- make_histogram(iris, 'Sepal.Length')
  expect_true("GeomBar" %in% c(class(p$layers[[1]]$geom)))
  expect_true('Sepal.Length'  == p$labels$x)
  expect_true("Count" == p$labels$y)
})

# tests if the plot explore_w_histograms saved
test_that("Plot should be saved as a png file", {
  file_path <- "./test_data/test_df.csv"
  expected_path <- "./Sepal.Length_chart.png"
  explore_w_histograms(file_path, list('Sepal.Length'))
  expect_true(file.exists(expected_path))
  file.remove("./Sepal.Length_chart.png")
})

# tests if explore_w_histograms function print out messages according to
# the column type
test_that("Non numerical columns shoule generate printed message",{
  file_path <- "./test_data/test_df.csv"
  expect_message(explore_w_histograms(file_path, list('Species')),
                 'Species is not a numerical column. Please enter a numerical column name.', fixed = TRUE)
})
test_that("Numerical columns should generate printed message", {
  file_path <- "./test_data/test_df.csv"
  expect_message(explore_w_histograms(file_path, list('Sepal.Length')),
                 'Sepal.Length_chart.png have saved in your current path.')
})

# test of the dir argument worked
test_that("If dir= argument is used, then it should be contained in filename.", {
  file_path <- "./test_data/test_df.csv"
  expected_path <- "./test_image/Sepal.Length_Chart.png"
  explore_w_histograms(file_path, columns_list = list('Sepal.Length'), dir="./test_image/")
  expect_true(file.exists(expected_path))
  file.remove("./test_image/Sepal.Length_Chart.png")
})