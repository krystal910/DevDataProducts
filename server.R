library(shiny)
library(rCharts)
library(reshape2)
library(ggplot2)


raw <- read.csv("rawWDI.csv")
wdi <- melt(raw[], id.vars=c("Country","Series"))
wdi$variable <- substring(wdi$variable, 2, 5)
colnames(wdi) <- c("Country","Indicator","Year","Value")


shinyServer(function(input, output) {
  output$myChart <- renderChart2({
                      subset <- wdi[wdi$Country == input$country & wdi$Indicator == input$indicator,]
                      x1 <- hPlot(Value ~ Year, data = subset,
                      color = 'Country', type = 'line',
                      group = 'Country', title = paste(input$indicator, " by Country")
                        )
                      return(x1)
                                })
  output$noselection <- renderText({
    validate(
      need(input$country, 'Please select at least one country!')
    )
  })
})





