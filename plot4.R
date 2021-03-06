
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

electric_consumption2 <- mutate(electric_consumption2, complete_date = as.POSIXct(ymd_hms(paste(Date, Time))))

#plot3
#Prepare for having 4 plots in the same window
par(mfrow = c(2, 2)) # organized by rows, 2 rows, 2 columns. When adding plots, it goes from top left to right to buttom left to right

#Graph #1
with(electric_consumption2, plot(Global_active_power ~ complete_date, type = "l", ylab = "Global Active Power", xlab = "", cex = 0.8))

#Graph #2
with(electric_consumption2, plot(Voltage ~ complete_date, type = "l", ylab = "Voltage", xlab = "DateTime", cex = 0.8))

#Graph #3
with(electric_consumption2, plot(Sub_metering_1 ~ complete_date, type = "l", ylab = "Energy Sub Metering", xlab = "", cex = 0.8))
with(electric_consumption2, lines(Sub_metering_2~complete_date, col = 'Red'))
with(electric_consumption2, lines(Sub_metering_3~complete_date, col = 'Blue'))

legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.8)

# Graph #4
#Graph #2
with(electric_consumption2, plot(Global_reactive_power ~ complete_date, type = "l", ylab = "Global_reactive_power", xlab = "DateTime", cex = 0.8))


## export file
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()

