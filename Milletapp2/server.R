
library(shiny)
library(DT)

library(readxl)
library(plotly)
library(ggcorrplot) # for correlation plot
library(shinycssloaders) # to add a loader while graph is populating
library(shiny) # shiny features
library(shinydashboard) # shiny dashboard functions
library(ggtext)
library(ggplot2)



## Shiny Server component for dashboard

function(input, output, session){
  

  
  
  # For Structure output
  output$structure <- renderPrint({
    my_data %>% 
      str()
  })
  
  
  # For Summary Output
  output$summary <- renderPrint({
    my_data %>% 
      summary()
  })
  
  # Data table Output
  output$dataT <- renderDataTable(my_data)
  
  
  
  
  output$ap_line <- renderPlotly({
    
    fig <- plot_ly(year_area_prod, x = ~Year,  mode = 'lines+markers')
    fig<- fig %>%add_trace( y = ~Production,name="<b>Production(All India)</b>" , type = 'scatter', mode = 'lines+markers')
    fig<- fig %>%add_trace( y = ~Area, name="<b>Area of Cultivation</b> ",type = 'scatter', mode = 'lines+markers')
    fig<- fig %>%layout(title="<b>Area of Cultivation/Production</b>")
    fig
    
    
  })
  
 output$coc_ngt_line<-renderPlotly({

    fig <- plot_ly(pearl_data, x = ~State,  mode = 'lines+markers')
    fig<- fig %>%add_trace( y = ~NetReturns,name="<b>Net Returns</b>" , type = 'scatter', mode = 'lines+markers')
    fig<- fig %>%add_trace( y = ~GrossReturns, name="<b>Gross Returns</b> ",type = 'scatter', mode = 'lines+markers')
    fig<- fig %>%add_trace( y = ~TotalCost, name="<b>Total Cost</b> ",type = 'scatter', mode = 'lines+markers')
    fig<- fig %>%layout(title="<b>Cost of Cultivation by Year</b>")
     fig


  })

  
  
  
  # Cost of Cultivation By State  grouped bar graph
  output$coc_state <- renderPlotly({
    p<- plot_ly(
      data=pearl_data,
      y=~State,
      x=~TotalCost,
      type = "bar",
      name="Total Cost"
    ) %>% 
      add_trace(x=~GrossReturns,name="Gross Returns") %>% 
      layout(title = '<b>Cost of Cultivation By State</b>')
  })
  

  output$coc_ngt_bar<- renderPlotly({
    p<- plot_ly(
      data=pearl_data,
      y=~State,
      x=~TotalCost,
      type = "bar",
      name="Total Cost"
    ) %>%
      add_trace(x=~GrossReturns,name="Gross Returns") %>%
      add_trace(x=~NetReturns,name="Net Returns") %>%
      layout(title = '<b>Cost of Cultivation By Year</b>')

    p
})
  
  
  # Cost of Cultivation By Year  bar graph
  output$coc_year <- renderPlotly({
    p<- plot_ly(
      data=pearl_data,
      x=~Year,
      y=~TotalCost,
      type = "bar",
      name="Total Cost"
    ) %>% 
      add_trace(y=~GrossReturns,name="Gross Returns") %>% 
      layout(title = '<b>Cost of Cultivation By Year</b>')
    
  })
  
  
  ### Pie Chart of Country Export 
  output$export_pie <- renderPlotly({
    
    fig <- plot_ly(piechart_country_export, labels = ~Country , values = ~Export, type = 'pie',textinfo = 'label+percent')
    fig <- fig %>% layout(title = '<b>Export From India to Other Country (in Lakh Tonnes)</b>',
                          height=400,
                          xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                          yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
    fig
    
    
    
    
  })
  
  ### Pie Chart of  State wise production
  output$prod_top_state <- renderPlotly({
    
    fig <- plot_ly(state_prod, labels = ~States , values = ~Production, type = 'pie',textinfo = 'label+percent')
    fig <- fig %>% layout(title = '<b>Production of Bajra All Over India By States (in  Lakh Tonnes) <br>2010-11</b>',
                          xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                          yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
    fig
    
    
  })
  
  
  #trends
  
  output$MSP_meter<-renderPlotly({
  
    fig <- plot_ly(
      type = "indicator",
      mode = "gauge+number+delta",
      value = 2250,
      title = list(font = list(size = 30)),
      delta = list(reference =2000 , increasing = list(color = "RebeccaPurple")),
      gauge = list(
        axis = list(range = list(NULL, 3000), tickwidth = 1, tickcolor = "darkblue"),
        bar = list(color = "darkblue"),
        bgcolor = "white",
        borderwidth = 2,
        bordercolor = "gray",
        steps = list(
          list(range = c(0, 1500), color = "cyan"),
          list(range = c(1500,2500), color = "royalblue")),
        threshold = list(
          line = list(color = "red", width = 4),
          thickness = 0.75,
          value = 2250))) 
    fig <- fig %>%
      layout(
        title='<b>Minimum Support Price</b>',
        size=40,
        height=400,
        margin = list(l=20,r=30),
        paper_bgcolor = "lavender",
        font = list(color = "darkblue", family = "Arial"))  
    
    
    
  #  trend = agg_data %>% 
     # ggplot(aes(x=get(input$var5),y=get(input$var6)))+
    #  geom_line(size=1)+
    #  labs(title =paste("Relation b/w",input$var5,"and",input$var6),
     #      x=input$var5,
      #     y=input$var6)+
   #   theme(plot.title = element_text(size=10,hjust = 0.5))
    
    #ggplotly(trend)
    
  })
  
  
  ### msp_line
  output$msp_line <- renderPlotly({
    p<- Bajra_MSP %>% 
      ggplot(aes(x=Year,y=`Pearl Millet (Bajra)`))+
      geom_line()+
      labs(x="Year",y="Minimum Support Price",title = "Minimum Support Price(MSP) Yearly Trend") 
    ggplotly(p)
     
    
    
    
  })
  
  
  ## Correlation plot
  output$export_line <- renderPlotly({
    
    fig <-  plot_ly(MilletsExport , x = ~Category,  mode = 'lines+markers')
    fig<- fig %>%add_trace( y = ~`Bajra Exports`,name="<b>Production</b>" , type = 'scatter', mode = 'lines+markers')
    fig<- fig %>%layout(title="<b>Export of Pearl Millet(Bajra) from India (in Lakh Tonnes)<b>")
    fig
  
  
  
  
})
  
  
  
  #******************#
  #    Prediction    #
  #******************#   
 
  
  
  #Multiple Linear Regression
  
    
    # Input Data
    datasetInput <- reactive({  
      
      df <- data.frame(
        Name = c("Year",
                 "State",
                 "Area"),
        Value = as.character(c(input$Year,
                               input$State,
                               input$Area)),
        stringsAsFactors = FALSE)
      
      Production <- 0
      df <- rbind(df,Production)
      input <- t(df)
      write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
      
      test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
      
      Output <- data.frame(Prediction_of_Production=predict(lm_cleaned_data,test))
      print(Output)
      
    })
    
    # Status/Output Text Box
    output$contents <- renderPrint({
      if (input$submitbutton>0) { 
        isolate("Calculation complete.Production in (Lakh Tonnes).") 
      } else {
        return("Server is ready for calculation.Production in (Lakh Tonnes).")
      }
    })
    
    # Prediction results table
    output$tabledata <- renderTable({
      if (input$submitbutton>0) { 
        isolate(datasetInput()) 
      } 
    })
    
    
    

    # Input Data
    datasetInputlmn <- reactive({

      df <- data.frame(
        Name = c(#"Year",
                 #"State",
                 "TotalCost",
                 "GrossReturns",
                 "MSP"),
        Value = as.character(c(#input$Year,
                               #input$State,
                               input$TotalCost,
                               input$GrossReturns,
                               input$MSP)),
        stringsAsFactors = FALSE)

     NetReturns <- 0
      df <- rbind(df,NetReturns)
      input <- t(df)
      write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)

      test<- read.csv(paste("input", ".csv", sep=""), header = TRUE)

      Output <- data.frame(Prediction_of_Net_Gross=predict(model_lmn,test))
      print(Output)
      
      
      

    })
    
    
    # Status/Output Text Box
    output$contentslmn <- renderPrint({
      if (input$submitbutton1>0) {
        isolate("Calculation complete.Net Returns(in Rs.)")
      } else {
        return("Server is ready for calculation.Net Returns(in Rs.)")
      }
    })

    # Prediction results table
    output$tabledatalmn <- renderTable({
      if (input$submitbutton1>0) {
        isolate(datasetInputlmn())
      }
      
  
    })

  

  
}

