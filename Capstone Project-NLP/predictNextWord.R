predictNextWord <- function(wordList,wordTree){
  #Note that this will fail if the tree is shallower than the wordList
  word <- tolower(wordList[1])
  wList <- wordList[-1]
  if(length(wList) == 0){
    if(is.null(wordTree[[word]])){
      nextWord <- findMaxNode(wordTree,follow = TRUE)
    } else if(length(wordTree[[word]]) > 1){
      nextWord <- findMaxNode(wordTree[[word]])
    } else if(wordTree[[word]] == "_count_"){
      nextWord <- names(wordTree)
    } else {
      nextWord <- findMaxNode(wordTree)
    }
  } else if(is.null(wordTree[[word]])){
    nextWord <- predictNextWord(wList,wordTree)
  } else if(length(wordTree[[word]])>1){
    nextWord <- predictNextWord(wList,wordTree[[word]])
  } else {
    nextWord <- findMaxNode(wordTree)
  }
  
  if(nextWord == "i"){
    nextWord <- "I"
  }
  return(nextWord)
}