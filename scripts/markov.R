# We create a function to generate song using markov chains 
# The parameters of the function:
# words are the full set of all lyrics from the artist
# order is how we define the probability of the next word x_n by looking at x_{n-1:n-1-m} where m is the order
# line_lengths is a list of all the different line lengths in the data 
# song_length defines how many lines you want to be in the song 


markov <- function(words, order, line_lengths, song_length){
  # Create a dictionary of word transitions
  word_dict <- list()
  
  # Creating a loop which stores the 
  for (j in 1:order){
    for (i in 1:(length(words)-order)) {
      # storing each sequential list of length order
      current_phrase <- paste(words[i:(i+j-1)], collapse = " ")
      
      #getting the next word of the current phrase 
      next_word <- words[i+j]
      
      # Adding the sequential words to the dictionary 
      if (!(current_phrase %in% names(word_dict))) {
        word_dict[[current_phrase]] <- list()
      }
      # Adding the next word the the dictionary 
      word_dict[[current_phrase]][[next_word]] <- ifelse(is.null(word_dict[[current_phrase]][[next_word]]), 1, word_dict[[current_phrase]][[next_word]] + 1)
    }
  }
  
  # having to intialise the first words of the generated song    
  current_phrase <- paste(sample(words, 1), collapse = " ")
  
  #determine the length of each line in the song + 3 
  # +3 is an estimate for the song to stop generating completely random lines to
  line_length_order <- sample(line_lengths[line_lengths > 3], song_length + 2*order,replace = TRUE)
  
  # Determine how many words you want the song to have plus the first few lines generated as they will be completely random 
  num_words <- sum(line_length_order) 
  
  # Used to store the full list of lyrics generated 
  generated_lyrics <- current_phrase
  
  
  
  while (length(generated_lyrics) < num_words ) {
    
    # checking if the current phrase is in the sequential word dictionary
    if (current_phrase %in% names(word_dict)) {
      # getting a list of the possible next words
      next_words <- names(word_dict[[current_phrase]])
      
      # Getting the probabilities for each next word
      probabilities <- unlist(word_dict[[current_phrase]])
      
      # sampling depending on the next words 
      next_word <- sample(next_words, 1, prob = probabilities)
      
      # adding new word to generated lyrics 
      generated_lyrics <- c(generated_lyrics, next_word)
      
      
      #changing the current phrase so it can start again with length order  
      current_phrase <- paste(tail(generated_lyrics, order), collapse = " ")
      
    } else {
      if (current_phrase>1){
        current_phrase <- paste(strsplit(current_phrase, " ")[[1]][-1], collapse = " ")
      }
      else{
        new_word <- paste(sample(words, 1), collapse = " ")
        generated_lyrics <- c(generated_lyrics, next_word)
        current_phrase <- paste(tail(generated_lyrics, order), collapse = " ")
      }
    }
    next
    
  }
  
  # break up the long sentence into designated line order lengths 
  full_songs <- list()
  # Loop through each position
  for (line in line_length_order) {
    # Extract the words up to the current position
    broken_line <- paste(generated_lyrics[1:(line-1)], collapse = " ")
    
    # Store the broken sentence in the list
    full_songs[[length(full_songs) + 1]] <- broken_line
    
    # Update the words to start from the current position
    generated_lyrics <- generated_lyrics[(line):(length(generated_lyrics))]
  }
  #adding the last line to the full song 
  full_songs[[length(full_songs) + 1]] <- paste(generated_lyrics, collapse = " ")
  
  # remove the top 3 lines 
  full_songs <- full_songs[-(1:2*order)]
  
  # Print the broken sentences
  return(full_songs)
}


