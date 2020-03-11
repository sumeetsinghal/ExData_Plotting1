#install.packages("dplyr")
#install.packages("lubridate")

library(dplyr)

library(lubridate)


# this is execution of the main code


path <- "/Users/sumeetsinghal/sumeet/Coursera/dataexplorationweek1"
setwd(path)
getwd()

#Convert char into date
date1 <- as.Date("01/01/2007", tryFormats = c("%d/%m/%Y"), optional = FALSE)
date2 <- as.Date("02/01/2007", tryFormats = c("%d/%m/%Y"), optional = FALSE)

# read the txt file 
electrivityConsumption <- read.csv("household_power_consumption.txt", header = T, stringsAsFactors=F , sep=";" , colClasses = c("Global_intensity"= "character")   )
#and filter by date
electrivityConsumption <- subset(electrivityConsumption,(as.Date(Date, tryFormats = c("%d/%m/%Y"), optional = FALSE) == date1 | as.Date(Date, tryFormats = c("%d/%m/%Y"), optional = FALSE) == date2) & !is.na(Global_intensity) & !is.na(Time))


# plotting the graph to png
png(file = "plot1.png", width=480, height=480)
hist(as.numeric(electrivityConsumption$Global_intensity), col="red", xlab="Global_intensity")
#Closing the file
dev.off()
