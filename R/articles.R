
#' Search for nytimes articles
#'
#' @param q Search query
#' @param section Name of section
#' @param page Page number.
#' @param sort Sort method defaults to newest.
#' @return A tibble with meta data attribute
#' @export
nyt_articles <- function(q = "", section = "us", page = 1, sort = "newest") {
  if (!section %in% nyt_sections$section) {
    stop("not a valid section")
  }
  path <- sprintf("svc/collections/v1/publish/www.nytimes.com/section/%s", section)
  url <- nyt_url(path, q = q, sort = sort, page = page, dom = "www.nytimes.com")
  r <- read_source(url)
  r <- fromjson(r)
  r$body <- purrr::map_chr(r$url, body_text)
  r
}


body_text <- function(url) {
  tryCatch({
    xml2::read_html(url) %>% rvest::html_nodes(".StoryBodyCompanionColumn p") %>%
  rvest::html_text() %>% paste(collapse = "\n")
    }, error = function(e) return(NA_character_))
}

format_datetime <- function(x) {
  adts <- c("created", "add_sort_date", "first_published_iso_timestamp",
    "publication_date")
  adts <- names(x) %in% adts
  cdts <- c("createDate", "updateDate", "approveDate")
  cdts <- names(x) %in% cdts
  if (sum(adts) > 0) {
    x[adts] <- purrr::map(x[adts], ~ as.POSIXct(strptime(.x,
      format = "%Y-%m-%dT%H:%M:%S%z")))
  }
  if (sum(cdts) > 0) {
    x[cdts] <- purrr::map(x[cdts], ~ as.POSIXct(as.numeric(.x),
      origin = "1970-01-01"))
  }
  x
}


