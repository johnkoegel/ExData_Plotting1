# John Koegel
# Exploratory Data Anlalysis: Week 1 Plot 1 Code

library(dplyr)

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
power <- rawTbl %>% filter(Global_reactive_power != "?") %>% mutate(Date = as.Date(Date,"%d/%m/%Y"), Time = as.Date(Time, "%H:%M:%S"), Global_active_power = as.numeric(as.character(Global_active_power)), Global_reactive_power = as.numeric(as.character(Global_reactive_power)), Voltage = as.numeric(as.character(Voltage)),Global_intensity = as.numeric(as.character(Global_intensity)), Sub_metering_1 = as.numeric(as.character(Sub_metering_1)), Sub_metering_2 = as.numeric(as.character(Sub_metering_2)), Sub_metering_3 = as.numeric(as.character(Sub_metering_3)))
power <- subset(power, Date == '2007-02-01' | Date == '2007-02-02')
rm(rawTbl)
# Construct plot
png('Plot1.png')
hist(power$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()