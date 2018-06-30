
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nyt

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
#>    first_published_… byline    tone  add_sort_date       data_type data_id
#>  * <lgl>             <chr>     <chr> <dttm>              <chr>     <chr>  
#>  1 NA                By CORNE… NEWS  2018-06-29 16:47:10 article   100000…
#>  2 NA                By LINDA… NEWS  2018-06-29 16:23:46 article   100000…
#>  3 NA                By MIHIR… NEWS  2018-06-29 15:26:10 article   100000…
#>  4 NA                By NIRAJ… NEWS  2018-06-29 14:47:12 article   100000…
#>  5 NA                By MICHA… NEWS  2018-06-29 14:34:53 article   100000…
#>  6 NA                By KAREN… FEAT… 2018-06-29 14:07:59 article   100000…
#>  7 NA                By SYDNE… NEWS  2018-06-29 13:15:00 article   100000…
#>  8 NA                By MARK … NEWS  2018-06-29 12:26:15 article   100000…
#>  9 NA                By KATE … FEAT… 2018-06-29 12:00:03 article   100000…
#> 10 NA                By SABRI… NEWS  2018-06-29 11:55:45 article   100000…
#> # ... with 11 more variables: url <chr>, created <dttm>, uri <chr>,
#> #   summary <chr>, snippet <chr>, headline <chr>, print_information <lgl>,
#> #   first_published_iso_timestamp <dttm>, kicker <chr>,
#> #   publication_date <dttm>, body <chr>

## get multiple pages
w <- purrr::map(1:3, ~ nyt_articles(section = "world", page = .x))

## merge and view data
dplyr::bind_rows(w)
#> # A tibble: 30 x 17
#>    first_published_… byline    tone  add_sort_date       data_type data_id
#>    <lgl>             <chr>     <chr> <dttm>              <chr>     <chr>  
#>  1 NA                By STEPH… NEWS  2018-06-29 12:33:31 article   100000…
#>  2 NA                By MICHA… NEWS  2018-06-29 11:37:31 article   100000…
#>  3 NA                By AMIE … NEWS  2018-06-29 10:55:32 article   100000…
#>  4 NA                By TIFFA… NEWS  2018-06-29 10:45:19 article   100000…
#>  5 NA                By KEITH… NEWS  2018-06-29 10:18:41 article   100000…
#>  6 NA                By AMIE … NEWS  2018-06-29 09:44:42 article   100000…
#>  7 NA                By NICK … NEWS  2018-06-29 09:20:46 article   100000…
#>  8 NA                By CATHE… NEWS  2018-06-29 09:04:05 article   100000…
#>  9 NA                By RICHA… NEWS  2018-06-29 08:18:54 article   100000…
#> 10 NA                By DAVID… NEWS  2018-06-29 07:11:52 article   100000…
#> # ... with 20 more rows, and 11 more variables: url <chr>, created <dttm>,
#> #   uri <chr>, summary <chr>, snippet <chr>, headline <chr>,
#> #   print_information <lgl>, first_published_iso_timestamp <dttm>,
#> #   kicker <chr>, publication_date <dttm>, body <chr>
```

## `nyt_comments()`

This is a basic example showing how to search for comments associated
with an article’s URL:

``` r
## basic example code
c1 <- nyt_comments(us1$url[9])
#> Found 22 comments

## view data
c1
#> # A tibble: 22 x 27
#>    commentID status   commentSequence userID  userDisplayName userLocation
#>    <chr>     <chr>              <int> <chr>   <chr>           <chr>       
#>  1 27683986  approved        27683986 715853… Chen            Queens, NY  
#>  2 27683688  approved        27683688 739289… Matt            CT          
#>  3 27683660  approved        27683660 703961… Crusader Rabbit Tucson, AZ  
#>  4 27682894  approved        27682894 656756… Barbara         Boston      
#>  5 27682898  approved        27682898 506453… JLC             Seattle     
#>  6 27683102  approved        27683102 654733… ms              ca          
#>  7 27682013  approved        27682013 469488… Mike Livingston Cheltenham …
#>  8 27682532  approved        27682532 632983… rf              Las Cruces,…
#>  9 27682582  approved        27682582 238165… marrtyy         manhattan   
#> 10 27682575  approved        27682575 689386… Marge Keller    Midwest     
#> # ... with 12 more rows, and 21 more variables: userTitle <chr>,
#> #   userURL <chr>, commentTitle <chr>, commentBody <chr>,
#> #   createDate <dttm>, updateDate <dttm>, approveDate <dttm>,
#> #   recommendations <int>, replyCount <int>, editorsSelection <lgl>,
#> #   parentID <chr>, parentUserDisplayName <chr>, depth <int>,
#> #   commentType <chr>, trusted <int>, recommendedFlag <lgl>,
#> #   reportAbuseFlag <lgl>, permID <chr>, picURL <chr>, timespeople <int>,
#> #   sharing <int>
```
