# Information operations directed at Hong Kong
# https://blog.twitter.com/en_us/topics/company/2019/information_operations_directed_at_Hong_Kong.html

library(data.table)
library(stringi)

recode_col_names <- function(df) {
  cols_kv <- c(
    status_id = "tweetid",
    user_id = "userid",
    name = "user_display_name",
    screen_name = "user_screen_name",
    location = "user_reported_location",
    description = "user_profile_description",
    profile_url = "user_profile_url",
    followers_count = "follower_count",
    following_count = "following_count",
    account_created_at = "account_creation_date",
    account_lang = "account_language",
    lang = "tweet_language",
    text = "tweet_text",
    created_at = "tweet_time",
    source = "tweet_client_name",
    reply_to_user_id = "in_reply_to_userid",
    reply_to_status_id = "in_reply_to_tweetid",
    quoted_status_id = "quoted_tweet_tweetid",
    is_retweet = "is_retweet",
    retweet_user_id = "retweet_userid",
    retweet_status_id = "retweet_tweetid",
    latitude = "latitude",
    longitude = "longitude",
    quote_count = "quote_count",
    reply_count = "reply_count",
    like_count = "like_count",
    retweet_count = "retweet_count",
    hashtags = "hashtags",
    urls_url = "urls",
    mentions_user_id = "user_mentions",
    poll_choices = "poll_choices"
  )
  
  target_cols <- cols_kv[cols_kv %chin% names(df)]
  if (length(target_cols) > 1L) {
    setnames(df, old = target_cols, new = names(target_cols))
  }
  
  df[]
}

clean_list_cols <- function(x) {
  init <- stri_replace_all_regex(x, pattern = "'|\\[|\\]", replacement = "")
  init[init == ""] <- NA_character_
  stri_split_fixed(init, pattern = ",")
}

dload_unzip_read_clean <- function(urls, .pattern) {
  temp_dir <- tempdir(check = TRUE)
  temp_file <- tempfile()
  
  for (i in seq_along(urls)) {
    download.file(url = urls[[i]], destfile = temp_file)
    unzip(temp_file, exdir = temp_dir)
  }
  
  target_files <- unique(
    dir(temp_dir, pattern = .pattern, full.names = TRUE)
  )
  
  out <- unique(
    rbindlist(
      lapply(target_files, fread, encoding = "UTF-8")
    )
  )
  
  if ("account_creation_date" %chin% names(out)) {
    out[, account_creation_date := as.Date(account_creation_date)]
  }

  if ("tweet_time" %chin% names(out)) {
    out[, tweet_time := as.POSIXct(tweet_time)]
  }
  
  list_cols <- intersect(names(out), c("hashtags", "user_mentions", "urls"))
  if (length(list_cols) > 0L) {
    out[, (list_cols) := lapply(.SD, clean_list_cols), .SDcols = list_cols]
  }
  
  chr_cols <- names(out)[vapply(out, is.character, logical(1L))]
  out[, (chr_cols) := lapply(.SD, function(.x) {
    .x[.x == ""] <- NA_character_
    .x
    }), .SDcols = chr_cols]
  
  # corresponding to "id_str" to match rtweet schema
  int64_cols <- names(out)[vapply(out, inherits, logical(1L), "integer64")]
  if (length(int64_cols) > 0L) {
    out[, (int64_cols) := lapply(.SD, as.character), .SDcols = int64_cols]
  }
  
  recode_col_names(out)[]
}


user_urls <- c(
  "https://storage.googleapis.com/twitter-election-integrity/hashed/china_082019_1/china_082019_1_users_csv_hashed.zip",
  "https://storage.googleapis.com/twitter-election-integrity/hashed/china_082019_2/china_082019_2_users_csv_hashed.zip"
)

tweet_urls <- c(
  "https://storage.googleapis.com/twitter-election-integrity/hashed/china_082019_1/china_082019_1_tweets_csv_hashed.zip",
  "https://storage.googleapis.com/twitter-election-integrity/hashed/china_082019_2/china_082019_2_tweets_csv_hashed.zip"
)


hkio_users_df <- dload_unzip_read_clean(
  user_urls, .pattern = "china_082019_\\d_users_csv_hashed"
)


hkio_tweets_df <- dload_unzip_read_clean(
  tweet_urls, .pattern = "china_082019_\\d_tweets_csv_hashed"
)

row_seqs <- split(1:nrow(hkio_tweets_df), sort(1:nrow(hkio_tweets_df) %% 9))

hkio_tweets_df1 <- hkio_tweets_df[row_seqs[[1L]]]
hkio_tweets_df2 <- hkio_tweets_df[row_seqs[[2L]]]
hkio_tweets_df3 <- hkio_tweets_df[row_seqs[[3L]]]
hkio_tweets_df4 <- hkio_tweets_df[row_seqs[[4L]]]
hkio_tweets_df5 <- hkio_tweets_df[row_seqs[[5L]]]
hkio_tweets_df6 <- hkio_tweets_df[row_seqs[[6L]]]
hkio_tweets_df7 <- hkio_tweets_df[row_seqs[[7L]]]
hkio_tweets_df8 <- hkio_tweets_df[row_seqs[[8L]]]
hkio_tweets_df9 <- hkio_tweets_df[row_seqs[[9L]]]

usethis::use_data(hkio_users_df, overwrite = TRUE)
usethis::use_data(hkio_tweets_df1, overwrite = TRUE)
usethis::use_data(hkio_tweets_df2, overwrite = TRUE)
usethis::use_data(hkio_tweets_df3, overwrite = TRUE)
usethis::use_data(hkio_tweets_df4, overwrite = TRUE)
usethis::use_data(hkio_tweets_df5, overwrite = TRUE)
usethis::use_data(hkio_tweets_df6, overwrite = TRUE)
usethis::use_data(hkio_tweets_df7, overwrite = TRUE)
usethis::use_data(hkio_tweets_df8, overwrite = TRUE)
usethis::use_data(hkio_tweets_df9, overwrite = TRUE)
