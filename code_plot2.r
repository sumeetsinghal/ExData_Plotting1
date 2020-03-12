#install.packages("dplyr")
#install.packages("lubridate")

library(dplyr)
library(datasets)
library(lubridate)


# this is execution of the main code


path <- "/Users/sumeetsinghal/sumeet/Coursera/dataexplorationweek1"
setwd(path)
getwd()

#Convert char into date
date1 <- as.Date("01/02/2007", tryFormats = c("%d/%m/%Y"), optional = FALSE)
date2 <- as.Date("02/02/2007", tryFormats = c("%d/%m/%Y"), optional = FALSE)

# read the txt file 
electrivityConsumption <- read.csv("household_power_consumption.txt", header = T, stringsAsFactors=F , sep=";" , colClasses = c("Global_intensity"= "character")   )
#and filter by date
electrivityConsumption <- subset(electrivityConsumption,(as.Date(Date, tryFormats = c("%d/%m/%Y"), optional = FALSE) == date1 | as.Date(Date, tryFormats = c("%d/%m/%Y"), optional = FALSE) == date2) & !is.na(Global_intensity) & !is.na(Time))


# Converting the global intensity to numeric
as.numeric(electrivityConsumption$Global_intensity)

# plotting the graph to png
png(file = "plot2.png", width=480, height=480)



#creating new date for getting data in minutes
newdate <- strptime(paste(electrivityConsumption$Date, electrivityConsumption$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 


plot(newdate,electrivityConsumption$Global_active_power , type="l" , ylim=c(0, 6) ,xlab="time (in mins) between 2 days", ylab="Global_intensity") 
#Closing
dev.off()
