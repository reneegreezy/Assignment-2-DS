# Using Markov chains to generate Beyonce song lyrics 
### Inspired by Hanna Frys markov chains for Queens Speech 

## Intro

## Word cloud/ Exploration 
![Word Cloud](https://github.com/reneegreezy/Assignment-2-DS/blob/main/output/word%20cloud.png)



## Version 0.1.0 

We first attempted to use a simple function which takes the order of the markov chain and then stores each sequence of words up to that order ie if the order is two it will create a dictionary storing every consecutive word in the list of beyonce songs and save it as that. To start the markov chain we sample a bunch of random words from a list of all words that have been used and then we try to proceed with the markov chain. If however the order sequence of words has not been seeing before then we end up picking another word. We noticed too that when doing using this method it can take a few lines for the lyrics to stop just being from this random selections so we gave the algorithm 3 lines of words to then begin the ability to start using the probabilities and markov chain. 

## Version 0.1.1 

This contains some small updates:
* Some of the lines of the song where only length 1 we change this as it felt as if the flow was ruined 
* We also change the number of lines we drop as a safe hold to when we think the words will begin to make sense to 2 times the order so the amount of lines dropped 
*  

## Version 0.2.1 

With this version we really want to try to mitigate the amount of times the model uses a completely random word so instead we change the makrov chain so that if the model hasnt seen 

