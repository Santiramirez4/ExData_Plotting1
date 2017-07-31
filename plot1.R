
library(reshape2)
library(lubridate)
library(data.table)
library(dplyr)
library(grDevices)

rm(list = ls())

electric_consumption_route <- "./data/Projectw1_Course4/household_power_consumption.txt"
#Read the file indication the separator character and making the first row the variables names
electric_consumption <- read.table(electric_consumption_route, header = TRUE, sep = ";")
#converts the date (first column) in date format
electric_consumption$Date <- dmy(electric_consumption$Date)

date_interval_minor <- dmy("01022007")
date_interval_major <- dmy("02022007")

#select only the data conteined between dates 01/02/2017 and 02/02.2017
electric_consumption2 <- filter(electric_consumption, Date >= date_interval_minor, Date <= date_interval_major)

#Change format of time
electric_consumption2$Time <- hms(electric_consumption2$Time)

electric_consumption2$Global_active_power <- as.character(electric_consumption2$Global_active_power)
electric_consumption2$Global_active_power <- as.numeric(electric_consumption2$Global_active_power)

electric_consumption3 <- arrange(electric_consumption2, Date, Time)

## Plot 1
hist(electric_consumption2$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red", cex.sub = 0.8)

## export file
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()

