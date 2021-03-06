
library(reshape2)
library(lubridate)
library(data.table)
library(dplyr)
library(grDevices)

rm(list = ls())

electric_consumption_route <- "./data/Projectw1_Course4/household_power_consumption.txt"
#Read the file indication the separator character and making the first row the variables names
electric_consumption <- read.table(electric_consumption_route, na.strings = "?", header = TRUE, sep = ";")
#converts the date (first column) in date format
electric_consumption$Date <- dmy(electric_consumption$Date)

date_interval_minor <- dmy("01022007")
date_interval_major <- dmy("02022007")

#select only the data conteined between dates 01/02/2017 and 02/02.2017
electric_consumption2 <- filter(electric_consumption, Date >= date_interval_minor, Date <= date_interval_major)

electric_consumption2$Global_active_power <- as.character(electric_consumption2$Global_active_power)
electric_consumption2$Global_active_power <- as.numeric(electric_consumption2$Global_active_power)
electric_consumption2$Sub_metering_1 <- as.character(electric_consumption2$Sub_metering_1)
electric_consumption2$Sub_metering_1 <- as.numeric(electric_consumption2$Sub_metering_1)
electric_consumption2$Sub_metering_2 <- as.character(electric_consumption2$Sub_metering_2)
electric_consumption2$Sub_metering_2 <- as.numeric(electric_consumption2$Sub_metering_2)
electric_consumption2$Sub_metering_3 <- as.character(electric_consumption2$Sub_metering_3)
electric_consumption2$Sub_metering_3 <- as.numeric(electric_consumption2$Sub_metering_3)

electric_consumption2 <- mutate(electric_consumption2, complete_date = as.POSIXct(ymd_hms(paste(Date, Time))))

#plot3
with(electric_consumption2, plot(Sub_metering_1 ~ complete_date, type = "l", ylab = "Energy Sub Metering", xlab = "", cex = 0.8))
with(electric_consumption2, lines(Sub_metering_2~complete_date, col = 'Red'))
with(electric_consumption2, lines(Sub_metering_3~complete_date, col = 'Blue'))

legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.8)

## export file
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()

