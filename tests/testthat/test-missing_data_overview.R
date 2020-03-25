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

test_that("Plot should use geom_point and correctly label the x- and y-axis", {
  p <- make_plot_1(iris)
  expect_true("GeomRaster" %in% c(class(p$layers[[1]]$geom)))
  expect_true("Column name"  == p$labels$x)
  expect_true("Row number" == p$labels$y)
})

test_that("heatmap is saved as a png file", {
  file_path <- "./test_data/test_df.csv"
  expected_path <- "./test_image/_heatmap.png"
  missing_data_overview(file_path, dir="./test_image/")
  expect_true(file.exists(expected_path))
  file.remove("./test_image/_heatmap.png")
})

test_that("If dir= argument is used, then it should be contained in filename.", {
  file_path <- "./test_data/test_df.csv"
  expected_path <- "./test_image/abc_heatmap.png"
  missing_data_overview(file_path, dir="./test_image/", sheet_name = 'abc')
  expect_true(file.exists(expected_path))
  file.remove("./test_image/abc_heatmap.png")
})