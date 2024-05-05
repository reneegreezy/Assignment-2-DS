library(stringr)

# Count the number of words in each line of the 'lyric_column'
word_counts <- str_count(clean_lyrics$lyric, "\\S+")

beyonce_words <- unlist(strsplit(clean_lyrics$lyric, " "))

# Source the file containing the Markov function
source("./scripts/markov.r")

# Now you can use the Markov function
result <- markov(words = beyonce_words , order=2, line_lengths= word_counts, song_length = 50)

# Open a text file for writing 
file_path <- "./output/First song.txt"
file_conn <- file(file_path, "w")

# Write each line of the song to the text file
for (item in result) {
  writeLines(item, file_conn)
}

# Close the file connection
close(file_conn)
