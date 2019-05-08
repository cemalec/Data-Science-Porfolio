clearWord <- function(word){
  basic_naughty_words <- c("arse","ass","bastard",
                           "bitch","cunt","damn","dyke","fag",
                           "fuck","goddamn","nigger","nigga",
                           "queer","shit","slut","twat")
  startsEndsLetter <- !(length((grep("^[a-zA-Z]",word))) == 0 | length((grep("[a-zA-Z]$",word))) == 0)
  notNaughty <- !(word %in% basic_naughty_words)
  isCleared <- (startsEndsLetter & notNaughty)
  return(isCleared)
}