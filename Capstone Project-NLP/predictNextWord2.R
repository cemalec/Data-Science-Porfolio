predictNextWord2 <- function(wordList,wordTree){
  #Note that this will fail if the tree is shallower than the wordList
  usedWords <- list()
  tempWordTree <- wordTree
  i <- 1
  while(i <= length(wordList)){
    word <- tolower(wordList[i])
    
    if(!is.na(tempWordTree[word])) {
      if(length(tempWordTree[[word]])>1){
        tempWordTree <- tempWordTree[[word]]
        usedWords <- append(usedWords, word)
        i <- i + 1
      } else {
        tempWordTree <- wordTree
        usedWords <- list()
      }
    } else{
      tempWordTree <- wordTree
      usedWords <- list()
    }}
  #Here is where an optional skip-gram tree can be placed if the above failed to find anything.
  
  #Find the next word
  nextWord <- findMaxNode(tempWordTree)$maxNode
  nextWordProb <- findMaxNode(tempWordTree)$Prob
  if(nextWord == "i"){
    nextWord <- "I"
  }
  return(list(nextWord = nextWord, usedWords = length(usedWords), nextWordProb = nextWordProb))
}