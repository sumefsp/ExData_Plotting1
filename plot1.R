## This script creates a png file of the plot of Global Active Power from the dataset of 
## UC Irvine Machine Learning Repository named "Individual household electric power consumption Data Set".

## loads the required library
library(sqldf)

## downloads the dataset
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile="./exdata_data_household_power_consumption.zip", method="curl")

## lists the contents of the zip file and reads the required data
fileContents <- unzip(zipfile="./exdata_data_household_power_consumption.zip", list=T)
unzip("./exdata_data_household_power_consumption.zip")
requiredData <- read.csv.sql(fileContents$Name, sep=";", header=T, sql='select * from file where Date = "1/2/2007" or Date = "2/2/2007"')

## converts the Date and Time to appropriate data types
requiredData[, 1] <- as.Date(requiredData[, 1], format="%d/%m/%Y")
requiredData[, 2] <- as.POSIXct(requiredData[, 2], format="%H:%M:%S")

## opens the graphics device
png(filename="./plot1.png", height = 480, width = 480, units="px")

## create the plot and required annotations
hist(requiredData$Global_active_power, col="red", main=NULL, xlab=NULL)
title(main="Global Active Power", xlab="Global Active Power (kilowatts)")

## closes the graphics device
dev.off()