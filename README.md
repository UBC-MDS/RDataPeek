# RDataPeek

<!-- badges: start -->

<!-- badges: end -->

## Project Proposal
Data scientists are expected to orient business users to the datasets by analyzing in a way that is accessible and easy to understand. This process is the first step to building trust in the analysis.

RDataPeek is a package that enables data scientists to efficiently generate a visual summary of a dataset. This package includes functions that show the size of the dataset, a visual summary of missing data, a sample of the dataset showing the data types as well as exploratory visualizations for quantitative and qualitative data.

This package is also useful for business users who have to interact with data and want to begin exploring the data without using too much code or having to open a potentially large dataset on Excel. 

### Functions in this package
All functions take in csv or Excel files as inputs to generate user-friendly summaries of the ingested dataset.
1. **missing_data_overview**: Returns a visualization of the data where missing values are highlighted and the number of rows and columns are visually displayed. A heatmap will be used here to highlight the missing values so it's easy for users to have an overview of which part is missing in the data.
2. **sample_data**: Returns a dataframe that displays the column names as rows, an example of one row, the data type of each column and summary statistics for each column depending on the data type. Integer data is summarized with number of unique values, text data is summarized with average length of string and float data is summarized with the median of the values.
3. **explore_with_histograms**: Returns saved png files of histograms that shows the distribution of responses for given columns. The given list of numerical columns can be chosen by user.
4. **explore_with_word_bubble**: Returns a saved word bubble visualization for text data given column name. This would allow users to know what are the most frequently used words for each column in a short time.

### How this fits in the R ecosystem
Several R packages and functions are available that support exploratory data analysis but none are specific to the targeted use cases here - a simple and technologically friendly way of summarizing data.
- [Base R's `summary()`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/summary): This function computes summary statistics for R dataframes. Our package differs in that it aims to offer summary statistics dependent on data type, including long form text data.
- [R ggplot2](https://ggplot2.tidyverse.org): Our package will leverage `ggplot2` to create visualizations that summarize the dataset as well as user-defined features in the dataset. There are existing recommended visualizations for exploratory data analysis such as [missing data visualizations](https://cran.r-project.org/web/packages/naniar/vignettes/naniar-visualisation.html) which will be adapted where appropriate.
- [R Word Cloud](https://cran.r-project.org/web/packages/wordcloud/wordcloud.pdf): This package will also be used to create summary visualizations for long form text data.  

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
