library(sqldf)

fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile="./exdata_data_household_power_consumption.zip", method="curl")
fileContenets <- unzip(zipfile="./exdata_data_household_power_consumption.zip", list=T)
unzip("./exdata_data_household_power_consumption.zip")
requiredData <- read.csv.sql(fileContenets$Name, sep=";", header=T, sql='select * from file where Date = "1/2/2007" or Date = "2/2/2007"')
requiredData[, 1] <- as.Date(requiredData[, 1], format="%d/%m/%Y")
requiredData[, 2] <- as.POSIXct(requiredData[, 2], format="%H:%M:%S")

png(filename="./plot1.png", height = 480, width = 480, units="px")
hist(requiredData$Global_active_power, col="red", main=NULL, xlab=NULL)
title(main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()