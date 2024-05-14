# Using Markov chains to generate Beyonce song lyrics 
### Inspired by Hanna Frys markov chains for Queens Speech 

## Intro

Inspired by Hannah Fry's book "The Indisputable Existence of Santa Claus: The Mathematics of Christmas," where she uses Markov chains to predict the Queen's Speech, we decided to explore a similar approach for generating Beyonce song lyrics.

 Our data source was a collection of 97 Beyonce songs found on Kaggle https://www.kaggle.com/datasets/yukawithdata/beyonce-track-attribute-data. After analysing this dataset, we created a word cloud to visualise the most frequent themes within Beyonce's lyrics.

## Word cloud/ Exploration 
![Word Cloud](https://github.com/reneegreezy/Assignment-2-DS/blob/main/output/word%20cloud.png)

From the word cloud it appears that the most common theme is love and romance.

## Data cleaning 

We remove rows of lyrics with profanity and do some other data cleaning exercises such as removing the punctuation and making to it lowercase.

## Version 0.2.0 

To improve the coherence of the generated lyrics, we address the limitation of the Markov chain model occasionally resorting to random words. We achieve this by adjusting the prediction process.  Instead of relying solely on the previous p words $w_{n-1},...,w_{n-p}$, the model will attempt to predict the next word based on this p-gram (sequence of p words). If the specific p-gram hasn't been encountered during training, the model will then consider a slightly shorter sequence $w_{n-1},...,w_{n-p+1}$ for prediction and iteratively reduce until the sequence has been seen before. This fallback mechanism helps the model leverage more of the training data and reduces the likelihood of introducing completely random words.

## Version 0.1.1 

To enhance the flow and coherence of the generated lyrics, we implemented two adjustments:
* Line length has to be greater than 2 
* We observed that the first few generated lines often lacked coherence due to the model "warming up." To counteract this, we discarded a strategic number of initial lines. Previously, this number was fixed. Now, we dynamically adjust it based on the Markov chain order (p). By discarding 2p lines, we allow the model to settle into a more meaningful sequence before including the generated text in the final output.

## Version 0.1.0 

Our first attempt involved a straightforward function. It took the Markov chain order (p) as input and built a dictionary. This dictionary stored every sequence of words up to that order encountered in the Beyonce song dataset. Essentially, for a p-gram order of 2, the dictionary would contain every pair of consecutive words.

To initiate the song generation, we randomly selected a few words from the entire vocabulary (all unique words in the dataset). This formed the starting sequence. The model then aimed to follow the Markov chain principle, predicting the next word based on the previous p words. However, if the specific sequence of p words wasn't found in the dictionary (indicating it never appeared in the training data), the model resorted to randomly choosing another word.

We observed that the initial generated lines often relied heavily on these random selections. The lyrics took several lines to transition into a more cohesive state based on the actual learned probabilities. To address this, we implemented a buffer of three lines. The model would discard the first three lines generated and only use the subsequent lines, where the Markov chain should theoretically have "warmed up" and started producing more meaningful sequences

## Example song produced.

you're done pleasin' me like\
it's okay ohoh like a
perm that's been left too
just won't take ohoh i can see
now it's all coming
so clear to me now i gotta
you lied and see she's had half of me you
lied how could you lie you lied
you need to stop playing 'round with all them
clowns and the wankstas good girls gotta get down
with the gangsta's go 'head girl put
some back and some
neck up on it while i stand up in the background and check up on it i'ma
let you work up on
it ladies let 'em
check up on
it watch it while he check up on
it watch it while he check up on
it i'ma let you work up
on it ladies let 'em check up on
it dip it pop it twerk it stop it check
on me tonight yeah check on
it check on
it check on it check
on it check on it check
on it check on it check on it check on it
check on it ooh boy you
looking like you like what you see he having such
a good time won't you
come over and check up on it
dip it pop it twerk
it stop it check on me tonight well it's the king of the underground and
the king of the hill
you're tuned into a
winner that's never takin' a loss
reppin' houston with beyoncé and
slim thug the boss diamonds on the wood peel 
i'm a dirty south soldier draped up in that crown holder thought 
i told ya i like your wiggle and the way that you know 









