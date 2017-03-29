# John Koegel
# Exploratory Data Anlalysis: Week 1 Plot 4 Code

library(dplyr)
library(ggplot2)

# Set Working Directory
setwd("~/Google Drive/Development/R/Coursera/Hopkins Data Science Specialization/Exploratory Data Analysis/Week 1 Project")
dataDir <- paste(getwd(),"/data/",sep = "")
# Download Data
if (!file.exists(".data")) {
        dir.create("~/Google Drive/Development/R/Coursera/Hopkins Data Science Specialization/Exploratory Data Analysis/Week 1 Project/data")
}
# rawDataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# download.file(rawDataURL, destfile = "~/Google Drive/Development/R/Coursera/Hopkins Data Science Specialization/Week 1 Project/data.zip", method= "auto")
# unzip(zipfile="~/Google Drive/Development/R/Coursera/Hopkins Data Science Specialization/Exploratory Data Analysis/Week 1 Project/data.zip",exdir = "data")

# Read in Data from 2007-02-01 & 2007-02-02
raw <- read.delim(paste(dataDir,"household_power_consumption.txt",sep =""), header = TRUE, sep=";", stringsAsFactors = FALSE)
rawTbl <- tbl_df(raw)
rm(raw)

# Set data types to proper types
power <- rawTbl %>% filter(Global_reactive_power != "?") %>% mutate(Date = as.Date(Date,"%d/%m/%Y"), Global_active_power = as.numeric(as.character(Global_active_power)), Global_reactive_power = as.numeric(as.character(Global_reactive_power)), Voltage = as.numeric(as.character(Voltage)),Global_intensity = as.numeric(as.character(Global_intensity)), Sub_metering_1 = as.numeric(as.character(Sub_metering_1)), Sub_metering_2 = as.numeric(as.character(Sub_metering_2)), Sub_metering_3 = as.numeric(as.character(Sub_metering_3)))
power <- subset(power, Date == '2007-02-01' | Date == '2007-02-02')
power["DateTime"] <- apply(power,1,function(x) strptime(paste(as.character(power$Date),as.character(power$Time)),"%Y-%m-%d %H:%M:%S"))
rm(rawTbl)

# Construct plot
png('Plot4.png')
par(mfrow = c(2,2))
with(power,plot(power$DateTime, power$Global_active_power, type="l", lwd=1, col="black",  ylab = "Global Active Power (kilowatts)", xlab = ""))
with(power,plot(power$DateTime, power$Voltage, type="l", lwd=1, col="black",  ylab = "Voltage", xlab = "datetime"))
with(power, plot(power$DateTime,power$Sub_metering_1, ylab="Energy sub metering", xlab="", type="n"))
        with(lines(power$DateTime, power$Sub_metering_1, type="l", lwd=1, col="black"))
        with(lines(power$DateTime, power$Sub_metering_2, type="l", lwd=1, col="red"))
        with(lines(power$DateTime, power$Sub_metering_3, type="l", lwd=1, col="blue"))
        legend("topright", pch = 1, col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(power,plot(power$DateTime, power$Global_reactive_power, type="l", lwd=1, col="black",  ylab = "Global_reactive_power", xlab = "datetime"))
dev.off()
