## Word Prediction Algorithm

The shiny app built by the code in this repository can be viewed [here](https://cemalec.shinyapps.io/WordPredict/)
The model takes a corpus of data and stores counts of different n-grams in a tree-like structure. When the user types in a word, the algorithm find the most likely next word given the previous words, using the largest n-gram available in the dataset.
