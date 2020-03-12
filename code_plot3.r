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


#creating new date for getting data in minutes
newdate <- strptime(paste(electrivityConsumption$Date, electrivityConsumption$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 


# plotting the graph to png
png(file = "plot3.png", width=480, height=480)
plot(as.numeric(newdate),electrivityConsumption$Sub_metering_1,type="l" ,ylim=c(0, 30),xlab="time (in mins) between 2 days", ylab="Sub_metering", col ="black")
points(as.numeric(newdate), electrivityConsumption$Sub_metering_2,type="l" , col ="red")
points(as.numeric(newdate), electrivityConsumption$Sub_metering_3,type="l" , col ="blue")
legend("topright" , pch =95, col=c("black" , "red", "blue") , legend =  c("Sub_metering_1" ,"Sub_metering_2", "Sub_metering_3"))
#Closing
dev.off()
