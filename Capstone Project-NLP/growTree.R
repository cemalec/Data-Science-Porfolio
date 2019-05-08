growTree <- function(tokens,tree) {
  #Generates a word tree from a list of tokens and an existing wordtree  
  for(i in 1:length(tokens)){
    tlist <- unlist(strsplit(tokens[i],"_"))
    clear_list <- lapply(tlist,clearWord)
    if(FALSE %in% clear_list){
      print("failed")
    } else {
      tree <- checkBranch(tlist,tree)
    }
  }
  return(tree)
  }