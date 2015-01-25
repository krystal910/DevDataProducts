library(shiny)
library(rCharts)
library(reshape2)
library(ggplot2)

# Load data
raw <- read.csv("rawWDI.csv")
wdi <- melt(raw[], id.vars=c("Country","Series"))
wdi$variable <- substring(wdi$variable, 2, 5)
colnames(wdi) <- c("Country","Indicator","Year","Value")
cb_names <- as.list(unique(wdi$Country))

# Define the overall UI
shinyUI(

  # Use a fluid Bootstrap layout
  fluidPage(

    # Give the page a title
    titlePanel("World Development Indicators(WDI) by Country"),

    # Generate a row with a sidebar
#     sidebarLayout(

      # Define the sidebar
      sidebarPanel(

        h4("Instructions:"),
        p("1. Select which country (or countries) that you would like to see trends for."),
        p("2. Select the WDI that you would like be displayed."),
        p("3. That's it! The graph will automatically refresh and you will be able
          to see how your selected countries compare."),
        br(),
        # Input 1
        checkboxGroupInput("country", "Select Country:",  choices= setNames(as.list(unique(wdi$Country)), unique(wdi$Country)),
                           selected = wdi[1,]$Country),
        br(),
        # Input 2
        selectInput("indicator", "Select Indicator:",
            choices= setNames(as.list(unique(wdi$Indicator)), unique(wdi$Indicator)),
            selected = wdi[1,]$Indicator
            ),
        helpText("Data from the World Data Bank (2000-2012)")
          ),


      # Define the Main Panel
      mainPanel(
        h4(textOutput("noselection")),
        showOutput("myChart","highcharts")
            )
      )
)

