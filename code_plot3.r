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


#creating new date for getting data in minutes
newdate <- with(electrivityConsumption, ymd(as.Date(Date, tryFormats = c("%d/%m/%Y"), optional = FALSE)) + hms(Time))

# spanning data over minutes
newtime <- difftime(newdate, as.Date("2007-01-01", tryFormats = c("%Y-%m-%d"), units=c("mins")))/60

# plotting the graph to png
png(file = "plot3.png", width=480, height=480)
plot(as.numeric(newtime),electrivityConsumption$Sub_metering_1,pch=124 ,ylim=c(0, 30),xlab="time (in mins) between 2 days", ylab="Sub_metering", col ="black")
points(as.numeric(newtime), electrivityConsumption$Sub_metering_2,pch=124 , col ="red")
points(as.numeric(newtime), electrivityConsumption$Sub_metering_3,pch=124, col ="blue")
legend("topright" ,pch=1, col=c("black" , "red", "blue") , legend =  c("Sub_metering_1" ,"Sub_metering_2", "Sub_metering_3"))
#Closing
dev.off()
