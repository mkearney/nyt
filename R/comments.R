
#' Get reader comments
#'
#' @param url URL of news story
#' @param cmd Type of comments to return, defaults to all.
#' @param sort Sort method
#' @return Data
#' @export
nyt_comments <- function(url, cmd = "GetCommentsAll", sort = "newest", offset = 0) {
  r <- nyt_comments_(url, cmd, sort, offset)
  n <- attr(r, "meta")$totalCommentsFound
  p <- ceiling(n / 25) - 1
  cat("Found", attr(r, "meta")$totalCommentsFound, "comments", fill = TRUE)
  df <- vector("list", p)
  for (i in seq_len(p)) {
    offset <- offset + 25
    df[[i]] <- nyt_comments_(url, cmd, sort, offset)
  }
  df <- do.call("rbind", df[purrr::map_lgl(df, ~ nrow(.x) > 0)])
  do.call("rbind", list(r, df))
}

nyt_comments_ <- function(url, cmd = "GetCommentsAll", sort = "newest", offset = 0) {
  path <- "svc/community/V3/requestHandler"
  if (!cmd %in% c("GetCommentsAll", "GetCommentsNYTPicks", "GetCommentsReadersPicks")) {
    stop("invalid cmd. must be GetCommentsAll, GetCommentsNYTPicks, or ",
      "GetCommentsReadersPicks")
  }
  url <- URLencode(url, reserved = TRUE)
  url <- nyt_url(path, url = url, method = "get", commentSequence = "0",
    offset = offset, sort = sort, cmd = cmd)
  r <- read_source(url)
  fromjson(r)
}
