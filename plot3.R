library(sqldf)

fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile="./exdata_data_household_power_consumption.zip", method="curl")
fileContenets <- unzip(zipfile="./exdata_data_household_power_consumption.zip", list=T)
unzip("./exdata_data_household_power_consumption.zip")
requiredData <- read.csv.sql(fileContenets$Name, sep=";", header=T, sql='select * from file where Date = "1/2/2007" or Date = "2/2/2007"')
requiredData[, 1] <- as.character(requiredData[, 1])
requiredData[, 2] <- as.character(requiredData[, 2])
dtChar <- paste(requiredData[, 1], requiredData[, 2])
dt <- strptime(dtChar, "%d/%m/%Y %H:%M:%S")

png(filename="./plot3.png", height = 480, width = 480, units="px")
plot(dt, requiredData$Sub_metering_1, pch=".", type="l", main=NULL, xlab="", ylab="Energy sub metering")
lines(dt, requiredData$Sub_metering_2, col="red")
lines(dt, requiredData$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()