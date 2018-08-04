
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nyt <img src="man/figures/logo.png" width="160px" align="right" />

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

Collecting nytimes data.

## Installation

You can install **{nyt}** from [Github](https://github.com) with:

``` r
devtools::install_github("mkearney/nyt")
```

## `nyt_articles()`

This is a basic example showing how to search for articles from the `US`
section:

``` r
## basic example code
us1 <- nyt_articles(section = "us", page = 1)

## view data
us1
#> # A tibble: 10 x 17
#>    first_published… byline tone  add_sort_date       data_type data_id url   created             uri   summary
#>  * <lgl>            <chr>  <chr> <dttm>              <chr>     <chr>   <chr> <dttm>              <chr> <chr>  
#>  1 NA               By MI… NEWS  2018-08-03 18:22:34 article   100000… http… 2018-08-03 18:22:34 nyt:… The fa…
#>  2 NA               By MA… NEWS  2018-08-03 18:10:40 article   100000… http… 2018-08-03 18:10:40 nyt:… Prosec…
#>  3 NA               By AN… NEWS  2018-08-03 17:55:06 article   100000… http… 2018-08-03 17:55:06 nyt:… No fai…
#>  4 NA               By JO… NEWS  2018-08-03 17:18:09 article   100000… http… 2018-08-03 17:18:09 nyt:… Here’s…
#>  5 NA               By CH… NEWS  2018-08-03 17:11:47 article   100000… http… 2018-08-03 17:11:47 nyt:… The in…
#>  6 NA               By AN… NEWS  2018-08-03 16:49:01 article   100000… http… 2018-08-03 16:49:01 nyt:… The Un…
#>  7 NA               By JU… NEWS  2018-08-03 16:36:10 article   100000… http… 2018-08-03 16:36:10 nyt:… A 187-…
#>  8 NA               By BR… NEWS  2018-08-03 16:14:27 article   100000… http… 2018-08-03 16:14:27 nyt:… At the…
#>  9 NA               By KA… NEWS  2018-08-03 15:26:01 article   100000… http… 2018-08-03 15:26:01 nyt:… Their …
#> 10 NA               By MA… NEWS  2018-08-03 14:12:29 article   100000… http… 2018-08-03 14:12:29 nyt:… The au…
#> # ... with 7 more variables: snippet <chr>, headline <chr>, print_information <lgl>,
#> #   first_published_iso_timestamp <dttm>, kicker <chr>, publication_date <dttm>, body <chr>
```

And here is an example of fetching multiple pages of results from an
article search of the `world` section:

``` r
## get multiple pages
w <- purrr::map(1:3, ~ nyt_articles(section = "world", page = .x))

## merge and view data
dplyr::bind_rows(w)
```

## `nyt_comments()`

This is a basic example showing how to get the user/community comments
associated with an article’s URL:

``` r
## basic example code
c1 <- nyt_comments(us1$url[9])

## view data
c1
```
