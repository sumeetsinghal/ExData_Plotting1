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
date1 <- as.Date("01/01/2007", tryFormats = c("%d/%m/%Y"), optional = FALSE)
date2 <- as.Date("02/01/2007", tryFormats = c("%d/%m/%Y"), optional = FALSE)

# read the txt file 
electrivityConsumption <- read.csv("household_power_consumption.txt", header = T, stringsAsFactors=F , sep=";" , colClasses = c("Global_intensity"= "character")   )
#and filter by date
electrivityConsumption <- subset(electrivityConsumption,(as.Date(Date, tryFormats = c("%d/%m/%Y"), optional = FALSE) == date1 | as.Date(Date, tryFormats = c("%d/%m/%Y"), optional = FALSE) == date2) & !is.na(Global_intensity) & !is.na(Time))


# Converting the global intensity to numeric
as.numeric(electrivityConsumption$Global_intensity)

# plotting the graph to png
png(file = "plot2.png", width=480, height=480)

#creating new date for getting data in minutes
newdate <- with(electrivityConsumption, ymd(as.Date(Date, tryFormats = c("%d/%m/%Y"), optional = FALSE)) + hms(Time))

# spanning data over minutes
newtime <- difftime(newdate, as.Date("2007-01-01", tryFormats = c("%Y-%m-%d"), units=c("mins")))/60


plot(as.numeric(newtime),electrivityConsumption$Global_intensity ,pch=124 , ylim=c(1, 6), xlim=c(0,2880) ,xlab="time (in mins) between 2 days", ylab="Global_intensity") 
#Closing
dev.off()
