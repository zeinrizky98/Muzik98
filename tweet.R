library(mongolite)
# This is the connection_string. You can get the exact url from your MongoDB cluster screen
connection_string = Sys.getenv("MONGO_CONNECTION_STRING")

twitter_collection <- mongo(collection = Sys.getenv("MONGO_COLLECTION_NAME"), # Creating collection
                            db = Sys.getenv("MONGO_DB_NAME"), # Creating DataBase
                            url = connection_string, 
                            verbose = TRUE)

a <- twitter_collection$find()
a <- tail(a,2)

# Hashtag
hashtag <- c("Music", "Youtube", "Chart", "Hits", "Trend", "24Hours", "Videos",
             "github","rvest","rtweet", "bot", "opensource", "dplyr", "tidyr")

samp_word <- sample(hashtag, 1)

## Status Message

status_details <- paste0(format(Sys.Date(),"%d %B %Y", tz = "Asia/Bangkok"),", ",format(Sys.time(), "%X", tz = "Asia/Bangkok"), " : \n", "\n",
                         "1. ",    a[1,3]," (", a[1,2], ") \n", 
                         "2. ",    a[2,3]," (", a[2,2], ")\n", "\n",
                         a$link[1], "\n",
                         "#",samp_word, " #YoutubeChart")

# Publish to Twitter
library(rtweet)

## Create Twitter token
yutub_token <- rtweet::create_token(
  app = Sys.getenv("TWITTER_APP_NAME"),
  consumer_key = Sys.getenv("TWITTER_API_KEY"), 
  consumer_secret = Sys.getenv("API_KEY_SECRET"),
  access_token = Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret = Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
)


## Post Twitter
rtweet::post_tweet(
  status = status_details,
  token = yutub_token)
