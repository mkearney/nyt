as_tbl <- function(x) {
  tibble::as_tibble(x[!purrr::map_lgl(x, is.recursive)], validate = FALSE)
}
read_source <- function(x) {
  x <- httr::GET(x)
  httr::content(x, as = "text", encoding = "UTF-8")
}

fromjson <- function(x) {
  x <- tryCatch(jsonlite::fromJSON(x), error = function(e) return(NULL))
  if (is.null(x)) return(NULL)
  if (is.list(x) && length(x) == 1) {
    x <- x[[1]]
  } else if ("members" %in% names(x)) {
    df <- as_tbl(x$members$items)
    x$members$items <- NULL
    df <- format_datetime(df)
    attr(df, "meta") <- x
    return(df)
  } else if ("results" %in% names(x)) {
    df <- parse_comments(x$results)
    meta <- attr(df, "meta")
    df <- parse_replies(x$results$comments, df)
    attr(df, "meta") <- meta
    return(df)
  }
  tryCatch(as_tbl(x), error = function(e) return(x))
}


parse_comments <- function(x) {
  if ("comments" %in% names(x)) {
    df <- as_tbl(x$comments)
    att <- x
    x <- x$comments
    att$comments <- NULL
  } else {
    df <- data.frame()
    att <- NULL
  }
  r2 <- parse_replies(x, df)
  r3 <- do.call("rbind", purrr::map(x$replies, parse_replies, df))
  df <- unique(rbind(r2, r3))
  df <- format_datetime(df)
  ids <- grep("ID$", names(df))
  df[ids] <- purrr::map(df[ids], as.character)
  df[purrr::map_lgl(df, is.character)] <- purrr::map(df[purrr::map_lgl(df, is.character)],
    ~ ifelse(.x == "NULL", NA_character_, .x))
  if (!is.null(att)) {
    attr(df, "meta") <- att
  }
  df
}

parse_replies <- function(x, df) {
  if ("replies" %in% names(x)) {
    replies <- purrr::map(x$replies, as_tbl)
    replies <- do.call("rbind", replies)
    replies <- format_datetime(replies)
    ids <- grep("ID$", names(replies))
    replies[ids] <- purrr::map(replies[ids], as.character)
    replies[purrr::map_lgl(replies, is.character)] <- purrr::map(replies[purrr::map_lgl(replies, is.character)],
      ~ ifelse(.x == "NULL", NA_character_, .x))
    unique(rbind(df, replies))
  } else {
    df
  }
}

