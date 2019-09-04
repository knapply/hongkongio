#' Combine the 9 separate `hkio_tweets_df*` `data.tables` into 1.
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
  rbindlist(
    list(hkio_tweets_df1, hkio_tweets_df2, hkio_tweets_df3, hkio_tweets_df4,
         hkio_tweets_df5, hkio_tweets_df6, hkio_tweets_df7, hkio_tweets_df8,
         hkio_tweets_df9)
  )
}