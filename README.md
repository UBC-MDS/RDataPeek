# RDataPeek

<!-- badges: start -->

<!-- badges: end -->

## Project Proposal
As data scientists, we are expected to orient business users to the datasets we are analyzing in a way that is accessible and easy to understand. This process is the first step to building trust in the analysis.

RDataPeek is a package that enables data scientists to efficiently generate a visual summary of a dataset. This package includes functions that show the size of the dataset, a visual summary of missing data, a sample of the dataset showing the data types as well as exploratory visualizations for quantitative and qualitative data.

This package is also useful for business users who have to interact with data and want to begin exploring the data without using too much code or having to open a potentially large dataset on Excel. 

### Functions in this package
All functions take in csv or Excel files as inputs to generate a user-friendly output of the data.
1. **missing_data_overview**: Returns a visualization of the data where missing values are highlighted and the number of rows and columns are visually displayed.
2. **sample_data**: Returns a dataframe that displays the column names as rows, an example of one row, the data type of each column and summary statistics for each column depending on the data type. Quantitative measures will be summarized with a range, categorical values (i.e., less than 20 unique values) will be summarized by displaying the unique values, long form text data will be summarized with the average length of the response. 
3. **explore_with_histograms**: Returns histograms that shows the distribution of responses for given column(s). 
4. **explore_with_word_bubble**: Returns a word bubble visualization for text data given column name.

### How this fits in the R ecosystem
- [Base R's `summary()`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/summary): ...
- [R ggplot2](https://ggplot2.tidyverse.org): [Missing data visualizations](https://cran.r-project.org/web/packages/naniar/vignettes/naniar-visualisation.html)
- [R Word Cloud](https://cran.r-project.org/web/packages/wordcloud/wordcloud.pdf): ... 

## Installation
This project is under development! Upon release, you can install the released version of RDataPeek from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("RDataPeek")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/RDataPeek")
```
