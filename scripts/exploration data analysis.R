#install.packages("wordcloud")
#install.packages("wordcloud2")
# install.packages("tm")
# install.packages("RColorBrewer")
install.packages("sentimentr")
library(wordcloud)
library(RColorBrewer)
library(wordcloud2)
library(tm)
library(dplyr)
library("rvest")
library("httr")
library("magrittr")
library(sentimentr)

# Number of songs 
num_songs <- length(unique(beyonce_lyrics$track_title))
print(num_songs)

text <- clean_lyrics$lyric

docs <- Corpus(VectorSource(text))

#Removing numbers and punctuation and stripping any white space
docs <- docs %>%
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace)



# Remove common words that are non descriptive to music 
# We remove words from a list of 100 most common words on wikipedia 
# We get this list by webscrapping 

r4ds_url <- "https://en.wikipedia.org/wiki/Most_common_words_in_English"
r4ds_html <- rvest::read_html(r4ds_url)
wikitables <- r4ds_html %>% 
  rvest::html_nodes("table.wikitable") %>%
  rvest::html_table(fill = TRUE)

most_common_table <- wikitables[[1]]

most_common_words <- most_common_table$Word


docs <- tm_map(docs, removeWords, most_common_words)
dtm <- TermDocumentMatrix(docs)
matrix <- as.matrix(dtm)
words <- sort(rowSums(matrix), decreasing=TRUE)
df <- data.frame(word = names(words),freq=words)
df <- df[df$freq>=20,]
wordcloud2(data = df,size=1.6,color = 'random-light', shape = 'cardioid',backgroundColor = 'black')

# Using a package called textblob we check the polarity and subjectivity of the lyrics 

beyonce_words <- unlist(strsplit(clean_lyrics$lyric, " "))



