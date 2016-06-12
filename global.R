######################### Constant variables #########################

#load dataframe and construct some necessary variables
dataframe <- read.csv("data/NewData.csv", stringsAsFactors=FALSE)
dataframe$Quantity <- dataframe$Quantity * 100

#compile a list of countries and facility names
countryList <- append("All countries",sort(unique(dataframe$Country)))
facilityList <- c(dataframe$Facility)