
<!-- README.Rmd generates README.md. -->

## Installation

``` r
# install.packages("remotes")
remotes::install_github("knapply/hongkongio")
```

## Data

``` r
library(hongkongio)
library(dplyr)

hkio_users_df %>% # single data set
  glimpse()
```

    #> Observations: 940
    #> Variables: 10
    #> $ user_id            <chr> "vMm2zemFOF7kmXoDyX24Bo+TorqhNutpZlATYyxsE=...
    #> $ name               <chr> "vMm2zemFOF7kmXoDyX24Bo+TorqhNutpZlATYyxsE=...
    #> $ screen_name        <chr> "vMm2zemFOF7kmXoDyX24Bo+TorqhNutpZlATYyxsE=...
    #> $ location           <chr> NA, NA, NA, NA, NA, "California, USA", NA, ...
    #> $ description        <chr> NA, NA, NA, NA, NA, "cool", NA, NA, NA, NA,...
    #> $ profile_url        <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
    #> $ followers_count    <int> 1, 0, 23949, 17, 0, 17116, 0, 1, 2, 12, 0, ...
    #> $ following_count    <int> 52, 0, 52, 34, 0, 76, 39, 46, 127, 64, 0, 3...
    #> $ account_created_at <date> 2017-08-30, 2017-10-16, 2016-06-27, 2016-0...
    #> $ account_lang       <chr> "zh-cn", "zh-cn", "zh-cn", "es", "zh-tw", "...

``` r
hkio_all_tweets() %>% # combine the 9 `data.table`s of tweets
  glimpse()
```

    #> Observations: 3,614,907
    #> Variables: 31
    #> $ status_id          <chr> "436306424587890688", "582682975969624064",...
    #> $ user_id            <chr> "206027550", "206027550", "206027550", "206...
    #> $ name               <chr> "The Flecha", "The Flecha", "The Flecha", "...
    #> $ screen_name        <chr> "nessniven", "nessniven", "nessniven", "nes...
    #> $ location           <chr> "Republic of Korea", "Republic of Korea", "...
    #> $ description        <chr> "When you see Jair Bolsonaro and his progra...
    #> $ profile_url        <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
    #> $ followers_count    <int> 100847, 100847, 100847, 100847, 100847, 100...
    #> $ following_count    <int> 31752, 31752, 31752, 31752, 31752, 31752, 3...
    #> $ account_created_at <date> 2010-10-22, 2010-10-22, 2010-10-22, 2010-1...
    #> $ account_lang       <chr> "en", "en", "en", "en", "en", "en", "en", "...
    #> $ lang               <chr> "pt", "pt", "pt", "pt", NA, "pt", "pt", "pt...
    #> $ text               <chr> "segui o @instagranzin e ganhei 89 seguidor...
    #> $ created_at         <dttm> 2014-02-20, 2015-03-30, 2015-03-31, 2015-0...
    #> $ source             <chr> "TweetDeck", "TweetDeck", "TweetDeck", "Twe...
    #> $ reply_to_user_id   <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
    #> $ reply_to_status_id <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
    #> $ quoted_status_id   <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
    #> $ is_retweet         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, F...
    #> $ retweet_user_id    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
    #> $ retweet_status_id  <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
    #> $ latitude           <chr> "absent", "absent", "absent", "absent", "ab...
    #> $ longitude          <chr> "absent", "absent", "absent", "absent", "ab...
    #> $ quote_count        <int> 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0...
    #> $ reply_count        <int> 0, 0, 0, 0, 0, 0, 0, 0, 18, 1, 1, 1, 1, 0, ...
    #> $ like_count         <int> 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
    #> $ retweet_count      <int> 0, 52, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, ...
    #> $ hashtags           <list> [NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
    #> $ urls_url           <list> [NA, "http://goo.gl/32K38q", NA, "http://g...
    #> $ mentions_user_id   <list> ["443196382", NA, "116351908", NA, NA, NA,...
    #> $ poll_choices       <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...
