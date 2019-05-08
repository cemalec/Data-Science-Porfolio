#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(markdown)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  navbarPage("Text Predictor",
  
    tabPanel("Application",
      sidebarPanel(
      helpText("Type your phrase, press the space bar to predict the next word, press return to accept the prediction.")
      ),
      # Text input
      mainPanel(
        textInput('textIn',label="Type text here.",placeholder = ""),
        tags$script('
            $(document).on("keydown", function (e) {
                Shiny.onInputChange("lastkeypresscode", e.keyCode);
                });
                '),
  
        # Text output of typed, but no necessarily used text
        htmlOutput("htmlOut")
      )
      ),
    tabPanel("Explanation",
        includeMarkdown("Word Prediction Algorithm.Rpres")
        )
    )
  )
  )