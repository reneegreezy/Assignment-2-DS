# We find an already created dataset 
# The dataset contains lyrics, song title and year for songs on 7 Beyonce albums 
beyonce_lyrics <- readr::read_csv('./data/raw/beyonce_lyrics.csv')

# Remove swear words

# Import data set that has a list of words that would be considered inappropriate 
profanity <- readr::read_csv('./data/raw/excluded words.csv')

profanity_words <-profanity$words

contains_profanity <- function(text) {
  any(grepl(paste0("\\b", collapse = "|", profanity_words, "\\b"), text, ignore.case = TRUE))
}

# Filter out rows with profane words in the lyrics
clean_lyrics <- beyonce_lyrics[!sapply(beyonce_lyrics$lyric, contains_profanity), ]

# We lose 171 lines and have 5985 remaining lines 

# Create csv of cleaned data 
readr::write_csv(clean_lyrics,'./data/derived/beyonce_clean_lyrics.csv')
