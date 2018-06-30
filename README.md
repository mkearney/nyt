
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
#>    first_published_iso… first_published_… byline    tone  add_sort_date       data_type data_id url          
#>  * <dttm>               <lgl>             <chr>     <chr> <dttm>              <chr>     <chr>   <chr>        
#>  1 2018-06-29 16:47:10  NA                By CORNE… NEWS  2018-06-29 16:47:10 article   100000… https://www.…
#>  2 2018-06-29 16:23:46  NA                By LINDA… NEWS  2018-06-29 16:23:46 article   100000… https://www.…
#>  3 2018-06-29 15:26:10  NA                By MIHIR… NEWS  2018-06-29 15:26:10 article   100000… https://www.…
#>  4 2018-06-29 14:47:12  NA                By NIRAJ… NEWS  2018-06-29 14:47:12 article   100000… https://www.…
#>  5 2018-06-29 14:34:53  NA                By MICHA… NEWS  2018-06-29 14:34:53 article   100000… https://www.…
#>  6 2018-06-29 14:07:59  NA                By KAREN… FEAT… 2018-06-29 14:07:59 article   100000… https://www.…
#>  7 2018-06-29 13:15:00  NA                By SYDNE… NEWS  2018-06-29 13:15:00 article   100000… https://www.…
#>  8 2018-06-29 12:26:15  NA                By MARK … NEWS  2018-06-29 12:26:15 article   100000… https://www.…
#>  9 2018-06-29 12:00:03  NA                By KATE … FEAT… 2018-06-29 12:00:03 article   100000… https://www.…
#> 10 2018-06-29 11:55:45  NA                By SABRI… NEWS  2018-06-29 11:55:45 article   100000… https://www.…
#> # ... with 9 more variables: created <dttm>, uri <chr>, summary <chr>, snippet <chr>, headline <chr>,
#> #   print_information <lgl>, kicker <chr>, publication_date <dttm>, body <chr>
```

And here is an example of fetching multiple pages of results from an
article search of the `world` section:

``` r
## get multiple pages
w <- purrr::map(1:3, ~ nyt_articles(section = "world", page = .x))

## merge and view data
dplyr::bind_rows(w)
#> # A tibble: 30 x 17
#>    first_published_… byline   tone  add_sort_date       data_type data_id url      created             uri   
#>    <lgl>             <chr>    <chr> <dttm>              <chr>     <chr>   <chr>    <dttm>              <chr> 
#>  1 NA                By STEP… NEWS  2018-06-29 12:33:31 article   100000… https:/… 2018-06-29 12:33:31 nyt:/…
#>  2 NA                By MICH… NEWS  2018-06-29 11:37:31 article   100000… https:/… 2018-06-29 11:37:31 nyt:/…
#>  3 NA                By AMIE… NEWS  2018-06-29 10:55:32 article   100000… https:/… 2018-06-29 10:55:32 nyt:/…
#>  4 NA                By TIFF… NEWS  2018-06-29 10:45:19 article   100000… https:/… 2018-06-29 10:45:19 nyt:/…
#>  5 NA                By KEIT… NEWS  2018-06-29 10:18:41 article   100000… https:/… 2018-06-29 10:18:41 nyt:/…
#>  6 NA                By AMIE… NEWS  2018-06-29 09:44:42 article   100000… https:/… 2018-06-29 09:44:42 nyt:/…
#>  7 NA                By NICK… NEWS  2018-06-29 09:20:46 article   100000… https:/… 2018-06-29 09:20:46 nyt:/…
#>  8 NA                By CATH… NEWS  2018-06-29 09:04:05 article   100000… https:/… 2018-06-29 09:04:05 nyt:/…
#>  9 NA                By RICH… NEWS  2018-06-29 08:18:54 article   100000… https:/… 2018-06-29 08:18:54 nyt:/…
#> 10 NA                By DAVI… NEWS  2018-06-29 07:11:52 article   100000… https:/… 2018-06-29 07:11:52 nyt:/…
#> # ... with 20 more rows, and 8 more variables: summary <chr>, snippet <chr>, headline <chr>,
#> #   print_information <lgl>, first_published_iso_timestamp <dttm>, kicker <chr>, publication_date <dttm>,
#> #   body <chr>
```

## `nyt_comments()`

This is a basic example showing how to get the user/community comments
associated with an article’s URL:

``` r
## basic example code
c1 <- nyt_comments(us1$url[9])
#> Found 22 comments

## view data
c1
#> # A tibble: 22 x 27
#>    commentID status   commentSequence userID   userDisplayName userLocation  userTitle userURL commentTitle
#>    <chr>     <chr>              <int> <chr>    <chr>           <chr>         <chr>     <chr>   <chr>       
#>  1 27683986  approved        27683986 71585387 Chen            Queens, NY    <NA>      <NA>    <br/>       
#>  2 27683688  approved        27683688 73928952 Matt            CT            <NA>      <NA>    <br/>       
#>  3 27683660  approved        27683660 70396187 Crusader Rabbit Tucson, AZ    <NA>      <NA>    <br/>       
#>  4 27682894  approved        27682894 65675602 Barbara         Boston        <NA>      <NA>    <br/>       
#>  5 27682898  approved        27682898 50645359 JLC             Seattle       <NA>      <NA>    <br/>       
#>  6 27683102  approved        27683102 65473398 ms              ca            <NA>      <NA>    <br/>       
#>  7 27682013  approved        27682013 46948836 Mike Livingston Cheltenham PA <NA>      <NA>    <br/>       
#>  8 27682532  approved        27682532 63298300 rf              Las Cruces,NM <NA>      <NA>    <br/>       
#>  9 27682582  approved        27682582 23816590 marrtyy         manhattan     <NA>      <NA>    <br/>       
#> 10 27682575  approved        27682575 68938663 Marge Keller    Midwest       <NA>      <NA>    <br/>       
#> # ... with 12 more rows, and 18 more variables: commentBody <chr>, createDate <dttm>, updateDate <dttm>,
#> #   approveDate <dttm>, recommendations <int>, replyCount <int>, editorsSelection <lgl>, parentID <chr>,
#> #   parentUserDisplayName <chr>, depth <int>, commentType <chr>, trusted <int>, recommendedFlag <lgl>,
#> #   reportAbuseFlag <lgl>, permID <chr>, picURL <chr>, timespeople <int>, sharing <int>
```
