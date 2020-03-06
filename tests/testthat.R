Sys.setenv("R_TESTS" = "")
library(testthat)
library(RDataPeek)

test_check("RDataPeek")
