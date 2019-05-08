findMaxNode <- function(tree, follow = FALSE){
  nodes <- length(tree)
  maxCount <- 0
  for(i in 2:nodes){
    if(tree[[i]][["_count_"]] > maxCount){
      maxNode <- names(tree[i])
      maxCount <- max(tree[[i]][["_count_"]],maxCount)
    }
  }
  if(length(tree[[maxNode]])>1 & follow == TRUE){
    maxNode <- findMaxNode(tree[[maxNode]])
  }
  return(list(maxNode = maxNode,Prob = maxCount/tree[["_count_"]]))
}