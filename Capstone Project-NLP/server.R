#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
load("wordTree4")
source("predictNextWord2.R")
source("findMaxNode.R")
      makeText <- reactive({
        textInVector <- strsplit(input$textIn,split=" ")[[1]]
        x <- strsplit(input$textIn,split="")[[1]]
        N <- length(textInVector)
        if(input$textIn == ""){
          knownText <- ""
          usedText <- ""
          unknownText <- ""
        } else {
          processedText <- predictNextWord2(textInVector,wordTree)
          m <- processedText$usedWords
          usedText <- paste(textInVector[(N-m):N],collapse=" ")
          if(m == 0){
            usedText <- ""
          }
          knownText <- paste(textInVector[-((N-m):N)],collapse= " ")
          if(length(knownText) == 0){
            knownText <- ""
          }
          #usedText <- paste(textInVector[1:N],collapse = " ")
          if(x[length(x)] == " "){
            unknownText <- paste(processedText$nextWord,
                                 " (",
                                 as.character(round(100*processedText$nextWordProb,1)),
                                 "%)")
            #unknownText <- predictNextWord(textInVector,wordTree)
          } else {
            unknownText <- ""
          }
        }
          #else {
          #knownText <- paste(textInVector[1:(N-3)],collapse = " ")
          #usedText <- paste(textInVector[(N-2):N], collapse = " ")
          #if(x[length(x)]== " "){
          #  unknownText <- predictNextWord(textInVector[(N-2):N],wordTree)
          #} else {
          #  unknownText <- ""
          #}
        #}
        return(paste(knownText,
                     "<font color=\"#0000FF\"><b>",usedText,"</b></font>",
                     "<font color=\"#FF0000\"><b>",unknownText,"</b></font>",
                     collapse = " "))
  })  
  
  updateText <- reactive({
    x <- strsplit(input$textIn,split = "")[[1]]
    textInVector <- strsplit(input$textIn,split=" ")[[1]]
    if(length(x) == 0){
      return("")
      } else if(x[length(x)] == " " & input$lastkeypresscode == 13){
        N <- length(textInVector)
        nextWord <- predictNextWord2(textInVector,wordTree)$nextWord
        #if(N < 4){
          #nextWord <- predictNextWord2(textInVector[1:N],wordTree)$nextWord
        #} else{
        #  nextWord <- predictNextWord2(textInVector[(N-2):N],wordTree)$nextWord
        #}
        return(updateTextInput(session,'textIn',value=paste0(input$textIn,nextWord)))
    } else{
        return(input$textIn)
      }
  })
  
  output$htmlOut <- renderText({ 
    updateText()
    makeText()
    
  })
})
