checkBranch <- function(tlist,count,blist){
  word <- tlist[1]
  tlist <- tlist[-1]
  if(is.na(word)){
    #If the end of the token list has been reached, return a null list
    blist <- append(blist,vector("list",0))
  } else if(word %in% names(blist)){
    #If the word is already in the current branch, add to the count
    blist[[word]][["_count_"]] <- blist[[word]][["_count_"]] + count
    blist[[word]] <- checkBranch(tlist,count,blist[[word]])
  } else {
    #If word is not in current branch, grow one from remaining words
    blist[[word]] <- append(blist[[word]],
                            c("_count_" = count, checkBranch(tlist,count,blist[[word]])))
  }
  return(blist)
}