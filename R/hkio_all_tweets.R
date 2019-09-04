#' @rdname  hkio
#' 
#' @return `data.table`
#' 
#' @template bknapp-author
#' 
#' @examples
#' all_tweets <- hkio_all_tweets()
#' 
#' @export
#' 
#' @importFrom data.table rbindlist
hkio_all_tweets <- function() {
  target_paths <- system.file(
    c("extdata/hkio_tweets_df1.rds", "extdata/hkio_tweets_df2.rds",
      "extdata/hkio_tweets_df3.rds", "extdata/hkio_tweets_df4.rds",
      "extdata/hkio_tweets_df5.rds", "extdata/hkio_tweets_df6.rds",
      "extdata/hkio_tweets_df7.rds", "extdata/hkio_tweets_df8.rds",
      "extdata/hkio_tweets_df9.rds"),
    package = "hongkongio",
    mustWork = TRUE
  )
  
  rbindlist(
    lapply(target_paths, readRDS)
  )
}
