library(leaflet)

######################### Constant variables #########################

dfCapt <- c("Not feasible", "Future potential", "Now possible", "Now present")

########################### main function ############################

shinyServer(function(input,output) {
  
  #Render selection
  dfSelection <- reactive(
                 if (length(input$Search) == 0) {{ subset(dataframe, Quantity >= input$ipQuantity[1] & 
                                              Quantity <= input$ipQuantity[2] &
                                              (Country == input$ipCountry | input$ipCountry == "All countries") &
                                              (Concentration == input$ipConcentration | input$ipConcentration == 0) &
                                              (Capturability == input$ipCapturability | input$ipCapturability == 0)
                    ) }}
                 else {{subset(dataframe, Facility %in% input$Search)}}
    )

  #Map
  output$CO2map <- renderLeaflet({
    leaflet() %>% 
    addTiles() %>% 
    setView(lng = 15, lat = 50, zoom = 5) %>%
    
    #Markers 
    addMarkers(lng = dfSelection()$longitude,
               lat = dfSelection()$latitude, 
               clusterOptions = markerClusterOptions(),
               
               #Popups
               popup = paste(strong("Name: "), dfSelection()$Facility, br(),
                             strong("Activity: "), dfSelection()$Activity, br(),
                             br(),
                             strong("CO2 output: "), round(dfSelection()$Quantity),"Mt/y", br(),
                             strong("Capturability: "), dfCapt[dfSelection()$Capturability], br(),
                             br(),
                             strong("Address: "), dfSelection()$Street, ","
                                                , dfSelection()$City, ","
                                                , dfSelection()$Country
                             ) 
              )
  })
  
  #Render filtered information
  output$amountOf1 <- renderText({
    paste("Entries: ", nrow(dfSelection())) })
  
  output$total1 <- renderText({ 
    paste("Total CO2 output: ", 
          round(sum(dfSelection()$Quantity), digits = 0), 
          "Mt/y") })
  
  output$PctCapturable1 <- renderText({ 
    paste("Pct. capturable: ", 
          round( sum(dfSelection()$Quantity[dfSelection()$Capturability == 4 | dfSelection()$Capturability == 3]) /  sum(dfSelection()$Quantity) * 100, digits = 2), 
          "%" )})
  
  output$PctCaptured1 <- renderText({ 
    paste("Pct. being captured: ", 
          round( sum(dfSelection()$Quantity[dfSelection()$Capturability == 4]) /  sum(dfSelection()$Quantity) * 100, digits = 2), 
          "%" )})
  
  output$average1 <- renderText({ 
    paste("Average CO2 output: ", 
          round(mean(dfSelection()$Quantity)), 
          "Mt/y") })
  
  output$highest1 <- renderText({ 
    paste("Highest CO2 output: ", 
          round(max(dfSelection()$Quantity)), 
          "Mt/y") })
  
  output$lowest1 <- renderText({ 
    paste("Lowest CO2 output: ", 
          round(min(dfSelection()$Quantity)), 
          "Mt/y") })
  
})
