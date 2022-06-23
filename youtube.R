# Data
library(dplyr)
library(rvest)
urlPT <- "https://kworb.net/youtube/"
data3 <- urlPT %>% read_html() %>% html_table()
df <- data3[[1]]
names(df)[1] <- "Pos"
names(df)[2] <- "Stat"

#Link youtube no 1

pg <- read_html(urlPT)
z <- html_attr(html_nodes(pg, "a"), "href")
zz <- as.data.frame(z)
num1 <- zz[21,]
num1 = gsub("video/", "https://www.youtube.com/watch?v=",num1)
link = gsub(".html","",num1)

# Hashtag
hashtag <- c("Music", "Youtube", "Chart", "Hits", "Trend", "24Hours", "Videos",
             "github","rvest","rtweet", "bot", "opensource", "ggplot2", "dplyr", "tidyr")

samp_word <- sample(hashtag, 1)

## Status Message

status_details <- paste0(Sys.Date(),": Top 3 videos in the past 24 hours :", "\n", "\n",
                         "1. ",    df[1,3]," (", df[1,2], ") \n", 
                         "2. ",    df[2,3]," (", df[2,2], ")\n",
                         "3. ",    df[3,3]," (", df[1,2], ")\n", "\n",
                         link, "\n",
                         "#",samp_word, " #YoutubeChart", "\n")

# Publish to Twitter
library(rtweet)

## Create Twitter token
yutub_token <- rtweet::create_token(
  app = "Muzik_Youtube",
  consumer_key = Sys.getenv("TWITTER_API_KEY"), 
  consumer_secret = Sys.getenv("API_KEY_SECRET"),
  access_token = Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret = Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
)


## Post Twitter
rtweet::post_tweet(
  status = status_details,
  token = yutub_token)
