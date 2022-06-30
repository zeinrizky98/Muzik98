library(dplyr)
library(rvest)
library(jsonlite)

#scrape
urlPT <- "https://kworb.net/youtube/"
data3 <- urlPT %>% read_html() %>% html_table()
df <- data3[[1]]
names(df)[1] <- "Pos"
names(df)[2] <- "Stat"
df <- head(df,2)

#Link youtube no 1
pg <- read_html(urlPT)
z <- html_attr(html_nodes(pg, "a"), "href")
zz <- as.data.frame(z)
num1 <- zz[21,]
num1 = gsub("video/", "https://www.youtube.com/watch?v=",num1)
link = gsub(".html","",num1)
df$link <- link

#connect to DB

library(mongolite)

# This is the connection_string. You can get the exact url from your MongoDB cluster screen

connection_string = Sys.getenv("MONGO_CONNECTION_STRING")

twitter_collection <- mongo(collection = Sys.getenv("MONGO_COLLECTION_NAME"), # Creating collection
                            db = Sys.getenv("MONGO_DB_NAME"), # Creating DataBase
                            url = connection_string, 
                            verbose = TRUE)

twitter_collection$insert(df)
