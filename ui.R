#libraries
library(shiny)
library(leaflet)

########################### main function ############################

shinyUI(bootstrapPage(

  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  
  #MAP
  leafletOutput("CO2map", width = "100%", height = "100%"),
  
  #FILTERING OPTIONS MENU
  absolutePanel(
    
    #some general settings
    class = "panel panel-default",
    top = 0, 
    right = 0,
    width = 350, 
    height = "100%",
    align = "center",
    
    #title of the menu
    h2("Filtering options"),
    br(),
    
    #Search option is below this line
    selectizeInput("Search", 
              label = "Search facility",
              choices = facilityList,
              multiple = TRUE),
    
    #filtering options are down here
    sliderInput("ipQuantity", 
                label = "Quantity of CO2(Mt/y)", 
                min = 0, 
                max = 3800, 
                step = 20,
                value = c(0,3800)),
    
    selectInput("ipCountry",
                 label = "Which country?",
                 choices = countryList),
                
    selectInput("ipConcentration", 
                 label = "Concentration/Source of CO2", 
                 choices = c("All concentrations/sources" = 0,
                             "3-8% from biomass" = 1, 
                             "3-15% from coal, natural gas, fuel oil" = 2,
                             "10-15% from transportation" = 3,
                             "12-15% from oil, gas and steel processing" = 4,
                             "~20% from cement" = 5,
                             "99,9-100% from ethylene oxide, ammonia, natural gas and biogass fermentation" = 6
                             )),
               
    selectInput("ipCapturability", 
                 label = "Capturability of CO2", 
                 choices = c("All capturabilities" = 0,
                             "Not feasible" = 1,
                             "Future potential" = 2,
                             "Now possible" = 3,
                             "Now present" = 4
                           )),
    
    #This part provides the summaries
    br(),
    h2("Selection summary"),
    br(),
    textOutput("amountOf1"), br(),
    textOutput("total1"),
    textOutput("PctCapturable1"),
    textOutput("PctCaptured1"), br(),
    textOutput("average1"),
    textOutput("highest1"),
    textOutput("lowest1")
    
    )
  ) 
)
