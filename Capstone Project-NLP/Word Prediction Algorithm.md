A prediction algorithm
========================================================

The prediction algorithm is built off of data provided by SwiftKey. Here, I use what is known as an n-gram model.

- The next word is predicted by up to three preceding words.
- The algorithm only uses continuous series of words that it has observed in a training set.
- A user-friendly Shiny App has been developed.

Example: Green Eggs and Ham
========================================================
Suppose the only data we have is Dr. Suess' classic "Green Eggs and Ham." To power the algorithm, I would create a list of all sequences of four words that appear in the book, along with a count of each sequence, such as:

- "I will not eat" (appears 6 times)
- "with a fox I" (appears 4 times)
- "do not like them" (appears 26 times)

Building a Word Tree
========================================================

The algorithm follows "branches" of words until the predicted word is reached. Let's follow "do not like" predict **"them"**.

- "do" is followed by "not", "would", "I", and "so"
- "not" is followed by "like" or "eat"
- "like" is followed by "that" (1 time), **"them" (26 times)**, and "green" (6 times)


Using the App
========================================================
- The user inputs text and the app predicts a word using three preceding words
- The words that appear in <font color = "#0000FF">blue</font> are used in the prediction of the next word.
- The user can accept the <font color="#FF0000">red</font> predicted word and add it to input by hitting "enter"
- The estimated probability of the next word appears as well.

Evaluating the App
========================================================
- The app operates in real time on the shiny.io web servers
- Data can be added to the underlying word tree to increase accuracy
